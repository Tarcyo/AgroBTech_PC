import 'package:flutter/material.dart';
import 'package:midas/reusableWidgets/veryLargeInserCamp.dart';
import 'package:midas/constants.dart';
import 'MyMessage.dart';

final TextEditingController textController = TextEditingController();

class GroupScreen extends StatefulWidget {
  final String name;
  GroupScreen(this.name);
  @override
  State<GroupScreen> createState() => new _GroupScreenState();
}

List<Widget> _mensagens = [];

class _GroupScreenState extends State<GroupScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: secondaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white), // Define a cor do ícone como branco

        backgroundColor: mainColor,
        title: Text(
          widget.name,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Abra o drawer na parte direita da tela
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.from(_mensagens.reversed),
              ),
            ),
          ),
          Container(
            color: mainColor,
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: VeryLargeInsertCamp(controller: textController),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(8),
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 25,
                      color: mainColor,
                    ),
                    onPressed: () {
                      setState(() {
                        if (textController.text != "") {
                          _mensagens.insert(0, MyMessage(textController.text));
                          textController.text = "";
                          _mensagens.insert(0, SizedBox(height: 30));
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: mainColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sobre o grupo",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    Spacer(),
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.group,
                          color: mainColor,
                          size: 60,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  "Participantes",
                  style: TextStyle(fontSize: 20, color: mainColor),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 26.0),
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: mainColor),
                            child: Icon(
                              Icons.person,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8.0),
                        ],
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        "Nome ",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.0),

                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: mainColor),
                            child: Icon(
                              Icons.person,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8.0),
                        ],
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        "Nome ",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.0),

                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: mainColor),
                            child: Icon(
                              Icons.person,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8.0),
                        ],
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        "Nome ",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.0),

                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: mainColor),
                            child: Icon(
                              Icons.person,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8.0),
                        ],
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        "Nome ",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),

                  SizedBox(height: 26.0),
                  // Repita esta estrutura para cada participante
                ],
              ),
              SizedBox(height: 12.0),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    SizedBox(width: 5.0),
                    Text(
                      "Sair do grupo",
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    SizedBox(width: 8.0),
                    Icon(
                      Icons.exit_to_app,
                      size: 35,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.0),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    SizedBox(width: 5.0),
                    Text(
                      "Adicionar participante",
                      style: TextStyle(fontSize: 20, color: mainColor),
                    ),
                    SizedBox(width: 8.0),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 35,
                          color: mainColor,
                        ),
                        Icon(
                          Icons.add,
                          size: 20,
                          color: mainColor,
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
    );
  }
}
