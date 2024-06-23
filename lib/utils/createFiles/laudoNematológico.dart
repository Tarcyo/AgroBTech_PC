import 'package:flutter/material.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:agro_bio_tech_pc/pages/createFileScreen/laudoNematológico/tableOfResults.dart';

pw.Widget _buildItem(String title, String value) {
  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        title,
        style: pw.TextStyle(
          color: PdfColors.black,
          fontSize: 11,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
      pw.SizedBox(width: 5),
      pw.Expanded(
        child: pw.Stack(
          alignment: pw.Alignment.centerLeft,
          children: [
            pw.Container(
              width: 120, // Ajuste conforme necessário
              margin: const pw.EdgeInsets.only(left: 5.0, top: 5.0),
              child: pw.Divider(color: PdfColors.black, thickness: 1),
            ),
            pw.Container(
              margin: const pw.EdgeInsets.only(left: 5.0, bottom: 5.0),
              child: pw.Text(
                value,
                style: pw.TextStyle(
                  color: PdfColors.blueAccent700,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Future<void> createPDF(
    BuildContext context,
    String nomeArquivo,
    String tipoAnalise,
    String numeroLaudo,
    String cliente,
    String material,
    String dataEntrada,
    String proprietario,
    String fazenda,
    String responsavel,
    List<DataRow> resultados,
    List<TextEditingController> observacaoes,
    List<File> imagens,
    List<TextEditingController> descricoes) async {
  final String dataEmissao = DateTime.now().day.toString() +
      "/" +
      DateTime.now().month.toString() +
      "/" +
      DateTime.now().year.toString();
  if (nomeArquivo.isEmpty == false) {
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
  if (tipoAnalise.isEmpty) {
    tipoAnalise = "-";
  }
  if (numeroLaudo.isEmpty) {
    numeroLaudo = "-";
  }
  if (cliente.isEmpty) {
    cliente = "-";
  }
  if (material.isEmpty) {
    material = "-";
  }
  if (dataEntrada.isEmpty) {
    dataEntrada = "-";
  }
  if (proprietario.isEmpty) {
    proprietario = "-";
  }
  if (responsavel.isEmpty) {
    responsavel = "-";
  }
  if (fazenda.isEmpty) {
    fazenda = "-";
  }

  final dataResults = [];

  for (final r in resultados) {
    final cells = [];

    for (final c in r.cells) {
      final cell = c.child as TableTextCell;
      cells.add(cell.controller.text);
    }
    dataResults.add(cells);
  }

  final Idlaboratorio = [];
  final IDENTIFICACAODAAMOSTRA = [];
  final MATERIALANALISADO = [];
  final Meloidogyne = [];
  final Pratylenchussp = [];
  final Pratylenchusbrachyurus = [];
  final Pratylenchuszeae = [];
  final Heteroderasp = [];
  final Tubixabasp = [];
  final Rotylechulusreniformis = [];
  final Helicotylenchusdihystera = [];
  final Cistosviaveis = [];
  final Cistosinviaveis = [];

  for (int i = 0; i < dataResults.length; i++) {
    PdfColor corDoTexto = PdfColors.black;
    PdfColor corDaLinha = PdfColors.white;
    if (i % 2 != 0) {
      corDaLinha = PdfColor.fromHex("C4D69B");
      corDoTexto = PdfColors.blueAccent700;
    }

    final containerDecoration = pw.BoxDecoration(
      color: corDaLinha,
      border: pw.Border.all(
          color: PdfColors.black, width: 1), // Adicionando borda preta
    );

    Idlaboratorio.add(
      pw.Expanded(
        child: pw.Container(
          decoration: containerDecoration,
          child: pw.Center(
            child: pw.Text(
              dataResults[i][0],
              style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold,color: corDoTexto ),
            ),
          ),
        ),
      ),
    );
    IDENTIFICACAODAAMOSTRA.add(
      pw.Expanded(
        child: pw.Container(
          decoration: containerDecoration,
          child: pw.Center(
            child: pw.Text(
              dataResults[i][1],
              style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold,color: corDoTexto),
            ),
          ),
        ),
      ),
    );

    MATERIALANALISADO.add(
      pw.Expanded(
        child: pw.Container(
          decoration: containerDecoration,
          child: pw.Center(
            child: pw.Text(
              dataResults[i][2],
              style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold,color: corDoTexto),
            ),
          ),
        ),
      ),
    );
    Meloidogyne.add(
      pw.Expanded(
        child: pw.Container(
          decoration: containerDecoration,
          child: pw.Center(
            child: pw.Text(
              dataResults[i][3],
              style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold,color: corDoTexto),
            ),
          ),
        ),
      ),
    );
    Pratylenchussp.add(
      pw.Expanded(
        child: pw.Container(
          decoration: containerDecoration,
          child: pw.Center(
            child: pw.Text(
              dataResults[i][4],
              style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold,color: corDoTexto),
            ),
          ),
        ),
      ),
    );
    Pratylenchusbrachyurus.add(
      pw.Expanded(
        child: pw.Container(
          decoration: containerDecoration,
          child: pw.Center(
            child: pw.Text(
              dataResults[i][5],
              style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold,color: corDoTexto),
            ),
          ),
        ),
      ),
    );
    Pratylenchuszeae.add(
      pw.Expanded(
        child: pw.Container(
          decoration: containerDecoration,
          child: pw.Center(
            child: pw.Text(
              dataResults[i][6],
              style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold,color: corDoTexto),
            ),
          ),
        ),
      ),
    );
    Heteroderasp.add(
      pw.Expanded(
        child: pw.Container(
          decoration: containerDecoration,
          child: pw.Center(
            child: pw.Text(
              dataResults[i][7],
              style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold,color: corDoTexto),
            ),
          ),
        ),
      ),
    );
    Tubixabasp.add(
      pw.Expanded(
        child: pw.Container(
          decoration: containerDecoration,
          child: pw.Center(
            child: pw.Text(
              dataResults[i][8],
              style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold,color: corDoTexto),
            ),
          ),
        ),
      ),
    );
    Rotylechulusreniformis.add(
      pw.Expanded(
        child: pw.Container(
          decoration: containerDecoration,
          child: pw.Center(
            child: pw.Text(
              dataResults[i][9],
              style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold,color: corDoTexto),
            ),
          ),
        ),
      ),
    );
    Helicotylenchusdihystera.add(
      pw.Expanded(
        child: pw.Container(
          decoration: containerDecoration,
          child: pw.Center(
            child: pw.Text(
              dataResults[i][10],
              style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold,color: corDoTexto),
            ),
          ),
        ),
      ),
    );
    Cistosviaveis.add(
      pw.Expanded(
        child: pw.Container(
          decoration: containerDecoration,
          child: pw.Center(
            child: pw.Text(
              dataResults[i][11],
              style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold,color: corDoTexto),
            ),
          ),
        ),
      ),
    );

    Cistosinviaveis.add(
      pw.Expanded(
        child: pw.Container(
          decoration: containerDecoration,
          child: pw.Center(
            child: pw.Text(
              dataResults[i][12],
              style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold,color: corDoTexto),
            ),
          ),
        ),
      ),
    );
  }

  List<pw.Widget> observacoesWidgets = [];
  for (int i = 0; i < observacaoes.length; i++) {
    observacoesWidgets.add(
      pw.Text((i + 1).toString() + ") " + observacaoes[i].text,
          style: const pw.TextStyle(
            fontSize: 9,
          )),
    );
  }
  List<pw.Widget> anexos = [];
  for (int i = 0; i < imagens.length; i++) {
    final fileBytes = await imagens[i].readAsBytes();
    anexos.add(pw.Center(
      child: pw.Image(pw.MemoryImage(fileBytes), width: 100, height: 100),
    ));

    anexos.add(
      pw.SizedBox(
        height: 5,
      ),
    );
    anexos.add(
      pw.Center(
        child:
            pw.Text("Figura " + (i + 1).toString() + ". " + descricoes[i].text,
                style: const pw.TextStyle(
                  fontSize: 14,
                )),
      ),
    );
  }
  var imageData;

  imageData =
      (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List();
  final logo = pw.MemoryImage(imageData);

  final pdf = pw.Document();

  pdf.addPage(
    index: 0,
    pw.MultiPage(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      maxPages: 27,
      pageTheme: pw.PageTheme(
        margin: pw.EdgeInsets.all(15),
        clip: true,
        buildBackground: (context) {
          return pw.SizedBox(width: 13);
        },
      ),
      build: (pw.Context context) {
        return [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Add first text
              pw.Center(
                child: pw.Image(logo, width: 100, height: 100),
              ),
              pw.SizedBox(
                width: 60,
              ),

              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text("Agro Btech ",
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black,
                          fontSize: 9)),
                  pw.Text("Laboratório de Análises Biológicas ME",
                      style: pw.TextStyle(color: PdfColors.black, fontSize: 9)),
                  pw.Text("CNPJ 41.966.054/0001-93",
                      style: pw.TextStyle(color: PdfColors.black, fontSize: 9)),
                  pw.Text("Avenida Lazinho Pimenta N²440 Qd.20",
                      style: pw.TextStyle(color: PdfColors.black, fontSize: 9)),
                  pw.Text(
                      "Setor Municipal de Pequenas Empresas – Rio Verde GO ",
                      style: pw.TextStyle(color: PdfColors.black, fontSize: 9)),
                  pw.Text("E-mail: laboratorio@agrobiontech.com ",
                      style: pw.TextStyle(color: PdfColors.black, fontSize: 9)),
                ],
              ),
              // Add spacer to create space between te
              // Add third text
            ],
          ),
          pw.SizedBox(
            height: 5,
          ),
          pw.SizedBox(
            height: 15,
          ),
          pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        _buildItem("Materila Analisado:", material),
                        pw.SizedBox(height: 0.1),
                        _buildItem("Cliente", cliente),
                        pw.SizedBox(height: 0.1),
                        _buildItem("Responsavel pela entrega:", responsavel),
                        pw.SizedBox(height: 0.1),
                        _buildItem("Data de entrega:", dataEntrada),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 10),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        _buildItem("Tipo de analise:", tipoAnalise),
                        pw.SizedBox(height: 0.1),
                        _buildItem("Fazenda:", fazenda),
                        pw.SizedBox(height: 0.1),
                        _buildItem("Data do laudo:", dataEmissao),
                        pw.SizedBox(height: 0.1),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
            ],
          ),
          pw.SizedBox(
            height: 6,
          ),
          pw.SizedBox(
            width: 30,
          ),
          //TABELA
          pw.Container(
              width: double.infinity,
              height: 15,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1, // Largura da borda
                ),
                color: PdfColor.fromHex("76923B"), // Cor de fundo branca
              ),
              child: pw.Center(
                  child: pw.Text(
                      "RESULTADOS DA(s) ANÁLISE(s) MICROBIOLÓGICA(s): NEMATOIDES",
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 8,
                          color: PdfColors.black)))),
          pw.SizedBox(height: 3),

          pw.Center(
            child: pw.SizedBox(
              height: 85 + (dataResults.length * 50),
              width: 5000,
              child: pw.Container(
                decoration: pw.BoxDecoration(),
                child: pw.Row(
                  children: [
                    // Coluna 1
                    pw.Expanded(
                      flex: 8,
                      child: pw.Column(
                        children: [
                          // Título da coluna
                          pw.Expanded(
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                color: PdfColor.fromHex("C4D69B"),
                                border: pw.Border.all(
                                  color: PdfColors.black,
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Column(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.center,
                                  children: [
                                    pw.Text(
                                      " Id.",
                                      style: pw.TextStyle(
                                          fontSize: 7,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                    pw.Text(
                                      "laboratório",
                                      style: pw.TextStyle(
                                          fontSize: 7,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Espaço para conteúdo
                          ...Idlaboratorio,
                        ],
                      ),
                    ),

                    // Coluna 2
                    pw.Expanded(
                      flex: 7,
                      child: pw.Column(
                        children: [
                          // Título da coluna
                          pw.Expanded(
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                color: PdfColor.fromHex("C4D69B"),
                                border: pw.Border.all(
                                  color: PdfColors.black,
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Column(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.center,
                                  children: [
                                    pw.Text(
                                      " Id. ",
                                      style: pw.TextStyle(
                                          fontSize: 7,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                    pw.Text(
                                      "Amostra",
                                      style: pw.TextStyle(
                                          fontSize: 7,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Espaço para conteúdo
                          ...IDENTIFICACAODAAMOSTRA
                        ],
                      ),
                    ),

                    pw.Expanded(
                      flex: 8,
                      child: pw.Column(
                        children: [
                          // Título da coluna
                          pw.Expanded(
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                color: PdfColor.fromHex("C4D69B"),
                                border: pw.Border.all(
                                  color: PdfColors.black,
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Transform.rotate(
                                  angle: 90 * (3.14159 / 180),
                                  child: pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Text(
                                        "Material",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                      pw.Text(
                                        "Utilizado",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Espaço para conteúdo
                          ...MATERIALANALISADO
                        ],
                      ),
                    ),

                    // Coluna 3
                    pw.Expanded(
                      flex: 10,
                      child: pw.Column(
                        children: [
                          // Título da coluna
                          pw.Expanded(
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                color: PdfColor.fromHex("C4D69B"),
                                border: pw.Border.all(
                                  color: PdfColors.black,
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Transform.rotate(
                                  angle: 90 * (3.14159 / 180),
                                  child: pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Text(
                                        "Meloidogyne",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                      pw.Text(
                                        "sp",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Espaço para conteúdo
                          ...Meloidogyne
                        ],
                      ),
                    ),
                    // Coluna 4
                    pw.Expanded(
                      flex: 9,
                      child: pw.Column(
                        children: [
                          // Título da coluna
                          pw.Expanded(
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                color: PdfColor.fromHex("C4D69B"),
                                border: pw.Border.all(
                                  color: PdfColors.black,
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Transform.rotate(
                                  angle: 90 * (3.14159 / 180),
                                  child: pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Text(
                                        "Pratylenchus",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                      pw.Text(
                                        "sp",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Espaço para conteúdo
                          ...Pratylenchussp
                        ],
                      ),
                    ),
                    // Coluna 5
                    pw.Expanded(
                      flex: 9,
                      child: pw.Column(
                        children: [
                          // Título da coluna
                          pw.Expanded(
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                color: PdfColor.fromHex("C4D69B"),
                                border: pw.Border.all(
                                  color: PdfColors.black,
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Transform.rotate(
                                  angle: 90 * (3.14159 / 180),
                                  child: pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Text(
                                        "Pratylenchus",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                      pw.Text(
                                        "brachyurus",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Espaço para conteúdo
                          ...Pratylenchusbrachyurus
                        ],
                      ),
                    ),
                    // Coluna 6
                    pw.Expanded(
                      flex: 9,
                      child: pw.Column(
                        children: [
                          // Título da coluna
                          pw.Expanded(
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                color: PdfColor.fromHex("C4D69B"),
                                border: pw.Border.all(
                                  color: PdfColors.black,
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Transform.rotate(
                                  angle: 90 * (3.14159 / 180),
                                  child: pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Text(
                                        "Pratylenchus",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                      pw.Text(
                                        "zeae",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Espaço para conteúdo
                          ...Pratylenchuszeae
                        ],
                      ),
                    ),
                    // Coluna 7
                    pw.Expanded(
                      flex: 9,
                      child: pw.Column(
                        children: [
                          // Título da coluna
                          pw.Expanded(
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                color: PdfColor.fromHex("C4D69B"),
                                border: pw.Border.all(
                                  color: PdfColors.black,
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Transform.rotate(
                                  angle: 90 * (3.14159 / 180),
                                  child: pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Text(
                                        "Heterodera",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                      pw.Text(
                                        "sp.",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Espaço para conteúdo
                          ...Heteroderasp
                        ],
                      ),
                    ),
                    // Coluna 8
                    pw.Expanded(
                      flex: 9,
                      child: pw.Column(
                        children: [
                          // Título da coluna
                          pw.Expanded(
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                color: PdfColor.fromHex("C4D69B"),
                                border: pw.Border.all(
                                  color: PdfColors.black,
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Transform.rotate(
                                  angle: 90 * (3.14159 / 180),
                                  child: pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Text(
                                        "Tubixaba",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                      pw.Text(
                                        "sp.",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Espaço para conteúdo
                          ...Tubixabasp
                        ],
                      ),
                    ),
                    // Coluna 9
                    pw.Expanded(
                      flex: 9,
                      child: pw.Column(
                        children: [
                          // Título da coluna
                          pw.Expanded(
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                color: PdfColor.fromHex("C4D69B"),
                                border: pw.Border.all(
                                  color: PdfColors.black,
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Transform.rotate(
                                  angle: 90 * (3.14159 / 180),
                                  child: pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Text(
                                        "Rotylechulus",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                      pw.Text(
                                        "reniformis",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Espaço para conteúdo
                          ...Rotylechulusreniformis
                        ],
                      ),
                    ),
                    // Coluna 10
                    pw.Expanded(
                      flex: 12,
                      child: pw.Column(
                        children: [
                          // Título da coluna
                          pw.Expanded(
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                color: PdfColor.fromHex("C4D69B"),
                                border: pw.Border.all(
                                  color: PdfColors.black,
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Transform.rotate(
                                  angle: 90 * (3.14159 / 180),
                                  child: pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Text(
                                        "Helicotylenchus",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                      pw.Text(
                                        "dihystera",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Espaço para conteúdo
                          ...Helicotylenchusdihystera
                        ],
                      ),
                    ),
                    // Coluna 11
                    pw.Expanded(
                      flex: 8,
                      child: pw.Column(
                        children: [
                          // Título da coluna
                          pw.Expanded(
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                color: PdfColor.fromHex("C4D69B"),
                                border: pw.Border.all(
                                  color: PdfColors.black,
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Transform.rotate(
                                  angle: 90 * (3.14159 / 180),
                                  child: pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Text(
                                        "Cistos",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                      pw.Text(
                                        "viáveis",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Espaço para conteúdo
                          ...Cistosviaveis
                        ],
                      ),
                    ),
                    // Coluna 12
                    pw.Expanded(
                      flex: 6,
                      child: pw.Column(
                        children: [
                          // Título da coluna
                          pw.Expanded(
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                color: PdfColor.fromHex("C4D69B"),
                                border: pw.Border.all(
                                  color: PdfColors.black,
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Transform.rotate(
                                  angle: 90 * (3.14159 / 180),
                                  child: pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Text(
                                        "Cistos",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                      pw.Text(
                                        "inviáveis",
                                        style: pw.TextStyle(
                                            fontSize: 7,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          ...Cistosinviaveis
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
            pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(height: 3),
                  pw.Text(
                      "SOLO: 100 cm3.   RAÍZES: 10g.  - Quantidades inferiores nas amostras de solo ou raiz inviabilizam a conclusão dos resultados da análise, uma vez que os resultados são dados mediante esses valores.",
                      style: pw.TextStyle(
                          fontSize: 5, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 3),
                  pw.Text(
                      "Métodos de Extração: Extração de cistos Nematoide de cisto (Heterodera glycines) de solo  e raiz - (Tihohod & Santos, 1993). ",
                      style: pw.TextStyle(
                        fontSize: 5,
                      )),
                  pw.SizedBox(height: 3),
                  pw.Text(
                      "Extração de Nematoides do solo - Método da flutuação centrífuga em solução de sacarose (Jenkins, 1964). ",
                      style: pw.TextStyle(
                        fontSize: 5,
                      )),
                  pw.SizedBox(height: 3),
                  pw.Text(
                      "Extração de Nematoides da raiz: Método de flutuação centrífuga  em solução de sacarose com caulim (Coolen & D'herde, 1972).",
                      style: pw.TextStyle(
                        fontSize: 5,
                      )),
                ]),
          ])
        ];
      },
    ),
  );

  // Get the documents directory
  // Obter o diretório de documentos
  Directory documentsDirectory = await getApplicationDocumentsDirectory();

  // Criar a pasta "rascunhos" se não existir
  String folderPath = '${documentsDirectory.path}\\meus pdfs';
  await Directory(folderPath).create(recursive: true);

  bool salvou = true;

  try {
    final path = '$folderPath/' + nomeArquivo + ".pdf";

    // Save the PDF
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    Share.shareXFiles([XFile(path)], text: 'Compartilhando PDF');
    OpenFile.open(path);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.red, // Cor de fundo verde
      content: Text(
        'Erro ao salvar o PDF!',
        style: TextStyle(fontSize: 18),
      ),
      duration: Duration(seconds: 3),
    ));
    salvou = false; // Duração do Snackbar
  }

  if (salvou == true) {
    // Caminho para o arquivo PDF
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.green, // Cor de fundo verde
      content: Text(
        'O laudo foi salvo com sucesso!',
        style: TextStyle(fontSize: 18),
      ),
      duration: Duration(seconds: 3),
    ));
  }
}
