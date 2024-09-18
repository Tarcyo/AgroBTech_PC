
import 'package:flutter/material.dart';

class ClickableBlackText extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color corDaBarra;

  const ClickableBlackText({
    Key? key,
    required this.onPressed,
    required this.corDaBarra,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 15, height: 25),
              Stack(
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14, // Tamanho da fonte
                    ),
                  ),
                  
                  Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        height: 4.3,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: corDaBarra,
                          borderRadius: BorderRadius.circular(180.0),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
