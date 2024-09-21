import 'package:flutter/material.dart';
import 'package:midas/constants.dart';
import 'package:midas/reusableWidgets/product card.dart';

class AllBuyActivitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        iconTheme: IconThemeData(color: Colors.white), // Define a cor do ícone como branco
        title: Center(child: Text('Compra', style: TextStyle(color: Colors.white))), // Define a cor do texto como branco
      ),
      body: Container(
        color: secondaryColor, // Define a cor de fundo como verde
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  ProductCard(
                    productName: "CCMU24",
                    textColor: Colors.black,
                    price: "R\$ 129.28",
                    backgroundColor: Colors.white,
                    color: mainColor,
                  ),
                  SizedBox(width: 10),
                  ProductCard(
                    productName: "CCMU24",
                    textColor: Colors.black,
                    price: "R\$ 129.28",
                    backgroundColor: Colors.white,
                    color: mainColor,
                  ),
                  SizedBox(width: 10),
                  ProductCard(
                    productName: "CCMU24",
                    textColor: Colors.black,
                    price: "R\$ 129.28",
                    backgroundColor: Colors.white,
                    color: mainColor,
                  ),
                  SizedBox(width: 10),
                  ProductCard(
                    productName: "CCMU24",
                    textColor: Colors.black,
                    price: "R\$ 129.28",
                    backgroundColor: Colors.white,
                    color: mainColor,
                  ),
                  SizedBox(width: 10),
                  ProductCard(
                    productName: "CCMU24",
                    textColor: Colors.black,
                    price: "R\$ 129.28",
                    backgroundColor: Colors.white,
                    color: mainColor,
                  ),
                  SizedBox(width: 10),
                  ProductCard(
                    productName: "CCMU24",
                    textColor: Colors.black,
                    price: "R\$ 129.28",
                    backgroundColor: Colors.white,
                    color: mainColor,
                  ),
                  SizedBox(width: 10),
                  ProductCard(
                    productName: "CCMU24",
                    textColor: Colors.black,
                    price: "R\$ 129.28",
                    backgroundColor: Colors.white,
                    color: mainColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}