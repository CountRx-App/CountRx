import 'package:flutter/material.dart';

class FlexibleButton extends StatelessWidget {
  final String buttonText;
  final void Function() onClick;
  final bool hollowButton;

  const FlexibleButton({
    super.key,
    required this.buttonText,
    required this.onClick,
    this.hollowButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: 250.0,
      decoration: BoxDecoration(
        color: hollowButton
            ? const Color.fromARGB(0, 0, 0, 0)
            : Theme.of(context).colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: Theme.of(context).colorScheme.inversePrimary,
          width: 2.5,
        ),
      ),
      child: TextButton(
        onPressed: onClick,
        child: Text(
          buttonText,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
