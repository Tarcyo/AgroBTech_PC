import 'package:flutter/material.dart';
import 'package:midas/constants.dart';
import '../editCommoditie/editCommoditie.dart';
class CommoditieCard extends StatelessWidget {
  final String commodityName;
  final String price1Week;
  final String price24Hours;
  final String price6Minutes;
  final String price3Minutes;
  final String price1Minute;
  final dynamic data;

  CommoditieCard({
    required this.commodityName,
    required this.price1Week,
    required this.price24Hours,
    required this.price6Minutes,
    required this.price3Minutes,
    required this.price1Minute,
    required this.data
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          10, 10, 19, 10), // Adiciona preenchimento à direita
      child: SingleChildScrollView(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(182), // Define o raio dos cantos
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Cor de fundo branca
              borderRadius: BorderRadius.circular(180), // Retângulo arredondado
              border: Border.all(
                color: mainColor, // Cor da borda
                width: 2, // Largura da borda
              ),
            ),
            width: double.infinity, // Para preencher toda a largura da tela
            padding: EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      commodityName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 24.0), // Aumenta o tamanho do texto
                    ),
                    Container(
                      height: 5,
                      width:
                          50, // Defina o comprimento da linha conforme necessário
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(180),
                          color: mainColor
                              .withOpacity(0.7) // Define o raio da borda
                          ),
                    ),
                  ],
                ),
                // Espaçamento entre o nome da commodity e os valores
                _buildInfo("1 sem", price1Week + "%"),
                _buildInfo("24 h", price24Hours + "%"),
                _buildInfo("6 min", price6Minutes + "%"),
                _buildInfo("3 min", price3Minutes + "%"),
                _buildInfo("1 min", price1Minute + "%"),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit_document,
                        size: 40,
                        color: mainColor,
                      ),
                      onPressed: ()async {
                        
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
                              return EditCommoditie(data);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfo(String timeFrame, String price) {
    // Verifica se o preço é negativo
    bool isNegative = price.startsWith('-');

    Color lineColor = isNegative == false ? mainColor : Colors.red[800]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "$timeFrame:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 10),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Text(
              price,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
            // Adiciona a linha verde embaixo da cotação se o preço for negativo
          ],
        ),
        SizedBox(
          height: 2,
        ),
        Container(
          height: 5,
          width: 50, // Defina o comprimento da linha conforme necessário
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(180),
              color: lineColor.withOpacity(0.7) // Define o raio da borda
              ),
        ),
      ],
    );
  }
}
