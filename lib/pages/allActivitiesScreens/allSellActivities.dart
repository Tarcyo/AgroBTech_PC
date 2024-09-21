import 'package:flutter/material.dart';
import 'package:midas/constants.dart';
import 'package:midas/reusableWidgets/product card.dart';

class AllSellActivitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(child: Text('Venda', style: TextStyle(color: Colors.white))),
        iconTheme: IconThemeData(color: Colors.white), // Define a cor do ícone como branco
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
                    color: Colors.red,
                  ),
                  SizedBox(width: 10),
                  ProductCard(
                    productName: "CCMU24",
                    textColor: Colors.black,
                    price: "R\$ 129.28",
                    backgroundColor: Colors.white,
                    color: Colors.red,
                  ),
                  SizedBox(width: 10),
                  ProductCard(
                    productName: "CCMU24",
                    textColor: Colors.black,
                    price: "R\$ 129.28",
                    backgroundColor: Colors.white,
                    color: Colors.red,
                  ),
                  SizedBox(width: 10),
                  ProductCard(
                    productName: "CCMU24",
                    textColor: Colors.black,
                    price: "R\$ 129.28",
                    backgroundColor: Colors.white,
                    color: Colors.red,
                  ),
                  SizedBox(width: 10),
                  ProductCard(
                    productName: "CCMU24",
                    textColor: Colors.black,
                    price: "R\$ 129.28",
                    backgroundColor: Colors.white,
                    color: Colors.red,
                  ),
                  SizedBox(width: 10),
                  ProductCard(
                    productName: "CCMU24",
                    textColor: Colors.black,
                    price: "R\$ 129.28",
                    backgroundColor: Colors.white,
                    color: Colors.red,
                  ),
                  SizedBox(width: 10),
                  ProductCard(
                    productName: "CCMU24",
                    textColor: Colors.black,
                    price: "R\$ 129.28",
                    backgroundColor: Colors.white,
                    color: Colors.red,
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