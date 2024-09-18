import 'package:flutter/material.dart';

class FixedCamp extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;

  const FixedCamp({Key? key, required this.text, required this.color,required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0, // Define a posição superior
      left: 0, // Define a posição esquerda
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            width: 360, // Largura adaptativa
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(180),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        text,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(icon,size: 30,color: Colors.white,),
                      SizedBox(width: 10,)
                    ],
                  )
                ]),
          );
        },
      ),
    );
  }
}
