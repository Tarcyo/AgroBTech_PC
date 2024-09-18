import 'package:flutter/material.dart';
import 'package:midas/reusableWidgets/veryLargeFixedCamp.dart';
import 'package:midas/constants.dart';

final TextEditingController textController = TextEditingController();

class MyMessage extends StatelessWidget {
  final String text;

  MyMessage(this.text);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween, // alinhe o botão à direita
      children: [
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 16.0),
            child: VeryLargeFixedTextWidget(
              text: text,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: mainColor,
          ),
          padding:
              EdgeInsets.all(18), // Ajuste o preenchimento conforme necessário
          child: Icon(
            Icons.person,
            size: 25,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
