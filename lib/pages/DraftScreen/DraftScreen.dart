import 'package:flutter/material.dart';
import 'package:agro_bio_tech_pc/constants.dart';
import 'package:agro_bio_tech_pc/reusableWidgets/editCardList.dart';
import 'package:provider/provider.dart';
import 'package:agro_bio_tech_pc/providers/fileNameProvider.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:agro_bio_tech_pc/reusableWidgets/searchingBar.dart';
import 'package:open_file/open_file.dart';

class DraftScreen extends StatefulWidget {
  @override
  State<DraftScreen> createState() => _DraftScreenState();
}

final ScrollController _sc = ScrollController();

class _DraftScreenState extends State<DraftScreen> {
  String _index = "Controle de qualidade";

  Future<List<Map<String, dynamic>>> buscarArquivosJsonPorString(
      String query, String type) async {
    // Obtém o diretório de documentos da aplicação
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // Obter o caminho da pasta "controleDeQualidade" dentro de "gerador de laudos"
    String path =
        '${documentsDirectory.path}/gerador de laudos/rascunhos/' + type;
    final dir = Directory(path); // Diretório onde estão os arquivos JSON
    List<Map<String, dynamic>> resultados = [];

    // Verifica se o diretório existe
    if (await dir.exists()) {
      // Lista todos os arquivos JSON no diretório
      final arquivos =
          dir.listSync().where((file) => file.path.endsWith('.json'));

      for (var arquivo in arquivos) {
        // Verifica se o arquivo é de fato um File (não um diretório)
        if (arquivo is File) {
          try {
            // Lê o conteúdo do arquivo
            String conteudo = await arquivo.readAsString();

            // Tenta converter o conteúdo para JSON
            Map<String, dynamic> jsonData = jsonDecode(conteudo);

            // Verifica se algum valor dentro do JSON contém a query (pesquisa insensível a maiúsculas/minúsculas)
            bool encontrou = jsonData.values.any((value) =>
                value.toString().toLowerCase().contains(query.toLowerCase()));

            // Se encontrar, adiciona o jsonData aos resultados
            if (encontrou) {
              resultados.add(jsonData);
            }
          } catch (e) {
            // Tratamento de erro ao ler o arquivo ou converter para JSON
            print('Erro ao ler ou processar o arquivo ${arquivo.path}: $e');
          }
        }
      }
    } else {
      // Caso o diretório não exista
      print('Diretório não encontrado.');
    }

    return resultados;
  }

  final _controllerControleDeQualidade = TextEditingController();
  final _controllerSanidade = TextEditingController();
  final _controllerNematologico = TextEditingController();
  final _controllerRaca = TextEditingController();
  final _controllerMicro = TextEditingController();
  final _controllerDiagnose = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(Provider.of<FileNameProvider>(context, listen: false)
        .sanidadeRascunhos);
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
                onSearchPressed: () async {
                  final res = await buscarArquivosJsonPorString(
                      _controllerControleDeQualidade.text,
                      "controle De Qualidade");
                  final List<String> nomesDosArquivos = [];
                  for (final i in res) {
                    nomesDosArquivos.add(i['informacoes']['Nome_Arquivo']);
                  }

                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaControleDeQualidadeRascunhos(nomesDosArquivos);
                },
                onClearPressed: () async {
                  _controllerControleDeQualidade.text = "";

                  final res = await buscarArquivosJsonPorString(
                      _controllerControleDeQualidade.text,
                      "controle De Qualidade");
                  final List<String> nomesDosArquivos = [];
                  for (final i in res) {
                    nomesDosArquivos.add(i['informacoes']['Nome_Arquivo']);
                  }

                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaControleDeQualidadeRascunhos(nomesDosArquivos);
                },
                onChanged: (value) async {},
              ),
              Consumer<FileNameProvider>(
                builder: (context, provider, child) {
                  if (provider.controleDeQualidadeRascunhos.isNotEmpty)
                    return EditCardList(
                        provider.controleDeQualidadeRascunhos, _index);
                  else
                    return Center(
                        child: Text(
                      "Nenhum Rascunho encontrado!",
                      style: TextStyle(fontSize: 18),
                    ));
                },
              )
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
                onClearPressed: () async {
                  _controllerSanidade.text = "";

                  final res = await buscarArquivosJsonPorString(
                      _controllerSanidade.text, "sanidade De Sementes");
                  final List<String> nomesDosArquivos = [];
                  for (final i in res) {
                    nomesDosArquivos.add(i['informacoes']['Nome_Arquivo']);
                  }

                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaSanidadeRascunhos(nomesDosArquivos);
                },
                controller: _controllerSanidade,
                onSearchPressed: () async {
                  final res = await buscarArquivosJsonPorString(
                      _controllerSanidade.text, "sanidade De Sementes");
                  final List<String> nomesDosArquivos = [];
                  for (final i in res) {
                    nomesDosArquivos.add(i['informacoes']['Nome_Arquivo']);
                  }

                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaSanidadeRascunhos(nomesDosArquivos);
                },
                onChanged: (value) async {},
              ),
              Consumer<FileNameProvider>(
                builder: (context, provider, child) {
                  if (provider.sanidadeRascunhos.isNotEmpty)
                    return EditCardList(provider.sanidadeRascunhos, _index);
                  else
                    return Center(
                        child: Text(
                      "Nenhum Rascunho encontrado!",
                      style: TextStyle(fontSize: 18),
                    ));
                },
              )
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
                onClearPressed: () async {
                  _controllerNematologico.text = "";

                  final res = await buscarArquivosJsonPorString(
                      _controllerNematologico.text, "laudo nematológico");
                  final List<String> nomesDosArquivos = [];
                  for (final i in res) {
                    nomesDosArquivos.add(i['informacoes']['Nome_Arquivo']);
                  }

                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaNematologicoRascunhos(nomesDosArquivos);
                },
                controller: _controllerNematologico,
                onSearchPressed: () async {
                  final res = await buscarArquivosJsonPorString(
                      _controllerNematologico.text, "laudo nematológico");
                  final List<String> nomesDosArquivos = [];
                  for (final i in res) {
                    nomesDosArquivos.add(i['informacoes']['Nome_Arquivo']);
                  }

                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaNematologicoRascunhos(nomesDosArquivos);
                },
                onChanged: (value) async {},
              ),
              Consumer<FileNameProvider>(
                builder: (context, provider, child) {
                  if (provider.nematologicoRascunhos.isNotEmpty)
                    return EditCardList(provider.nematologicoRascunhos, _index);
                  else
                    return Center(
                        child: Text(
                      "Nenhum Rascunho encontrado!",
                      style: TextStyle(fontSize: 18),
                    ));
                },
              )
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
                onClearPressed: () async {
                  _controllerMicro.text = "";

                  final res = await buscarArquivosJsonPorString(
                      _controllerMicro.text, "microbiologico");
                  final List<String> nomesDosArquivos = [];
                  for (final i in res) {
                    nomesDosArquivos.add(i['informacoes']['Nome_Arquivo']);
                  }

                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaMicrobiologicoRascunhos(nomesDosArquivos);
                },
                controller: _controllerMicro,
                onSearchPressed: () async {
                  final res = await buscarArquivosJsonPorString(
                      _controllerMicro.text, "microbiologico");
                  final List<String> nomesDosArquivos = [];
                  for (final i in res) {
                    nomesDosArquivos.add(i['informacoes']['Nome_Arquivo']);
                  }

                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaMicrobiologicoRascunhos(nomesDosArquivos);
                },
                onChanged: (value) async {},
              ),
              Consumer<FileNameProvider>(
                builder: (context, provider, child) {
                  if (provider.microbiologicoRascunhos.isNotEmpty)
                    return EditCardList(
                        provider.microbiologicoRascunhos, _index);
                  else
                    return Center(
                        child: Text(
                      "Nenhum Rascunho encontrado!",
                      style: TextStyle(fontSize: 18),
                    ));
                },
              )
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
                onClearPressed: () async {
                  _controllerDiagnose.text = "";

                  final res = await buscarArquivosJsonPorString(
                      _controllerDiagnose.text, "diagnose");
                  final List<String> nomesDosArquivos = [];
                  for (final i in res) {
                    nomesDosArquivos.add(i['informacoes']['Nome_Arquivo']);
                  }

                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaDiagnoseRascunhos(nomesDosArquivos);
                },
                controller: _controllerDiagnose,
                onSearchPressed: () async {
                  final res = await buscarArquivosJsonPorString(
                      _controllerDiagnose.text, "diagnose");
                  final List<String> nomesDosArquivos = [];
                  for (final i in res) {
                    nomesDosArquivos.add(i['informacoes']['Nome_Arquivo']);
                  }

                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaDiagnoseRascunhos(nomesDosArquivos);
                },
                onChanged: (value) async {},
              ),
              Consumer<FileNameProvider>(
                builder: (context, provider, child) {
                  if (provider.diagnoseRascunhos.isNotEmpty)
                    return EditCardList(provider.diagnoseRascunhos, _index);
                  else
                    return Center(
                        child: Text(
                      "Nenhum Rascunho encontrado!",
                      style: TextStyle(fontSize: 18),
                    ));
                },
              )
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
                onClearPressed: () async {
                  _controllerRaca.text = "";

                  final res = await buscarArquivosJsonPorString(
                      _controllerRaca.text, "laudo nematológico");
                  final List<String> nomesDosArquivos = [];
                  for (final i in res) {
                    nomesDosArquivos.add(i['informacoes']['Nome_Arquivo']);
                  }

                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaDiferenciacaoDeRacaRascunhos(nomesDosArquivos);
                },
                controller: _controllerRaca,
                onSearchPressed: () async {
                  final res = await buscarArquivosJsonPorString(
                      _controllerRaca.text, "diferenciação De Raça");
                  final List<String> nomesDosArquivos = [];
                  for (final i in res) {
                    nomesDosArquivos.add(i['informacoes']['Nome_Arquivo']);
                  }

                  Provider.of<FileNameProvider>(context, listen: false)
                      .atualizaDiferenciacaoDeRacaRascunhos(nomesDosArquivos);
                },
                onChanged: (value) async {},
              ),
              Consumer<FileNameProvider>(
                builder: (context, provider, child) {
                  if (provider.diferenciacaoDeRacaRascunhos.isNotEmpty)
                    return EditCardList(
                        provider.diferenciacaoDeRacaRascunhos, _index);
                  else
                    return Center(
                        child: Text(
                      "Nenhum Rascunho encontrado!",
                      style: TextStyle(fontSize: 18),
                    ));
                },
              )
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
                      "Meus Rascunhos",
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
                            "\\gerador de laudos\\rascunhos";

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
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ScrollbarTheme(
                data: ScrollbarThemeData(
                  thumbColor: WidgetStateProperty.all<Color>(mainColor),
                ),
                child: Scrollbar(
                  controller: _sc,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _sc,
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
                            SizedBox(
                              width: 5,
                            ),
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
                            SizedBox(
                              width: 5,
                            ),
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
                            SizedBox(
                              width: 5,
                            ),
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
                            SizedBox(
                              width: 5,
                            ),
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
                            SizedBox(
                              width: 5,
                            ),
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
