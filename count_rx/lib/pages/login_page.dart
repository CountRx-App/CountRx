import 'package:count_rx/components/flexible_button.dart';
import 'package:count_rx/managers/auth_manager.dart';
import 'package:count_rx/pages/home_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:learning_input_image/learning_input_image.dart';

class LoginPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const LoginPage({
    super.key,
    required this.cameras,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter an email address";
                    } else if (!EmailValidator.validate(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    hintText: "Enter an email address",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a password";
                    } else if (value.length < 6) {
                      return "Password must be greater than 6 characters in length";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    hintText: "Enter a password",
                  ),
                ),
                const SizedBox(height: 40),
                FlexibleButton(
                  onClick: () async {
                    if (_formKey.currentState!.validate()) {
                      final isSuccessful = await AuthManager.instance
                          .loginExistingUserWithEmailPassword(
                        context: context,
                        emailAddress: emailController.text,
                        password: passwordController.text,
                      );

                      if (isSuccessful) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return HomePage(
                                currentUser: AuthManager.instance.email,
                                cameras: cameras,
                              );
                            },
                          ),
                        );
                      }
                    }
                  },
                  buttonText: "Login",
                ),
                const SizedBox(height: 15),
                FlexibleButton(
                  hollowButton: true,
                  onClick: () {
                    if (_formKey.currentState!.validate()) {
                      AuthManager.instance.createUserWithEmailPassword(
                        context: context,
                        emailAddress: emailController.text,
                        password: passwordController.text,
                      );
                    }
                  },
                  buttonText: "Sign Up",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
