import 'package:flutter/material.dart';

class FixedTextContainer extends StatelessWidget {
  final String text;

  const FixedTextContainer({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1100, // Aumentando a largura
      height: 40, // Ajustando a altura
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(180.0), // Ajustando o raio
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // Alterando posição da sombra
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[900],
          ),
        ),
      ),
    );
  }
}
