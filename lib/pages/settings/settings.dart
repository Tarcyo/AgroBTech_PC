import 'package:flutter/material.dart';
import 'package:midas/constants.dart';
import 'package:midas/reusableWidgets/fixedCamp.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Padding(
        padding: const EdgeInsets.only(
            left: 35, top: 20, right: 40), // Adiciona um padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Configurações",
              style: TextStyle(fontSize: 25, color: mainColor),
            ),
            const SizedBox(
                height: 50), // Adiciona um espaço entre o texto e o FixedCamp
            Row(
              children: [
                FixedCamp(
                  text: "Notificações",
                  color: mainColor,
                  icon: Icons.notifications,
                ),
                SizedBox(
                  width: 15,
                ),
                Center(
                  child: DropdownButton<String>(
                    value: 'Compra e Venda', // Valor inicial
                    onChanged: (String? newValue) {
                      // Implemente o que deseja fazer quando uma opção for selecionada
                      print(newValue);
                    },
                    items: <String>['Compra e Venda', '2', '3']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 35),
              ],
            ),
            SizedBox(height: 35),

            Row(
              children: [
                FixedCamp(
                  text: "Periodo de analise",
                  color: mainColor,
                  icon: Icons.analytics,
                ),
                SizedBox(
                  width: 15,
                ),
                Center(
                  child: DropdownButton<String>(
                    value: '3 dias', // Valor inicial
                    onChanged: (String? newValue) {
                      // Implemente o que deseja fazer quando uma opção for selecionada
                      print(newValue);
                    },
                    items: <String>['3 dias', '2', '3']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 35),

            Row(
              children: [
                FixedCamp(
                  text: "Periodo das notícias",
                  color: mainColor,
                  icon: Icons.newspaper,
                ),
                SizedBox(
                  width: 15,
                ),
                Center(
                  child: DropdownButton<String>(
                    value: '1 Semana', // Valor inicial
                    onChanged: (String? newValue) {
                      // Implemente o que deseja fazer quando uma opção for selecionada
                      print(newValue);
                    },
                    items: <String>['1 Semana', '2', '3']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 35),

            Row(
              children: [
                FixedCamp(
                  text: "Sites de notícias",
                  color: mainColor,
                  icon: Icons.language,
                ),
                SizedBox(
                  width: 15,
                ),
                Center(
                  child: DropdownButton<String>(
                    value: 'Minha Lista', // Valor inicial
                    onChanged: (String? newValue) {
                      // Implemente o que deseja fazer quando uma opção for selecionada
                      print(newValue);
                    },
                    items: <String>['Minha Lista', '2', '3']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 35),

            Row(
              children: [
                FixedCamp(
                  text: "Notificação dos grupos",
                  color: mainColor,
                  icon: Icons.group,
                ),
                SizedBox(
                  width: 15,
                ),
                Center(
                  child: DropdownButton<String>(
                    value: 'Ativado', // Valor inicial
                    onChanged: (String? newValue) {
                      // Implemente o que deseja fazer quando uma opção for selecionada
                      print(newValue);
                    },
                    items: <String>['Ativado', '2', '3']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 35),

            Row(
              children: [
                FixedCamp(
                  text: "Adição em grupo",
                  color: mainColor,
                  icon: Icons.add,
                ),
                SizedBox(
                  width: 15,
                ),
                Center(
                  child: DropdownButton<String>(
                    value: 'Permitir', // Valor inicial
                    onChanged: (String? newValue) {
                      // Implemente o que deseja fazer quando uma opção for selecionada
                      print(newValue);
                    },
                    items: <String>['Permitir', '2', '3']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 120,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Adicione a lógica para restaurar os padrões aqui
                    print('Restaurar padrões');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // Borda arredondada
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 30,
                    ), // Espaçamento interno do botão
                    backgroundColor: mainColor, // Cor de fundo do botão
                  ),
                  child: Text(
                    'Restaurar Padrões',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
