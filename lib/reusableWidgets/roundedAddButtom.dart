import 'package:flutter/material.dart';

class RoundedAddButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const RoundedAddButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110, // Reduzindo a largura do botão
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

            Text(
              text,
              style: TextStyle(fontSize: 20), // Reduzindo o tamanho da fonte
            ),
            SizedBox(width: 10,),
            Icon(Icons.add)
          ],
        ),
      ),
    );
  }
}
