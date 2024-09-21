import 'package:flutter/material.dart';
import 'veryLargeInserCamp.dart';

class ObservationsList extends StatefulWidget {
  final List<TextEditingController> controllers;

  const ObservationsList({Key? key, required this.controllers})
      : super(key: key);

  @override
  _ObservationsListState createState() => _ObservationsListState();
}

class _ObservationsListState extends State<ObservationsList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> observations = [];

    for (TextEditingController controller in widget.controllers) {
      observations.add(
        VeryLargeInsertCamp(
          controller: controller,
          text: "Digite a observação",
          TextInputType: TextInputType.multiline,
          icon: Icons.assignment,
        ),
      );
    }
    final screenHeight = MediaQuery.of(context).size.height;
    return widget.controllers.isNotEmpty
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...observations,
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            widget.controllers.add(TextEditingController());
                          });
                        },
                        icon: Icon(
                          Icons.add,
                          size: screenHeight * 0.02,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      32.0), // Ajuste o valor conforme desejado
                                ),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Atenção",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                  ],
                                ),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Deseja excluir a ultima linha?",
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(180.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            widget.controllers.removeLast();
                                          });
                                          Navigator.of(context).pop();
                                          // Implementar aqui a lógica para sair
                                        },
                                        child: Text(
                                          "Sim",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(180.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          // Fechar o diálogo sem sair
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          "Não",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.remove,
                          size: screenHeight * 0.02,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        : Center(
            child: Column(
              children: [
                Text(
                  "Nenhuma observação adicionada",
                  style: TextStyle(fontSize: screenHeight * 0.02),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        widget.controllers.add(TextEditingController());
                      });
                    },
                    icon: Icon(
                      Icons.add,
                      size: screenHeight * 0.02,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
