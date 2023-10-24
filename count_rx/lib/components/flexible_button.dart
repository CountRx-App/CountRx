import 'package:flutter/material.dart';

class FlexibleButton extends StatelessWidget {
  final String buttonText;
  final void Function() onClickCallback;

  const FlexibleButton({
    super.key,
    required this.buttonText,
    required this.onClickCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: 250.0,
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextButton(
        onPressed: onClickCallback,
        child: Text(buttonText),
      ),
    );
  }
}
