import 'package:flutter/material.dart';
import '../../../reusableWidgets/insertCamp.dart';
import 'tableOfResults.dart';
import '../../../reusableWidgets/roundedButtom.dart';
import '../../../reusableWidgets/observationsList.dart';
import '../../../reusableWidgets/attachmentsList.dart';
import 'package:agro_bio_tech_pc/utils/createFiles/sanidadeDeSementes copy.dart';
import 'dart:io';
import 'dart:convert';
import 'package:agro_bio_tech_pc/constants.dart';
import 'package:agro_bio_tech_pc/providers/fileNameProvider.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

class SanidadeDeSementes extends StatefulWidget {
  SanidadeDeSementes(this._savedData, {Key? key}) : super(key: key);
  final String _savedData;

  @override
  State<SanidadeDeSementes> createState() =>
      _SanidadeDeSementesState(_savedData);
}

class _SanidadeDeSementesState extends State<SanidadeDeSementes> {
  final String _savedData;

  _SanidadeDeSementesState(this._savedData) {
    if (_savedData.isEmpty == false) {
      final data = json.decode(_savedData);
      print("Aqui:" + _savedData);
      _fileNameController.text = data['informacoes']['Nome_Arquivo'];
      _analyzeController.text = data['informacoes']['Tipo_de_analise'];
      _numberController.text = data['informacoes']['Numero_laudo'];
      _contractorController.text = data['informacoes']['Contratante'];
      _materialController.text = data['informacoes']['Material'];
      _dateController.text = data['informacoes']['Data_de_entrada'];
      _productorController.text = data['informacoes']['CNPJ'];
      _farmController.text = data['informacoes']['Fazenda'];
      _results = [];
      for (final i in data["resultados"]) {
        _results.add(TextEditingController(text: i));
      }

      for (final i in data['observacoes']) {
        TextEditingController tc = TextEditingController();
        tc.text = i;

        _observations.add(tc);
      }
      for (final i in data['anexos']) {
        _images.add(File(i));
      }
      for (final i in data['descricao_anexos']) {
        TextEditingController tc = TextEditingController();
        tc.text = i;
        _attrachmentsControllers.add(tc);
      }
    } else {}
  }

  // Informações:
  TextEditingController _analyzeController =
      TextEditingController(text: "Sanidade de sementes");
  TextEditingController _fileNameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _contractorController = TextEditingController();
  TextEditingController _materialController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _productorController = TextEditingController();
  TextEditingController _farmController = TextEditingController();

  // Resultados
  List<TextEditingController> _results = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  //Observações
  List<TextEditingController> _observations = [];

  //Anexos
  List<Widget> _attrachments = [];
  List<File> _images = [];
  List<TextEditingController> _attrachmentsControllers = [];

  int _index = 1;

  @override
  void initState() {
    super.initState();
    _index = 1;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildInfoRow(
      IconData icon, String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 3),
        RoundedTextField(controller: controller),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_index == 1) {
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 30),
                                Column(
                                  children: [
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(180.0),
                                        ),
                                        minimumSize: Size(150, 50),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.arrow_back_ios,
                                              color: Colors.white, size: 20),
                                          SizedBox(width: 3),
                                          Text(
                                            "Voltar",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          _index = _index + 1;
                                        });
                                        await _criarArquivoJson();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(180.0),
                                        ),
                                        minimumSize: Size(150, 50),
                                      ),
                                      child: Row(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Próximo",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              SizedBox(width: 3),
                                              Icon(Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                  size: 20),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(width: 30),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Informações',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 10, height: 15),
                                    _buildInfoRow(Icons.assignment,
                                        'Nome do arquivo', _fileNameController),
                                    SizedBox(height: 15, width: 5),
                                    _buildInfoRow(Icons.pin, 'Número laudo',
                                        _numberController),
                                    SizedBox(height: 15, width: 5),
                                    _buildInfoRow(Icons.business, 'Contratante',
                                        _contractorController),
                                    SizedBox(height: 15, width: 5),
                                    _buildInfoRow(Icons.biotech, 'Material',
                                        _materialController),
                                    SizedBox(height: 15, width: 5),
                                    _buildInfoRow(Icons.calendar_today,
                                        'Data de entrada', _dateController),
                                    SizedBox(height: 15, width: 5),
                                    _buildInfoRow(Icons.inventory, 'Produtor',
                                        _productorController),
                                    SizedBox(height: 15, width: 5),
                                    _buildInfoRow(Icons.landscape, 'Fazenda',
                                        _farmController),
                                    SizedBox(height: 15, width: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RoundedButton(
                                            onPressed: () async {
                                              await _criarArquivoJson();
                                            },
                                            text: "Salvar Rascunho"),
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
    if (_index == 2) {
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 30),
                                Column(
                                  children: [
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          _index = _index - 1;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(180.0),
                                        ),
                                        minimumSize: Size(150, 50),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.arrow_back_ios,
                                              color: Colors.white, size: 20),
                                          SizedBox(width: 3),
                                          Text(
                                            "Voltar",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          _index = _index + 1;
                                        });
                                        await _criarArquivoJson();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(180.0),
                                        ),
                                        minimumSize: Size(150, 50),
                                      ),
                                      child: Row(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Próximo",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              SizedBox(width: 3),
                                              Icon(Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                  size: 20),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(width: 30),
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
                                    Center(
                                      child: Text(
                                        "Resultados",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 22),
                                      ),
                                    ),
                                    DataTableWidget(
                                      controllers: [..._results],
                                    ),
                                    SizedBox(height: 15, width: 5),
                                    Center(
                                      child: RoundedButton(
                                          onPressed: () async {
                                            await _criarArquivoJson();
                                          },
                                          text: "Salvar Rascunho"),
                                    ),
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
    if (_index == 3) {
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 30),
                                Column(
                                  children: [
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          _index = _index - 1;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(180.0),
                                        ),
                                        minimumSize: Size(150, 50),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.arrow_back_ios,
                                              color: Colors.white, size: 20),
                                          SizedBox(width: 3),
                                          Text(
                                            "Voltar",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await _criarArquivoJson();

                                        setState(() {
                                          _index = _index + 1;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(180.0),
                                        ),
                                        minimumSize: Size(150, 50),
                                      ),
                                      child: Row(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Próximo",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              SizedBox(width: 3),
                                              Icon(Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                  size: 20),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(width: 30),
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
                                    Center(
                                      child: Text(
                                        "Observações",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 22),
                                      ),
                                    ),
                                    ObservationsList(
                                        controllers: _observations),
                                    SizedBox(height: 100, width: 5),
                                    Center(
                                      child: RoundedButton(
                                          onPressed: () async {
                                            await _criarArquivoJson();
                                          },
                                          text: "Salvar Rascunho"),
                                    ),
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
    if (_index == 4) {
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 30),
                                Column(
                                  children: [
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _index = _index - 1;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(180.0),
                                        ),
                                        minimumSize: Size(150, 50),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.arrow_back_ios,
                                              color: Colors.white, size: 20),
                                          SizedBox(width: 3),
                                          Text(
                                            "Voltar",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await _criarArquivoJson();

                                        await createPDF(
                                            context,
                                            _fileNameController.text,
                                            _analyzeController.text,
                                            _numberController.text,
                                            _contractorController.text,
                                            _materialController.text,
                                            _dateController.text,
                                            _productorController.text,
                                            _farmController.text,
                                            _results,
                                            _observations,
                                            _images,
                                            _attrachmentsControllers);
                                        Provider.of<FileNameProvider>(
                                                listen: false, context)
                                            .adicionaSanidadePdf(
                                                _fileNameController.text);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(180.0),
                                        ),
                                        minimumSize: Size(150, 50),
                                      ),
                                      child: Row(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Exportar",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              SizedBox(width: 3),
                                              Icon(Icons.picture_as_pdf,
                                                  color: Colors.white,
                                                  size: 40),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(width: 30),
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
                                    Center(
                                      child: Text(
                                        "Anexos",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 22),
                                      ),
                                    ),
                                    AttachmentsList(
                                      attachments: _attrachments,
                                      images: _images,
                                      observationsControllers:
                                          _attrachmentsControllers,
                                    ),
                                    SizedBox(height: 100, width: 5),
                                    Center(
                                      child: RoundedButton(
                                          onPressed: () async {
                                            await _criarArquivoJson();
                                          },
                                          text: "Salvar Rascunho"),
                                    ),
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

    return SizedBox();
  }

  Future<void> _criarArquivoJson() async {
    String nomeArquivo = "";
    String tipoAnalise = "";
    String numeroLaudo = "";
    String contratante = "";
    String material = "";
    String dataEntrada = "";
    String cnpj = "";
    String fazenda = "";

    if (_fileNameController.text.isEmpty == false) {
      nomeArquivo = _fileNameController.text;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Coloque um nome no arquivo!"),
          duration: Duration(seconds: 3),
        ),
      );

      return;
    }
    if (_analyzeController.text.isEmpty == false) {
      tipoAnalise = _analyzeController.text;
    }
    if (_numberController.text.isEmpty == false) {
      numeroLaudo = _numberController.text;
    }
    if (_contractorController.text.isEmpty == false) {
      contratante = _contractorController.text;
    }
    if (_materialController.text.isEmpty == false) {
      material = _materialController.text;
    }
    if (_dateController.text.isEmpty == false) {
      dataEntrada = _dateController.text;
    }
    if (_productorController.text.isEmpty == false) {
      cnpj = _productorController.text;
    }
    if (_farmController.text.isEmpty == false) {
      fazenda = _farmController.text;
    }

    final results = [];

    for (final r in _results) {
      results.add(r.text);
    }

    final observacoes = [];

    for (final o in _observations) {
      observacoes.add(o.text);
    }

    final anexos = [];

    for (final i in _images) {
      anexos.add(i.path);
    }

    final descricaoAnexos = [];

    for (final da in _attrachmentsControllers) {
      descricaoAnexos.add(da.text);
    }

    Map<String, dynamic> dados = {
      "informacoes": {
        "Nome_Arquivo": nomeArquivo,
        "Tipo_de_analise": tipoAnalise,
        "Numero_laudo": numeroLaudo,
        "Contratante": contratante,
        "Material": material,
        "Data_de_entrada": dataEntrada,
        "CNPJ": cnpj,
        "Fazenda": fazenda,
      },
      "resultados": results,
      "observacoes": observacoes,
      "anexos": anexos,
      "descricao_anexos": descricaoAnexos,
    };

    String jsonString = json.encode(dados);

    await _createAndWriteToFile(nomeArquivo, jsonString);
  }

  Future<void> _createAndWriteToFile(String nome, String jsonData) async {
    try {
      // Obter o diretório de documentos
      Directory documentsDirectory = await getApplicationDocumentsDirectory();

      // Criar a pasta "rascunhos" se não existir
      String rascunhosPath =
          '${documentsDirectory.path}/gerador de laudos/rascunhos/sanidade De Sementes';
      await Directory(rascunhosPath).create(recursive: true);
      Provider.of<FileNameProvider>(listen: false, context)
          .adicionaSanidadeRascunho(_fileNameController.text);

      // Criar o arquivo JSON
      File file = File('$rascunhosPath/$nome.json');

      // Escrever os dados no arquivo
      await file.writeAsString(jsonData);

      // Exibir mensagem de sucesso usando um SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("O rascunho foi salvo com sucesso!"),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green, // Definindo a cor de fundo como verde
        ),
      );
    } catch (e) {
      // Exibir mensagem de erro usando um SnackBar, se houver
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao criar o arquivo!"),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
