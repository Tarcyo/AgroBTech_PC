import 'package:flutter/material.dart';
import 'package:midas/constants.dart';

class VeryLargeFixedTextWidget extends StatelessWidget {
  final String text;

  const VeryLargeFixedTextWidget({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0, // Define a posição superior
      left: 0, // Define a posição esquerda
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            width: double.infinity, // Largura adaptativa
            height: 40,
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(180.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(children: [
              SizedBox(width: 20,),
              Text(
                text,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ]),
          );
        },
      ),
    );
  }
}
