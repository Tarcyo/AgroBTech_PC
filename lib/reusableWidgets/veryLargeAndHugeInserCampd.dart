import 'package:flutter/material.dart';

class VeryLargeInsertCamp extends StatelessWidget {
  final TextEditingController controller;
  final double margin;
  final String text;
  final IconData icon;
  final TextInputType;

  const VeryLargeInsertCamp({
    Key? key,
    required this.controller,
    required this.text,
    required this.icon,
    required this.TextInputType,
    this.margin = 1.0, // Valor padrão de margem
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 45,
            ),
            SizedBox(
              width: 500,
              height: 75,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
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
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.start,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: text,
                      hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 18), // Altera a cor do texto de dica para preto
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0), // Define o padding do conteúdo
                    ),
                    keyboardType: TextInputType,
                    style: TextStyle(fontSize: 15, color: Colors.grey[900]),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15,)
      ],
    );
  }
}
