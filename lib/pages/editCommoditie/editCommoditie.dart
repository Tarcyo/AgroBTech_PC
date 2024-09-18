import 'package:flutter/material.dart';
import '../../reusableWidgets/insertCamp.dart';

import '../../reusableWidgets/roundedAddButtom.dart';
import '../../reusableWidgets/roundedButtom.dart';

import '../../reusableWidgets/tokenList.dart';
import 'package:provider/provider.dart';
import 'package:midas/providers/clienteProvider.dart';
import 'package:midas/services/commmodittie.dart';
import 'package:midas/services/tokens.dart';
import 'package:midas/services/sites.dart';
import 'package:midas/reusableWidgets/URLList.dart';

import 'package:midas/constants.dart';
import 'package:midas/services/estrategia.dart';

class EditCommoditie extends StatefulWidget {
  final Map<String, dynamic> _data;
  EditCommoditie(this._data);
  @override
  State<EditCommoditie> createState() => _EditCommoditieState(_data);
}

class _EditCommoditieState extends State<EditCommoditie> {
  final TextEditingController commoditieNameController =
      TextEditingController();
  final TextEditingController strategyController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  List<String> _urls = [];
  List<String> _tokens = [];
  _EditCommoditieState(Map<String, dynamic> data) {
    commoditieNameController.text = data['commodity']['name'];
    codeController.text = data['commodity']['code'];
    strategyController.text = data['name'];
    for (final i in data['tokens']) {
      _tokens.add(i["token"]);
    }
    for (final i in data['sites']) {
      _urls.add(i["url"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: secondaryColor,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Column(
                            children: [
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(180.0),
                                  ),
                                  minimumSize: Size(150, 50),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.arrow_back_ios,
                                        color: Colors.white, size: 20),
                                    SizedBox(width: 3),
                                    Text(
                                      "Voltar",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                              )
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Editar commoditie',
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10, height: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nome',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 5, height: 5),
                                      RoundedTextField(
                                          controller: commoditieNameController),
                                    ],
                                  ),
                                  SizedBox(height: 15, width: 5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Código',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      RoundedTextField(
                                          controller: codeController),
                                    ],
                                  ),
                                  SizedBox(height: 15, width: 5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'URL Site(s)',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          UrlList(
                                            strings: _urls,
                                            onTokenRemoved: (token) async {
                                              dynamic exit = await showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return RemoveURLDialog();
                                                },
                                              );
                                              if (exit != null && exit) {
                                                setState(() {
                                                  _urls.remove(token);
                                                });
                                              }
                                            },
                                          ),
                                          SizedBox(width: 15),
                                          RoundedAddButton(
                                              onPressed: () async {
                                                final dynamic exit =
                                                    await showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AddURLDialog();
                                                  },
                                                );
                                                if (exit is String) {
                                                  setState(() {
                                                    _urls.add(exit);
                                                  });
                                                }
                                                print(exit);
                                              },
                                              text: "Novo")
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15, width: 5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tokens',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          TokenList(
                                            strings: _tokens,
                                            onTokenRemoved: (token) async {
                                              dynamic exit = await showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return RemoveTokenDialog();
                                                },
                                              );
                                              if (exit != null && exit) {
                                                setState(() {
                                                  _tokens.remove(token);
                                                });
                                              }
                                            },
                                          ),
                                          SizedBox(width: 15),
                                          RoundedAddButton(
                                              onPressed: () async {
                                                dynamic exit = await showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AddTokenDialog();
                                                  },
                                                );
                                                if (exit is String) {
                                                  if (exit != "") {
                                                    setState(() {
                                                      _tokens.add(exit);
                                                    });
                                                  }
                                                }
                                                print(exit);
                                              },
                                              text: "Novo")
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nome da estratégia',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      RoundedTextField(
                                          controller: strategyController)
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      RoundedButton(
                                          onPressed: () async {
                                            String email =
                                                Provider.of<ClienteProvider>(
                                                        context,
                                                        listen: false)
                                                    .cliente!
                                                    .email;

                                            await registerCommodity(
                                                commoditieNameController.text,
                                                codeController.text,
                                                email);

                                            for (final i in _urls) {
                                              await registerSite(i, i, email);
                                            }

                                            for (final i in _tokens) {
                                              await registerToken(i, email);
                                            }
                                            await updateStrategy(
                                                widget._data['id'],
                                                strategyController.text,
                                                codeController.text,
                                                _tokens,
                                                _urls);
                                          },
                                          text: "Salvar"),
                                      RoundedButton(
                                          onPressed: () async {
                                            dynamic exit = await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return DeleteConfirmationDialog();
                                              },
                                            );
                                            if (exit ?? false) {
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          text: "Excluir"),
                                    ],
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

class RemoveURLDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Ajustando o raio da borda do dialog
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
            maxWidth: 320, // Definindo o tamanho máximo do Container
            minWidth: 100, // Definindo um tamanho mínimo opcional
            maxHeight: 250, // Ajustando a altura máxima conforme necessário
            minHeight: 250 // Definindo uma altura mínima opcional
            ),
        child: contentBox(context),
      ),
    );
  }

  Widget contentBox(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.error,
          color: Colors.white,
          size: 50,
        ),
        SizedBox(height: 20),
        Text(
          'Tem certeza que deseja excluir o site?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20, // Definindo a cor do texto como branco
          ),
          textAlign: TextAlign.center, // Alinhando o texto centralmente
        ),
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
                    fontSize: 18,
                    color: Colors.white, // Definindo a cor do texto como branco
                  ),
                ),
              ),
            ),
            SizedBox(width: 8), // Adicionando um espaçamento entre os botões
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Excluir',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors
                            .white, // Definindo a cor do texto como branco
                      ),
                    ),
                    SizedBox(width: 5), // Espaçamento entre texto e ícone
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30,
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

class AddURLDialog extends StatelessWidget {
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
            maxWidth: 320, // Aumentando o tamanho máximo do Container
            minWidth: 100, // Definindo um tamanho mínimo opcional
            maxHeight: 250, // Ajustando a altura máxima se necessário
            minHeight: 250 // Definindo uma altura mínima opcional
            ),
        child: contentBox(context),
      ),
    );
  }

  Widget contentBox(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.link,
          color: Colors.white,
          size: 50,
        ),
        SizedBox(height: 20),
        Text(
          'Digite a URL do novo site',
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Adicionar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18 // Definindo a cor do texto como branco
                          // Definindo a cor do texto como branco
                          ),
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 25,
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

class RemoveTokenDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Ajustando o raio da borda do dialog
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
            maxWidth: 300, // Definindo o tamanho máximo do Container
            minWidth: 100, // Definindo um tamanho mínimo opcional
            maxHeight: 250, // Ajustando a altura máxima conforme necessário
            minHeight: 250 // Definindo uma altura mínima opcional
            ),
        child: contentBox(context),
      ),
    );
  }

  Widget contentBox(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.key,
          color: Colors.white,
          size: 50,
        ),
        SizedBox(height: 20),
        Text(
          'Tem certeza que deseja excluir o token?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20, // Definindo a cor do texto como branco
          ),
          textAlign: TextAlign.center, // Alinhando o texto centralmente
        ),
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
                    color: Colors.white, // Definindo a cor do texto como branco
                  ),
                ),
              ),
            ),
            SizedBox(width: 8), // Adicionando um espaçamento entre os botões
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Excluir',
                      style: TextStyle(
                        color: Colors
                            .white, // Definindo a cor do texto como branco
                      ),
                    ),
                    SizedBox(width: 5), // Espaçamento entre texto e ícone
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30,
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

class AddTokenDialog extends StatelessWidget {
  final TextEditingController _newUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Ajustando o raio da borda do dialog
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
            ),
        child: contentBox(context),
      ),
    );
  }

  Widget contentBox(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.key,
          color: Colors.white,
          size: 50,
        ),
        SizedBox(height: 20),
        Text(
          'Digite o novo Token',
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
                    fontSize: 18,
                    color: Colors.white, // Definindo a cor do texto como branco
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Adicionar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors
                            .white, // Definindo a cor do texto como branco
                      ),
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 25,
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

class DeleteConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Ajustando o raio da borda do dialog
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
            maxWidth: 300, // Definindo o tamanho máximo do Container
            minWidth: 100, // Definindo um tamanho mínimo opcional
            maxHeight: 250, // Ajustando a altura máxima conforme necessário
            minHeight: 250 // Definindo uma altura mínima opcional
            ),
        child: contentBox(context),
      ),
    );
  }

  Widget contentBox(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.error,
          color: Colors.white,
          size: 50,
        ),
        SizedBox(height: 20),
        Text(
          'Tem certeza que deseja excluir a commodity?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20, // Definindo a cor do texto como branco
          ),
          textAlign: TextAlign.center, // Alinhando o texto centralmente
        ),
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
                    fontSize: 18,
                    color: Colors.white, // Definindo a cor do texto como branco
                  ),
                ),
              ),
            ),
            SizedBox(width: 10), // Adicionando um espaçamento entre os botões
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Excluir',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors
                            .white, // Definindo a cor do texto como branco
                      ),
                    ),
                    SizedBox(width: 5), // Espaçamento entre texto e ícone
                    Icon(
                      Icons.delete,
                      size: 35,
                      color: Colors.white,
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
