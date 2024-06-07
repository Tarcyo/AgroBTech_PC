import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;

  const RoundedTextField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500, // Aumentando a largura
      height: 20, // Ajustando a altura
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0), // Ajustando o raio
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
        child: TextField(
          controller: controller,
          textAlignVertical: TextAlignVertical.center, // Alinhando texto verticalmente ao centro
          textAlign: TextAlign.start, // Alinhando texto horizontalmente à esquerda
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '', // Texto de dica
          ),
          keyboardType: TextInputType.multiline, // Habilitando teclado de várias linhas
          style: TextStyle(fontSize: 14, color: Colors.grey[900]), // Configurando estilo do texto
        ),
      ),
    );
  }
}