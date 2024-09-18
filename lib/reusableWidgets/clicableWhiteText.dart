import 'package:flutter/material.dart';
class ClickableWhiteText extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const ClickableWhiteText({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14, // Tamanho da fonte
        ),
      ),
    );
  }
}