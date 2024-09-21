import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:midas/constants.dart';
import 'package:midas/reusableWidgets/product%20card.dart';
import 'package:midas/pages/allActivitiesScreens/allBuyActicities.dart';
import 'package:midas/pages/allActivitiesScreens/allSellActivities.dart';

import 'package:midas/reusableWidgets/fixedCamp.dart';
import 'package:midas/reusableWidgets/newsCard.dart';
import 'graphic.dart';
import 'package:midas/pages/expandedGraphic/expandedGraphic.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 35, top: 20, right: 40),
        child: SingleChildScrollView(
          scrollDirection:
              Axis.horizontal, // Definindo o scroll na direção horizontal
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Painel de sugestão",
                    style: TextStyle(fontSize: 25, color: mainColor),
                  ),
                  const SizedBox(height: 20),
                  FixedCamp(
                      text: "Comprar",
                      color: mainColor,
                      icon: Icons.notifications),
                  SizedBox(height: 10),
                  Row(
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
                        price: "R\$ 129.90",
                        color: mainColor,
                        backgroundColor: Colors.white,
                      ),
                      IconButton(
                        onPressed: () {
                          // Navegue para a RegisterScreen quando o botão for pressionado
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 1200),
                              transitionsBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                  Widget child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return AllBuyActivitiesScreen();
                              },
                            ),
                          );
                        },
                        icon: Icon(Icons.pending),
                        iconSize: 40,
                      )
                    ],
                  ),
                  SizedBox(height: 80),
                  FixedCamp(
                      text: "Vender",
                      color: Colors.red[900]!,
                      icon: Icons.warning),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      ProductCard(
                        productName: "OPF ICF",
                        price: "R\$ 129.28",
                        color: Colors.red[900]!,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                      ),
                      SizedBox(width: 10),
                      ProductCard(
                        productName: "FUT CCM",
                        price: "R\$ 129.90",
                        textColor: Colors.black,
                        color: Colors.red[900]!,
                        backgroundColor: Colors.white,
                      ),
                      IconButton(
                     onPressed: () {
                          // Navegue para a RegisterScreen quando o botão for pressionado
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 1200),
                              transitionsBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                  Widget child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return AllSellActivitiesScreen();
                              },
                            ),
                          );
                        },
                        icon: Icon(Icons.pending),
                        iconSize: 40,
                      )
                    ],
                  ),
                  SizedBox(height: 150),
                  Text(
                    "Ativos Sugeridos",
                    style: TextStyle(fontSize: 25, color: mainColor),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      ProductCard(
                        productName: "Açucar",
                        price: "+36%",
                        backgroundColor: mainColor,
                        textColor: Colors.white,
                        color: Colors.transparent,
                      ),
                      SizedBox(width: 20),
                      ProductCard(
                        productName: "Álcool",
                        price: "+6%",
                        textColor: Colors.white,
                        color: Colors.transparent,
                        backgroundColor: mainColor,
                      ),
                      SizedBox(width: 30),
                      ProductCard(
                        productName: "Dólar",
                        price: "-9%",
                        textColor: Colors.white,
                        color: Colors.transparent,
                        backgroundColor: Colors.red[900]!,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      DropdownButton<String>(
                        value: "FUT CCM",
                        items: [
                          DropdownMenuItem<String>(
                            value: "Dias",
                            child: Text('Dias'),
                          ),
                          DropdownMenuItem<String>(
                            value: "Semanas",
                            child: Text('Semanas'),
                          ),
                          DropdownMenuItem<String>(
                            value: "FUT CCM",
                            child: Text('FUT CCM'),
                          ),
                        ],
                        onChanged: (String? value) {
                          // Handle dropdown changes here
                          print('Selected: $value');
                        },
                      ),
                      GestureDetector(
                        child: Graphic(),
                        onTap: () {
                          // Navegue para a RegisterScreen quando o botão for pressionado
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 1200),
                              transitionsBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                  Widget child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return ExpandedGraphic();
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          SizedBox(width: 400),
                          DropdownButton<int>(
                            value: 6,
                            items: List.generate(10, (index) {
                              return DropdownMenuItem<int>(
                                value: index + 1,
                                child: Text((index + 1).toString()),
                              );
                            }),
                            onChanged: (value) {
                              // Handle dropdown changes here
                            },
                          ),
                          SizedBox(width: 20),
                          DropdownButton<String>(
                            value: "Meses",
                            items: [
                              DropdownMenuItem<String>(
                                value: "Dias",
                                child: Text('Dias'),
                              ),
                              DropdownMenuItem<String>(
                                value: "Semanas",
                                child: Text('Semanas'),
                              ),
                              DropdownMenuItem<String>(
                                value: "Meses",
                                child: Text('Meses'),
                              ),
                            ],
                            onChanged: (String? value) {
                              // Handle dropdown changes here
                              print('Selected: $value');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      NewsCard('assets/images/image.jpg'),
                      SizedBox(width: 20),
                      NewsCard('assets/images/soja.jpg'),
                      SizedBox(width: 20),
                      NewsCard('assets/images/senado.jpg'),
                    ],
                  ),
                  SizedBox(height: 30)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
