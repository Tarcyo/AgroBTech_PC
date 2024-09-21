import 'package:flutter/material.dart';
import 'package:midas/constants.dart';
import 'package:midas/pages/group/groupScreen.dart';
import 'package:midas/reusableWidgets/insertCamp.dart';

class GroupCard extends StatelessWidget {
  final String groupName;
  final int newMessages;
  final List<Widget> members;

  GroupCard({
    required this.groupName,
    required this.newMessages,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    dynamic exit = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddUserDialog();
                      },
                    );
                    print(exit);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 60,
                        color: mainColor,
                      ),
                      Icon(
                        Icons.add,
                        size: 30,
                        color: mainColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 60,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 1, 1, 1),
              child: SingleChildScrollView(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(182),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(180),
                          border: Border.all(
                            color: mainColor,
                            width: 2,
                          ),
                        ),
                        width: double.infinity,
                        padding: EdgeInsets.all(25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      groupName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: mainColor,
                                        fontSize: 24.0,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 3),
                              ],
                            ),
                            WidgetRow(
                                nomeGrupo: this.groupName,
                                widgets: [...members]),
                            Text(
                              "5 novas mensagens",
                              style: TextStyle(fontSize: 20, color: mainColor),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Conversar",
                                      style: TextStyle(
                                        color: mainColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.chat,
                                        size: 40,
                                        color: mainColor,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            transitionDuration:
                                                Duration(milliseconds: 1200),
                                            transitionsBuilder:
                                                (BuildContext context,
                                                    Animation<double> animation,
                                                    Animation<double>
                                                        secondaryAnimation,
                                                    Widget child) {
                                              return FadeTransition(
                                                opacity: animation,
                                                child: child,
                                              );
                                            },
                                            pageBuilder: (BuildContext context,
                                                Animation<double> animation,
                                                Animation<double>
                                                    secondaryAnimation) {
                                              return GroupScreen(groupName);
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 3),
          ],
        ),
      ],
    );
  }
}

class WidgetRow extends StatefulWidget {
  final List<Widget> widgets;
  final String nomeGrupo;

  WidgetRow({required this.widgets, required this.nomeGrupo});

  @override
  _WidgetRowState createState() => _WidgetRowState();
}

class _WidgetRowState extends State<WidgetRow> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> displayedWidgets = [];
    List<Widget> additionalWidgets = [];

    if (widget.widgets.length <= 5) {
      displayedWidgets = widget.widgets;
    } else {
      displayedWidgets = widget.widgets.sublist(0, 5);
      additionalWidgets = widget.widgets.sublist(5);
    }

    return Row(
      children: [
        ...displayedWidgets,
        if (additionalWidgets.isNotEmpty) ...[
          TextButton(
            onPressed: () {
              setState(() {
                isExpanded = true;
              });
              _showAdditionalWidgets(context,
                  displayedWidgets + additionalWidgets, widget.nomeGrupo);
            },
            child: Text(
              '+${additionalWidgets.length}',
              style: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _showAdditionalWidgets(
      BuildContext context, List<Widget> additionalWidgets, String grupo) {
    List<Widget> format = [];
    for (Widget w in additionalWidgets) {
      format.add(Row(
        children: [
          w,
          SizedBox(
            width: 5,
          ),
          Text(
            "Nome",
            style: TextStyle(
              fontSize: 20,
              color: mainColor,
            ),
          ),
        ],
      ));
      format.add(Divider(
        color: Colors.grey,
      ));
      format.add(SizedBox(
        height: 100,
      ));
    }
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        widget.nomeGrupo,
                        style: TextStyle(color: mainColor, fontSize: 30),
                      ),
                      Text("Membros:"),
                    ],
                  ),
                  ...format
                ],
              ),
            ),
          ),
        );
      },
    ).then((value) {
      setState(() {
        isExpanded = false;
      });
    });
  }
}

class AddUserDialog extends StatelessWidget {
  final TextEditingController _newUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(180.0), // Ajustando o raio da borda do dialog
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFF00C2A0), // Definindo a cor de fundo como verde
          borderRadius: BorderRadius.circular(20), // Raio da borda do Container
          border: Border.all(
            // Adicionando uma borda ao redor do conteúdo
            color: Colors.white, // Definindo a cor da borda como azul
            width: 4.0, // Ajustando a largura da borda conforme necessário
          ),
        ),
        constraints: BoxConstraints(
            maxWidth: 350, // Definindo o tamanho máximo do Container
            minWidth: 150, // Definindo um tamanho mínimo opcional
            maxHeight: 250, // Ajustando a altura máxima conforme necessário
            minHeight: 250 // Definindo uma altura mínima opcional
            ), // Reduzindo o tamanho máximo do Container
        child: contentBox(context),
      ),
    );
  }

  Widget contentBox(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                color: Colors.white,
                size: 50,
              ),
              Icon(
                Icons.add,
                color: Colors.white,
                size: 25,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Digite o código do usuário',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20, // Definindo a cor do texto como branco
          ),
          textAlign: TextAlign.center, // Alinhando o texto centralmente
        ),
        SizedBox(height: 20),
        RoundedTextField(controller: _newUrlController),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Alinhando os botões nos cantos opostos
          children: <Widget>[
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18 // Definindo a cor do texto como branco
                      ),
                ),
              ),
            ),
            SizedBox(width: 5), // Adicionando um espaçamento entre os botões
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(_newUrlController.text);
                },
                child: Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Adicionar',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  18 // Definindo a cor do texto como branco
                              // Definindo a cor do texto como branco
                              ),
                        ),
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
