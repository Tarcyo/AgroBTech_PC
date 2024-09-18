import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String price;
  final Color color;
  final Color backgroundColor;
  final Color textColor;



   const ProductCard({
    Key? key,
    required this.productName,
    required this.price,
    required this.color,
    required this.backgroundColor,
    required this.textColor
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 95,
      decoration: BoxDecoration(
        color: backgroundColor, // Define a cor de fundo como cinza
        border: Border.all(color: color, width: 2), // Define a borda verde e aumenta a espessura para 2 pixels
        borderRadius: BorderRadius.circular(16), // Define a borda arredondada
      ),
      padding: EdgeInsets.all(8), // Adiciona um espaço interno
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            productName,
            style: TextStyle(
              fontSize: 20,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8), // Adiciona um espaço entre o nome do produto e o preço
          Text(
          price, // Formata o preço com duas casas decimais
            style: TextStyle(
              fontSize: 26,
              color: textColor, // Define a cor do texto do preço
            ),
          ),
        ],
      ),
    );
  }
}