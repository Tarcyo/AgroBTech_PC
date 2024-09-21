import 'package:flutter/material.dart';
import '../../reusableWidgets/insertCamp.dart';
import '../../reusableWidgets/halfInsertCampPassword.dart';
import '../../reusableWidgets/halfInsertCamp.dart';
import '../../reusableWidgets/roundedButtom.dart';
import 'package:midas/constants.dart';
import 'package:midas/services/cliente.dart';

class RegisterUser extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: mainColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 20),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(180.0),
                          ),
                          minimumSize: Size(150, 50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back_ios,
                                color: mainColor, size: 20),
                            SizedBox(width: 3),
                            Text(
                              "Voltar",
                              style: TextStyle(color: mainColor, fontSize: 20),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Center(
                        child: Container(
                          height: 170,
                          width: 170,
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Container(
                              color: Colors.transparent,
                              child: Image.asset(
                                'assets/images/logoMidas.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: 450,
                          height: 440,
                          child: Card(
                            color: mainColor,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                              side: BorderSide(
                                color: Colors.white,
                                width: 10,
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Criar Conta',
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nome completo',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      RoundedTextField(
                                          controller: fullNameController),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Email',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      RoundedTextField(
                                          controller: emailController),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Telefone',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      HalfroundedTextField(
                                          controller: phoneController),
                                      SizedBox(height: 5),
                                      Text(
                                        'Senha',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      HalfroundedTextFieldPassword(
                                          controller: passwordController),
                                      SizedBox(height: 5),
                                      Text(
                                        'Confirmar senha',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      HalfroundedTextFieldPassword(
                                          controller:
                                              confirmPasswordController),
                                      SizedBox(height: 15),
                                      Center(
                                        child: RoundedButton(
                                          onPressed: () async {
                                            await _validateAndSubmit(context);
                                          },
                                          text: "Cadastrar",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 1,
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

  // Função para validar e mostrar o modal de alerta se necessário
  Future<void> _validateAndSubmit(BuildContext context) async {
    String fullName = fullNameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (fullName.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showAlertDialog(
          context, "Erro", "Todos os campos devem ser preenchidos.");
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      _showAlertDialog(context, "Erro", "Email inválido.");
    } else if (!RegExp(r'^\d{11}$').hasMatch(phone)) {
      _showAlertDialog(context, "Erro",
          "O número de telefone deve conter exatamente 11 dígitos.");
    } else if (password != confirmPassword) {
      _showAlertDialog(context, "Erro", "As senhas não coincidem.");
    } else {
      final nomes = _obterPrimeiroUltimoNome(fullName);
      final bool response =
          await registerClient(nomes[0], nomes[1], email, phone,password);
      if (response) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: mainColor, width: 5),
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Sucesso!",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "O usuário foi registrado!",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        _showAlertDialog(context, "Erro", "Falha ao registrar o usuário.");
      }
    }
  }

  dynamic _obterPrimeiroUltimoNome(String nomeCompleto) {
    List<String> partes = nomeCompleto.trim().split(' ');

    if (partes.length >= 2) {
      return partes;
    } else {
      return 'Nome inválido';
    }
  }

  void _showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: mainColor, width: 5),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  message,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop(); // Fechar o diálogo
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
