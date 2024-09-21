import 'package:flutter/material.dart';
import 'package:midas/pages/registerUser/registerUser.dart';
import '../../reusableWidgets/insertCamp.dart';

import '../../reusableWidgets/insertCampPassword.dart';

import 'package:midas/model/clienteModel.dart';
import '../../reusableWidgets/roundedButtom.dart';
import '../../reusableWidgets/clicableWhiteText.dart';
import '../../homeTabBar.dart';
import 'package:provider/provider.dart';
import 'package:midas/providers/clienteProvider.dart';
import 'package:midas/services/cliente.dart';
Color mainColor = Color(0xFF00C2A0);

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Removendo a barra azul
      body: Container(
        // Definindo a cor de fundo
        color: mainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 240, // ajuste conforme necessário
                width: 240, // ajuste conforme necessário
                child: Padding(
                  padding: EdgeInsets.all(
                    4, // ajuste conforme necessário para o tamanho da borda
                  ),
                  child: Container(
                    color: Colors.transparent, // torna o fundo transparente
                    child: Image.asset(
                      'assets/images/logoMidas.png', // substitua com o caminho correto da sua imagem
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 300, // Definindo largura máxima para o Card
                height: 330, // Definindo altura máxima para o Card
                child: Card(
                  color: mainColor,
                  elevation: 5, // Elevação para adicionar sombra
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(64),
                    side: BorderSide(
                        color: Colors.white, width: 10), // Borda branca
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                                height:
                                    3), // Espaçamento entre o texto e o campo de inserção
                            RoundedTextField(controller: emailController),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Senha',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                                height:
                                    3), // Espaçamento entre o texto e o campo de inserção
                            RoundedTextFieldPassword(controller: passwordController),
                            SizedBox(
                              height: 10,
                              width: 10,
                            ),
                            Center(
                              child: RoundedButton(
                                onPressed: () async{
                                  final response= await fetchClientById(1);
                                  Cliente novoCliente = Cliente.fromJson(response);
 

                                     Provider.of<ClienteProvider>(
                                                      context,
                                                      listen: false)
                                                  .setCliente(
                                                      novoCliente);
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            transitionDuration:
                                                Duration(milliseconds: 1000),
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
                                              return HomePage();
                                            },
                                          ),
                                        );
                                      },
                                text: "Entrar",
                              ),
                            ),
                            SizedBox(
                              width: 10,
                              height: 10,
                            ),

                            Center(
                              child: Column(
                                children: [
                                  ClickableWhiteText(
                                      onPressed: () => {},
                                      text: "Não consegue fazer Login?"),
                                  SizedBox(
                                    width: 5,
                                    height: 5,
                                  ),
                                  ClickableWhiteText(
                                      onPressed: () {
                                        // Navegue para a RegisterScreen quando o botão for pressionado
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
                                              return RegisterUser();
                                            },
                                          ),
                                        );
                                      },
                                      text: "Não possui conta?"),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
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
