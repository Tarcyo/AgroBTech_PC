import 'package:flutter/material.dart';
import 'package:agro_bio_tech_pc/constants.dart';
import 'package:agro_bio_tech_pc/reusableWidgets/editCardList.dart';
import 'package:provider/provider.dart';
import 'package:agro_bio_tech_pc/providers/fileNameProvider.dart';
import '../createFileScreen/selectTypeScreen.dart';

class DraftScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: secondaryColor,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
                width: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Criar novo',
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 25.0,
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      IconButton(
                        onPressed: () {
                          // Navegue para a RegisterScreen quando o botão for pressionado
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 600),
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
                                return SelectTypeScreen();
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: mainColor,
                          size: 33,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (Provider.of<FileNameProvider>(listen: true, context)
                          .nomesRascunhos
                          .isNotEmpty)
                        Consumer<FileNameProvider>(
                          builder: (context, counterProvider, child) {
                            return EditCardList(counterProvider.nomesRascunhos);
                          },
                        )
                      else
                        Center(
                          child: Text(
                            "Nenhum rascunho encontrado!",
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
