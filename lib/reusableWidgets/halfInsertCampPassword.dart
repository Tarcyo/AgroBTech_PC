import 'package:flutter/material.dart';
import 'package:midas/constants.dart';

class HalfroundedTextFieldPassword extends StatefulWidget {
  final TextEditingController controller;
  final bool obscureText;

  const HalfroundedTextFieldPassword({
    Key? key,
    required this.controller,
    this.obscureText = false,
  }) : super(key: key);

  @override
  _RoundedTextFieldState createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<HalfroundedTextFieldPassword> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // Aumentando a largura
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
      child: Stack(
        alignment: Alignment.centerRight, // Alinhando o ícone à direita
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: TextFormField(
              controller: widget.controller,
              obscureText: _obscureText,
              textAlignVertical: TextAlignVertical
                  .center, // Alinhando texto verticalmente ao centro
              textAlign:
                  TextAlign.start, // Alinhando texto horizontalmente à esquerda
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '', // Texto de dica
              ),
              keyboardType: TextInputType
                  .multiline, // Habilitando teclado de várias linhas
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[900]), // Configurando estilo do texto
            ),
          ),
          Positioned(
            right: 8,
            child: IconButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: _obscureText ? Colors.grey : mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
