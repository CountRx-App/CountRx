import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthManager {
  static final instance = AuthManager._privateConstructor();

  AuthManager._privateConstructor();

  StreamSubscription? _authSubscription;
  User? _user;
  final Map<UniqueKey, Function> _loginObservers = {};
  final Map<UniqueKey, Function> _logoutObservers = {};

  void beginListening() {
    if (_authSubscription != null) {
      return; // Already listening; avoid multiple subscriptions
    }
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      final isLogin = user != null && _user == null;
      final isLogout = user == null && _user != null;

      _user = user;

      if (isLogin) {
        // Inform login observers
        for (final obs in _loginObservers.values) {
          obs();
        }
      } else if (isLogout) {
        // Inform logout observers
        for (final obs in _loginObservers.values) {
          obs();
        }
      }
    });
  }

  void stopListening() {
    _authSubscription?.cancel();
    _authSubscription = null;
  }

  UniqueKey addObserver({required Function observer, required bool isLogin}) {
    // Make map of UniqueKeys to login observers
    beginListening(); // Called if no subscription exists
    UniqueKey key = UniqueKey();
    if (isLogin) {
      _loginObservers[key] = observer;
    } else {
      _logoutObservers[key] = observer;
    }
    return key;
  }

  void removeObserver(UniqueKey? key, {required bool isLogin}) {
    if (isLogin) {
      _loginObservers.remove(key);
    } else {
      _logoutObservers.remove(key);
    }
  }

  void signOut() {
    print("Signed out");
    FirebaseAuth.instance.signOut();
  }

  void _showAuthError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<bool> createUserWithEmailPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("Created new user in firebase");
    } on FirebaseAuthException catch (err) {
      if (err.code == "weak-password") {
        _showAuthError(context, "Given password is too weak");
      } else if (err.code == "email-already-in-use") {
        _showAuthError(context, "Email already in use");
      } else {
        print("$err");
      }

      return false;
    }

    return true;
  }

  Future<bool> logInUserWithEmailPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _showAuthError(context, "Logged in");
    } on FirebaseAuthException catch (err) {
      if (err.code == "Iinvalid-login-credentials") {
        _showAuthError(context, "Incorrect login");
        print(err.code);
      } else if (err.code == "user-not-found") {
        _showAuthError(context, "No account found");
      } else {
        _showAuthError(context, "Invalid login credentials");
        print("$err");
      }

      return false;
    }

    return true;
  }

  bool get isSignedIn => _user != null;
  String get uid => _user?.uid ?? "";
  String get email => _user?.email ?? "";

  // bool get hasDisplayName =>
  //     _user != null &&
  //     _user!.displayName != null &&
  //     _user!.displayName!.isNotEmpty;

  // String get displayName => _user?.displayName ?? "";

  // bool get hasImageUrl =>
  //     _user != null && _user!.photoURL != null && _user!.photoURL!.isNotEmpty;

  // String get imageUrl => _user?.photoURL ?? "";
}
