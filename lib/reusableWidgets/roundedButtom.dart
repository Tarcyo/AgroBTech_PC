import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const RoundedButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240, // Aumentando um pouco a largura do botão para acomodar o ícone
      height: 30, // Reduzindo a altura do botão
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(180), // Bordas arredondadas
        boxShadow: [],
      ),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.all<Color>(Color(0xFF00C2A0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.save, color: Color(0xFF00C2A0)), // Ícone de salvar
            SizedBox(width: 5), // Espaço entre o ícone e o texto
            Text(
              text,
              style: TextStyle(fontSize: 20), // Reduzindo o tamanho da fonte
            ),
          ],
        ),
      ),
    );
  }
}