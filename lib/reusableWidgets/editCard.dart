import 'package:flutter/material.dart';
import 'package:midas/constants.dart';
import '../pages/createFileScreen/controleDeQualidade.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:midas/providers/fileNameProvider.dart';

class EditCard extends StatelessWidget {
  final String _nomeDoArquivo;

  EditCard({
    required String text,
  }) : _nomeDoArquivo = text;

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
                width: 2, // L2argura da borda
              ),
            ),
            width: double.infinity, // Para preencher toda a largura da tela
            padding: EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      _nomeDoArquivo,
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit_document,
                        size: 40,
                        color: mainColor,
                      ),
                      onPressed: () async {
                        final content = await _getFileContentInRascunhos();
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 600),
                            pageBuilder: (_, __, ___) =>
                                ControleDeQualidade(content),
                            transitionsBuilder: (_, animation, __, child) {
                              return ScaleTransition(
                                scale: Tween<double>(
                                  begin: 0.0,
                                  end: 1.0,
                                ).animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeInOut,
                                  ),
                                ),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 40,
                        color: Colors.red[900],
                      ),
                      onPressed: () async {
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
                                        color: mainColor),
                                  ),
                                ],
                              ),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Deseja deletar o arquivo?",
                                    style: TextStyle(
                                        color: Colors.grey[800], fontSize: 16),
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
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(180.0),
                                        ),
                                      ),
                                      onPressed: () async {
                                        // Implementar aqui a lógica para sair
                                        await _deleteFile();
                                        Provider.of<FileNameProvider>(
                                                listen: false, context)
                                            .removeRascunho(_nomeDoArquivo);
                                        Navigator.of(context).pop();
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
                                        backgroundColor: mainColor,
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

  Future<String> _getFileContentInRascunhos() async {
    final String fileName = _nomeDoArquivo + ".json";
    try {
      // Obter o diretório de documentos
      Directory documentsDirectory = await getApplicationDocumentsDirectory();

      // Obter o caminho da pasta "rascunhos"
      String rascunhosPath = '${documentsDirectory.path}/rascunhos';

      // Verificar se a pasta "rascunhos" existe
      if (await Directory(rascunhosPath).exists()) {
        // Construir o caminho completo do arquivo
        String filePath = '$rascunhosPath/$fileName';

        // Verificar se o arquivo existe
        if (await File(filePath).exists()) {
          // Ler o conteúdo do arquivo
          String fileContent = await File(filePath).readAsString();
          return fileContent;
        } else {
          print('O arquivo "$fileName" não existe na pasta "rascunhos".');
          return "";
        }
      } else {
        print('A pasta "rascunhos" não existe.');
        return "";
      }
    } catch (e) {
      print('Erro ao obter conteúdo do arquivo: $e');
      return "";
    }
  }

  Future<void> _deleteFile() async {
    final String fileName = _nomeDoArquivo + ".json";

    try {
      // Obter o diretório de documentos
      Directory documentsDirectory = await getApplicationDocumentsDirectory();

      // Obter o caminho da pasta "rascunhos"
      String rascunhosPath = '${documentsDirectory.path}/rascunhos';

      // Verificar se o arquivo existe
      File fileToDelete = File('$rascunhosPath/$fileName');
      if (await fileToDelete.exists()) {
        // Excluir o arquivo
        await fileToDelete.delete();
        print('Arquivo $fileName excluído com sucesso.');
      } else {
        print('O arquivo $fileName não existe na pasta "rascunhos".');
      }
    } catch (e) {
      print('Erro ao excluir o arquivo: $e');
    }
  }
}
