import 'package:flutter/material.dart';
import 'package:agro_bio_tech_pc/constants.dart';
import 'controleDeQualidade/controleDeQualidade.dart';
import 'sanidadeDeSementes/sanidadeDeSementes.dart';
import 'diagnose/diagnose.dart';
import 'diferenciacaoDeRaca/diferenciaçãoDeRaça.dart';
import 'laudoMicrobiológico/laudoMicrobiológico.dart';
import 'laudoNematológico/laudoNematológico.dart';

String selectedLaudo = 'Controle de qualidade';

class SelectTypeScreen extends StatefulWidget {
  @override
  State<SelectTypeScreen> createState() => _SelectTypeScreenState();
}

class _SelectTypeScreenState extends State<SelectTypeScreen> {
  final List<String> _laudoOptions = [
    'Controle de qualidade',
    'Sanidade de sementes',
    'Laudo Nematológico',
    'Laudo Raça de nematóides',
    'Laudo Microbiológico',
    'Laudo Diagnose',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: secondaryColor,
        child: Column(
          children: [
            // Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Center(
                child: Text(
                  "Bem vindo ao Gerador de Laudos",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (selectedLaudo ==
                                          'Controle de qualidade') {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            transitionDuration: Duration.zero,
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) {
                                              return ControleDeQualidade("");
                                            },
                                          ),
                                        ).then((value) {
                                          if (value == 1) {
                                            Navigator.of(context).pop();
                                          }
                                        });
                                      }
                                      if (selectedLaudo ==
                                          'Sanidade de sementes') {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            transitionDuration: Duration.zero,
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) {
                                              return SanidadeDeSementes("");
                                            },
                                          ),
                                        );
                                      }
                                      if (selectedLaudo == 'Laudo Diagnose') {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            transitionDuration: Duration.zero,
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) {
                                              return Diagnose("");
                                            },
                                          ),
                                        );
                                      }
                                      if (selectedLaudo ==
                                          'Laudo Raça de nematóides') {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            transitionDuration: Duration.zero,
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) {
                                              return DifereciacaoDeRaca("");
                                            },
                                          ),
                                        );
                                      }
                                      if (selectedLaudo ==
                                          'Laudo Microbiológico') {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            transitionDuration: Duration.zero,
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) {
                                              return Microbiologico("");
                                            },
                                          ),
                                        );
                                      }
                                      if (selectedLaudo ==
                                          'Laudo Nematológico') {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            transitionDuration: Duration.zero,
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) {
                                              return LaudoNematologico("");
                                            },
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: mainColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(180.0),
                                      ),
                                      minimumSize: Size(150, 50),
                                    ),
                                    child: Row(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Próximo",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            SizedBox(width: 3),
                                            Icon(Icons.arrow_forward_ios,
                                                color: Colors.white, size: 20),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: 30),
                            ],
                          )
                        ],
                      ),
                      Center(
                        child: SizedBox(
                          width: 600,
                          child: Card(
                            color: mainColor,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                              side: BorderSide(color: mainColor, width: 10),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Selecione o tipo de laudo:",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  ),
                                  DropdownButton<String>(
                                    value: selectedLaudo,
                                    icon: Icon(Icons.arrow_downward),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.blueAccent,
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedLaudo = newValue!;
                                      });
                                    },
                                    items: _laudoOptions
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 1),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}