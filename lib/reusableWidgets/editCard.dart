import 'package:flutter/material.dart';
import 'package:agro_bio_tech_pc/constants.dart';
import 'package:agro_bio_tech_pc/pages/createFileScreen/diferenciacaoDeRaca/diferencia%C3%A7%C3%A3oDeRa%C3%A7a.dart';
import '../pages/createFileScreen/controleDeQualidade/controleDeQualidade.dart';
import '../pages/createFileScreen/sanidadeDeSementes/sanidadeDeSementes.dart';
import '../pages/createFileScreen/diagnose/diagnose.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:agro_bio_tech_pc/providers/fileNameProvider.dart';
import 'dart:convert';
import 'package:agro_bio_tech_pc/pages/createFileScreen/laudoMicrobiológico/laudoMicrobiológico.dart';
import 'package:agro_bio_tech_pc/pages/createFileScreen/laudoNematológico/laudoNematológico.dart';
import 'package:path_provider/path_provider.dart';

class EditCard extends StatelessWidget {
  final String _nomeDoArquivo;
  final String _tipoArquivo;

  EditCard(
    this._nomeDoArquivo,
    this._tipoArquivo,
  );

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
                        final data = json.decode(content);
                        if (data['informacoes']['Tipo_de_analise'] ==
                            "Controle de qualidade") {
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
                        }
                        if (data['informacoes']['Tipo_de_analise'] ==
                            "Sanidade de sementes") {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 600),
                              pageBuilder: (_, __, ___) =>
                                  SanidadeDeSementes(content),
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
                        }
                        if (data['informacoes']['Tipo_de_analise'] ==
                            "Diagnose Fitopatológica") {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 600),
                              pageBuilder: (_, __, ___) => Diagnose(content),
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
                        }
                        if (data['informacoes']['Tipo_de_analise'] ==
                            "Diferenciação de raças") {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 600),
                              pageBuilder: (_, __, ___) =>
                                  DifereciacaoDeRaca(content),
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
                        }
                        if (data['informacoes']['Tipo_de_analise'] ==
                            "Laudo Microbiológico") {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 600),
                              pageBuilder: (_, __, ___) =>
                                  Microbiologico(content),
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
                        }
                        if (data['informacoes']['Tipo_de_analise'] ==
                            "Laudo Nematológico") {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 600),
                              pageBuilder: (_, __, ___) =>
                                  LaudoNematologico(content),
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
                        }
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
                                        final content =
                                            await _getFileContentInRascunhos();
                                        await _deleteFile();

                                        final data = json.decode(content);
                                        if (data['informacoes']
                                                ['Tipo_de_analise'] ==
                                            "Controle de qualidade") {
                                          Provider.of<FileNameProvider>(
                                                  listen: false, context)
                                              .removeControleDeQualidadeRascunho(
                                                  _nomeDoArquivo);
                                        }
                                        if (data['informacoes']
                                                ['Tipo_de_analise'] ==
                                            "Sanidade de sementes") {
                                          Provider.of<FileNameProvider>(
                                                  listen: false, context)
                                              .removeSanidadeRascunho(
                                                  _nomeDoArquivo);
                                        }
                                        if (data['informacoes']
                                                ['Tipo_de_analise'] ==
                                            "Diagnose Fitopatológica") {
                                          Provider.of<FileNameProvider>(
                                                  listen: false, context)
                                              .removeDiagnoseRascunho(
                                                  _nomeDoArquivo);
                                        }
                                        if (data['informacoes']
                                                ['Tipo_de_analise'] ==
                                            "Diferenciação de raças") {
                                          Provider.of<FileNameProvider>(
                                                  listen: false, context)
                                              .removeDiferenciacaoDeRacaRascunho(
                                                  _nomeDoArquivo);
                                        }
                                        if (data['informacoes']
                                                ['Tipo_de_analise'] ==
                                            "Laudo Microbiológico") {
                                          Provider.of<FileNameProvider>(
                                                  listen: false, context)
                                              .removeMicrobiologicoRascunho(
                                                  _nomeDoArquivo);
                                        }
                                        if (data['informacoes']
                                                ['Tipo_de_analise'] ==
                                            "Laudo Nematológico") {
                                          Provider.of<FileNameProvider>(
                                                  listen: false, context)
                                              .removeNematologicoRascunho(
                                                  _nomeDoArquivo);
                                        }
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
    String pasta = "/";
    if (_tipoArquivo == "Controle de qualidade") {
      pasta = 'controle De Qualidade';
    }
    if (_tipoArquivo == "Sanidade de sementes") {
      pasta = 'sanidade De Sementes';
    }
    if (_tipoArquivo == "Laudo Nematológico") {
      pasta = "laudo nematológico";
    }
    if (_tipoArquivo == "Laudo Microbiológico") {
      pasta = "microbiologico";
    }
    if (_tipoArquivo == "Laudo Diagnose") {
      pasta = "diagnose";
    }
    if (_tipoArquivo == "Raça de Nematóides") {
      pasta = "diferenciação De Raça";
    }
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();

      // Obter o caminho da pasta "rascunhos"
      String path = '${documentsDirectory.path}/gerador de laudos/rascunhos/' +
          pasta +
          "/" +
          _nomeDoArquivo +
          ".json";
      if (await File(path).exists()) {
        // Ler o conteúdo do arquivo
        String fileContent = await File(path).readAsString();
        return fileContent;
      } else {
        print('O arquivo "$path" não existe na pasta".');
        return "";
      }
    } catch (e) {
      print('Erro ao obter conteúdo do arquivo: $e');
      return "";
    }
  }

  Future<void> _deleteFile() async {
    String pasta = "/";
    if (_tipoArquivo == "Controle de qualidade") {
      pasta = 'controle De Qualidade';
    }
    if (_tipoArquivo == "Sanidade de sementes") {
      pasta = 'sanidade De Sementes';
    }
    if (_tipoArquivo == "Laudo Nematológico") {
      pasta = "laudo nematológico";
    }
    if (_tipoArquivo == "Laudo Microbiológico") {
      pasta = "microbiologico";
    }
    if (_tipoArquivo == "Laudo Diagnose") {
      pasta = "diagnose";
    }
    if (_tipoArquivo == "Raça de Nematóides") {
      pasta = "diferenciação De Raça";
    }
    final String fileName = _nomeDoArquivo + ".json";

    try {
      // Obter o diretório de documentos
      Directory documentsDirectory = await getApplicationDocumentsDirectory();

      // Obter o caminho da pasta "rascunhos"
      String rascunhosPath =
          '${documentsDirectory.path}/gerador de laudos/rascunhos/';

      // Verificar se o arquivo existe
      File fileToDelete = File(rascunhosPath + pasta + '/' + fileName);
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
