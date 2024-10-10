import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters; 

  const RoundedTextField({
    Key? key,
    required this.controller,
    required this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500, 
      height: 20, // Ajustei a altura para melhor espaçamento vertical
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), 
          ),
        ],
      ),
      child: Center(
        child: TextField(
          controller: controller,
          textAlignVertical: TextAlignVertical.center, // Centraliza verticalmente
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '', 
            contentPadding: EdgeInsets.only(left: 5, top: 10, bottom: 10), // Espaçamento da borda esquerda
          ),
          keyboardType: TextInputType.multiline,
          inputFormatters: inputFormatters, 
          style: TextStyle(fontSize: 13, color: Colors.grey[900]),
        ),
      ),
    );
  }
}
