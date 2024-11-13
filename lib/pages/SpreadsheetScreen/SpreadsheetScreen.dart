import 'package:flutter/material.dart';
import 'package:agro_bio_tech_pc/constants.dart';
import 'package:agro_bio_tech_pc/reusableWidgets/planilhaCardLis.dart';
import 'package:provider/provider.dart';
import 'package:agro_bio_tech_pc/providers/fileNameProvider.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:agro_bio_tech_pc/reusableWidgets/searchingBar.dart';
import 'package:open_file/open_file.dart';

class SpreadsheetScreen extends StatefulWidget {
  @override
  State<SpreadsheetScreen> createState() => _SpreadsheetScreenState();
}

ScrollController sc = ScrollController();

class _SpreadsheetScreenState extends State<SpreadsheetScreen> {
  String _index = "Controle de qualidade";

  final _controllerControleDeQualidade = TextEditingController();
  final _controllerSanidade = TextEditingController();
  final _controllerNematologico = TextEditingController();
  final _controllerRaca = TextEditingController();
  final _controllerMicro = TextEditingController();
  final _controllerDiagnose = TextEditingController();

  Future<List<String>> searchFiles(String searchString, String type) async {
  try {
    // Obtém o diretório de Documentos
    final directory = await getApplicationDocumentsDirectory();
    final documentsPath =
        directory.path + "/gerador de laudos/planilhas/" + type;

    // Cria uma lista para armazenar os nomes dos arquivos encontrados
    List<String> matchingFiles = [];

    // Verifica se o diretório existe
    if (Directory(documentsPath).existsSync()) {
      // Obtém a lista de arquivos na pasta Documentos
      final directoryContents = Directory(documentsPath).listSync();

      for (var file in directoryContents) {
        // Verifica se o item é um arquivo
        if (file is File) {
          // Obtém o nome do arquivo sem a extensão
          String fileName = file.uri.pathSegments.last.split('.').first;

          // Verifica se o nome do arquivo contém a string de pesquisa
          if (fileName.contains(searchString)) {
            matchingFiles.add(fileName);
          }
        }
      }
    } else {
      print("O diretório $documentsPath não existe.");
    }

    return matchingFiles;
  } catch (e) {
    // Caso ocorra algum erro, imprime no console e retorna uma lista vazia
    print("Erro ao buscar arquivos: $e");
    return [];
  }
}

  @override
  Widget build(BuildContext context) {
    Widget rascunhos = SizedBox(
      width: 1,
    );

    if (_index == "Controle de qualidade") {
      rascunhos = Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchBarWidget(
                controller: _controllerControleDeQualidade,
                onClearPressed: () async {
                  _controllerControleDeQualidade.text = "";
                  final res = await searchFiles(
                      _controllerControleDeQualidade.text,
                      "controle de qualidade");
                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaControleDeQualidadePlanilhas(res);
                },
                onSearchPressed: () async {
                  final res = await searchFiles(
                      _controllerControleDeQualidade.text,
                      "controle de qualidade");
                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaControleDeQualidadePlanilhas(res);
                },
                onChanged: (value) {},
              ),
              Consumer<FileNameProvider>(builder: (context, provider, child) {
                if (provider.controleDeQualidadePlanilhas.isNotEmpty)
                  return PlanilhaCardList(
                      provider.controleDeQualidadePlanilhas, _index);
                else
                  return Center(
                      child: Text(
                    "Nenhuma planilha encontrada!",
                    style: TextStyle(fontSize: 18),
                  ));
              })
            ],
          ),
        ),
      );
    }
    if (_index == "Sanidade de sementes") {
      rascunhos = Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchBarWidget(
                controller: _controllerSanidade,
                onClearPressed: () async {
                  _controllerSanidade.text = "";
                  final res = await searchFiles(
                      _controllerSanidade.text, "sanidade de sementes");
                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaSanidadePlanilhas(res);
                },
                onSearchPressed: () async {
                  final res = await searchFiles(
                      _controllerSanidade.text, "sanidade de sementes");
                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaSanidadePlanilhas(res);
                },
                onChanged: (value) {},
              ),
              Consumer<FileNameProvider>(builder: (context, provider, child) {
                if (provider.sanidadePlanilhas.isNotEmpty)
                  return PlanilhaCardList(provider.sanidadePlanilhas, _index);
                else
                  return Center(
                      child: Text(
                    "Nenhuma planilha encontrada!",
                    style: TextStyle(fontSize: 18),
                  ));
              })
            ],
          ),
        ),
      );
    }
    if (_index == "Laudo Nematológico") {
      rascunhos = Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchBarWidget(
                controller: _controllerNematologico,
                onClearPressed: () async {
                  _controllerNematologico.text = "";
                  final res = await searchFiles(
                      _controllerNematologico.text, "nematológico");
                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaNematologicoPlanilhas(res);
                },
                onSearchPressed: () async {
                  final res = await searchFiles(
                      _controllerNematologico.text, "nematológico");
                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaNematologicoPlanilhas(res);
                },
                onChanged: (value) {},
              ),
              Consumer<FileNameProvider>(builder: (context, provider, child) {
                if (provider.nematologicoPlanilhas.isNotEmpty)
                  return PlanilhaCardList(
                      provider.nematologicoPlanilhas, _index);
                else
                  return Center(
                      child: Text(
                    "Nenhuma planilha encontrada!",
                    style: TextStyle(fontSize: 18),
                  ));
              })
            ],
          ),
        ),
      );
    }
    if (_index == "Laudo Microbiológico") {
      rascunhos = Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchBarWidget(
                controller: _controllerMicro,
                onClearPressed: () async {
                  _controllerMicro.text = "";
                  final res = await searchFiles(
                      _controllerMicro.text, "microbiológico");
                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaMicrobiologicoPlanilhas(res);
                },
                onSearchPressed: () async {
                  final res = await searchFiles(
                      _controllerMicro.text, "microbiológico");
                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaMicrobiologicoPlanilhas(res);
                },
                onChanged: (value) {},
              ),
              Consumer<FileNameProvider>(builder: (context, provider, child) {
                if (provider.microbiologicoPlanilhas.isNotEmpty)
                  return PlanilhaCardList(
                      provider.microbiologicoPlanilhas, _index);
                else
                  return Center(
                      child: Text(
                    "Nenhuma planilha encontrada!",
                    style: TextStyle(fontSize: 18),
                  ));
              })
            ],
          ),
        ),
      );
    }
    if (_index == "Laudo Diagnose") {
      rascunhos = Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchBarWidget(
                controller: _controllerDiagnose,
                onClearPressed: () async {
                  _controllerDiagnose.text = "";
                  final res =
                      await searchFiles(_controllerDiagnose.text, "diagnose");
                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaDiagnosePlanilhas(res);
                },
                onSearchPressed: () async {
                  final res =
                      await searchFiles(_controllerDiagnose.text, "diagnose");
                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaDiagnosePlanilhas(res);
                },
                onChanged: (value) {},
              ),
              Consumer<FileNameProvider>(builder: (context, provider, child) {
                if (provider.diagnosePlanilhas.isNotEmpty)
                  return PlanilhaCardList(provider.diagnosePlanilhas, _index);
                else
                  return Center(
                      child: Text(
                    "Nenhuma planilha encontrada!",
                    style: TextStyle(fontSize: 18),
                  ));
              })
            ],
          ),
        ),
      );
    }
    if (_index == "Raça de Nematóides") {
      rascunhos = Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchBarWidget(
                controller: _controllerRaca,
                onClearPressed: () async {
                  _controllerRaca.text = "";
                  final res = await searchFiles(
                      _controllerRaca.text, "diferenciação de raça");
                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaDiferenciacaoDeRacaPlanilhas(res);
                },
                onSearchPressed: () async {
                  final res = await searchFiles(
                      _controllerRaca.text, "diferenciação de raça");
                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaDiferenciacaoDeRacaPlanilhas(res);
                },
                onChanged: (value) {},
              ),
              Consumer<FileNameProvider>(builder: (context, provider, child) {
                if (provider.diferenciacaoDeRacaPlanilhas.isNotEmpty)
                  return PlanilhaCardList(
                      provider.diferenciacaoDeRacaPlanilhas, _index);
                else
                  return Center(
                      child: Text(
                    "Nenhuma planilha encontrada!",
                    style: TextStyle(fontSize: 18),
                  ));
              })
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        color: secondaryColor,
        child: Column(
          children: [
            // Banner
         Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      "Minhas Planilhas",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20, // Posição do grupo ícone e texto no lado direito
                    top: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () async {
                        // Obtém o caminho da pasta de documentos
                        Directory? documentsDir =
                            await getApplicationDocumentsDirectory();
                        String folderPath = '${documentsDir.path}' +
                            "\\gerador de laudos\\planilhas";

                        // Cria a pasta se ela não existir
                        Directory folder = Directory(folderPath);
                        if (!await folder.exists()) {
                          await folder.create(recursive: true);
                        }

                        // Abra a pasta no sistema operacional
                        OpenFile.open(folderPath);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.folder_open,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(width: 5), // Espaço entre o ícone e o texto
                          Text(
                            "Abrir Pasta",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: ScrollbarTheme(
                data: ScrollbarThemeData(
                  thumbColor: WidgetStateProperty.all<Color>(mainColor),
                ),
                child: Scrollbar(
                  controller: sc,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: sc,
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _index = "Controle de qualidade";
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    _index == "Controle de qualidade"
                                        ? mainColor
                                        : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                'Controle de qualidade',
                                style: TextStyle(
                                  color: _index == "Controle de qualidade"
                                      ? Colors.white
                                      : mainColor,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _index = "Sanidade de sementes";
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    _index == "Sanidade de sementes"
                                        ? mainColor
                                        : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                'Sanidade de sementes',
                                style: TextStyle(
                                  color: _index == "Sanidade de sementes"
                                      ? Colors.white
                                      : mainColor,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _index = "Laudo Nematológico";
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _index == "Laudo Nematológico"
                                    ? mainColor
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                'Laudo Nematológico',
                                style: TextStyle(
                                  color: _index == "Laudo Nematológico"
                                      ? Colors.white
                                      : mainColor,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _index = "Raça de Nematóides";
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _index == "Raça de Nematóides"
                                    ? mainColor
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                'Raça de Nematóides',
                                style: TextStyle(
                                  color: _index == "Raça de Nematóides"
                                      ? Colors.white
                                      : mainColor,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _index = "Laudo Microbiológico";
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    _index == "Laudo Microbiológico"
                                        ? mainColor
                                        : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                'Laudo Microbiológico',
                                style: TextStyle(
                                  color: _index == "Laudo Microbiológico"
                                      ? Colors.white
                                      : mainColor,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _index = "Laudo Diagnose";
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _index == "Laudo Diagnose"
                                    ? mainColor
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                'Laudo Diagnose',
                                style: TextStyle(
                                  color: _index == "Laudo Diagnose"
                                      ? Colors.white
                                      : mainColor,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ),
            rascunhos,
          ],
        ),
      ),
    );
  }
}
