import 'package:flutter/material.dart';
import 'package:agro_bio_tech_pc/constants.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:agro_bio_tech_pc/providers/fileNameProvider.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';

class PdfCard extends StatelessWidget {
  final String _nomeDoArquivo;
  final String _tipoArquivo;

  PdfCard(this._nomeDoArquivo, this._tipoArquivo);

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
                width: 2, // Largura da borda
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
                      onPressed: () async {
                        final filePath = await _getFilePath();
                        OpenFile.open(filePath);
                        print(filePath);
                      },
                      icon: Icon(
                        Icons.visibility,
                        color: mainColor,
                        size: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        final filePath = await _getFilePath();
                        Share.shareXFiles([XFile(filePath)]);
                        print(filePath);
                      },
                      icon: Icon(
                        Icons.share,
                        color: mainColor,
                        size: 40,
                      ),
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
                                        if (_tipoArquivo ==
                                            "Controle de qualidade") {
                                          Provider.of<FileNameProvider>(
                                                  listen: false, context)
                                              .removeControleDeQualidadePdf(
                                                  _nomeDoArquivo);
                                        }
                                        if (_tipoArquivo ==
                                            "Sanidade de sementes") {
                                          Provider.of<FileNameProvider>(
                                                  listen: false, context)
                                              .removeSanidadePdf(
                                                  _nomeDoArquivo);
                                        }
                                        if (_tipoArquivo ==
                                            "Laudo Nematológico") {
                                          Provider.of<FileNameProvider>(
                                                  listen: false, context)
                                              .removeNematologicoPdf(
                                                  _nomeDoArquivo);
                                        }
                                        if (_tipoArquivo ==
                                            "Laudo Microbiológico") {
                                          Provider.of<FileNameProvider>(
                                                  listen: false, context)
                                              .removeMicrobiologicoPdf(
                                                  _nomeDoArquivo);
                                        }
                                        if (_tipoArquivo == "Laudo Diagnose") {
                                          Provider.of<FileNameProvider>(
                                                  listen: false, context)
                                              .removeDiagnosePdf(
                                                  _nomeDoArquivo);
                                        }
                                        if (_tipoArquivo ==
                                            "Raça de Nematóides") {
                                          Provider.of<FileNameProvider>(
                                                  listen: false, context)
                                              .removeDiferenciacaoDeRacaPdf(
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

  Future<String> _getFilePath() async {
    String pasta = "/";
    if (_tipoArquivo == "Controle de qualidade") {
      pasta = 'controle de qualidade';
    }
    if (_tipoArquivo == "Sanidade de sementes") {
      pasta = 'sanidade de sementes';
    }
    if (_tipoArquivo == "Laudo Nematológico") {
      pasta = "nematológico";
    }
    if (_tipoArquivo == "Laudo Microbiológico") {
      pasta = "microbiológico";
    }
    if (_tipoArquivo == "Laudo Diagnose") {
      pasta = "diagnose";
    }
    if (_tipoArquivo == "Raça de Nematóides") {
      pasta = "diferenciação de raça";
    }
    final String fileName = _nomeDoArquivo + ".pdf";
    try {
      // Obter o diretório de documentos
      Directory documentsDirectory = await getApplicationDocumentsDirectory();

      // Obter o caminho da pasta "rascunhos"
      String rascunhosPath =
          '${documentsDirectory.path}/gerador de laudos/pdfs/' + pasta;

      // Verificar se a pasta "rascunhos" existe
      if (await Directory(rascunhosPath).exists()) {
        // Construir o caminho completo do arquivo
        String filePath = '$rascunhosPath/$fileName';

        // Verificar se o arquivo existe
        if (await File(filePath).exists()) {
          // Ler o conteúdo do arquivo
          return filePath;
        } else {
          print('O arquivo "$fileName" não existe na pasta "meu pdfs".');
          return "";
        }
      } else {
        print('A pasta "pdfs" não existe.');
        return "";
      }
    } catch (e) {
      print('Erro ao obter conteúdo do arquivo: $e');
      return "";
    }
  }

  Future<void> _deleteFile() async {
    final String fileName = _nomeDoArquivo + ".pdf";
    String pasta = "/";
    if (_tipoArquivo == "Controle de qualidade") {
      pasta = 'controle de qualidade';
    }
    if (_tipoArquivo == "Sanidade de sementes") {
      pasta = 'sanidade de sementes';
    }
    if (_tipoArquivo == "Laudo Nematológico") {
      pasta = "nematológico";
    }
    if (_tipoArquivo == "Laudo Microbiológico") {
      pasta = "microbiológico";
    }
    if (_tipoArquivo == "Laudo Diagnose") {
      pasta = "diagnose";
    }
    if (_tipoArquivo == "Raça de Nematóides") {
      pasta = "diferenciação De Raça";
    }

    try {
      // Obter o diretório de documentos
      Directory documentsDirectory = await getApplicationDocumentsDirectory();

      // Obter o caminho da pasta "rascunhos"
      String rascunhosPath =
          '${documentsDirectory.path}/gerador de laudos/pdfs/' + pasta;

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
