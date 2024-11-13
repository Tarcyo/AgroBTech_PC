import 'package:flutter/material.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:agro_bio_tech_pc/pages/createFileScreen/laudoMicrobiológico/tableOfResults.dart';
import 'package:agro_bio_tech_pc/pages/createFileScreen/PdfviewScreen.dart';

Future<void> createPDF(
    BuildContext context,
    String nomeArquivo,
    String tipoAnalise,
    String numeroLaudo,
    String contratante,
    String material,
    String dataEntrada,
    String produtor,
    String fazenda,
    List<DataRow> resultados,
    List<TextEditingController> criteriaByMacrophominaControllers,
    List<TextEditingController> criteriaByFactorControllers,
    List<TextEditingController> observacaoes,
    List<File> imagens,
    List<TextEditingController> descricoes) async {
  if (nomeArquivo.isEmpty) {
    return;
  }
  // Exibe o diálogo de carregamento
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Gerando PDF...",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                strokeWidth: 8.0, // Espessura da linha
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ),
      );
    },
  );
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
  if (contratante.isEmpty) {
    contratante = "-";
  }
  if (material.isEmpty) {
    material = "-";
  }
  if (dataEntrada.isEmpty) {
    dataEntrada = "-";
  }
  if (produtor.isEmpty) {
    produtor = "-";
  }
  if (fazenda.isEmpty) {
    fazenda = "-";
  }
  final dataResults = [];

  for (final r in resultados) {
    final cells = [];
    for (final c in r.cells) {
      final cell = c.child as TableTextCell;
      if (cell.controller.text.isEmpty == false) {
        cells.add(cell.controller.text);
      } else {
        cells.add(" - ");
      }
    }
    dataResults.add(cells);
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

  imageData =
      (await rootBundle.load('assets/images/qr.png')).buffer.asUint8List();
  final qr = pw.MemoryImage(imageData);

  imageData =
      (await rootBundle.load('assets/images/fundo.png')).buffer.asUint8List();
  final fundo = pw.MemoryImage(imageData);

  imageData =
      (await rootBundle.load('assets/images/rubrica.png')).buffer.asUint8List();
  final rubrica = pw.MemoryImage(imageData);
  final pdf = pw.Document();

  final fontData = await rootBundle.load("assets/fonts/Arial/Arial.ttf");
  final customFont = pw.Font.ttf(fontData);

  // Definindo o tema global com a fonte personalizada
  final theme = pw.ThemeData.withFont(
    base: customFont, // Define a fonte padrão para o texto
  );

  pdf.addPage(
    index: 0,
    pw.MultiPage(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      maxPages: 67,
      pageTheme: pw.PageTheme(
        theme: theme,
        clip: true,
        margin: pw.EdgeInsets.all(20),
        buildBackground: (context) {
          return pw.Container(
              // Adicionar imagem de fundo
              decoration: pw.BoxDecoration(
            image: pw.DecorationImage(
              image: fundo,
              fit: pw.BoxFit.cover,
            ),
          ));
        },
      ),
      build: (pw.Context context) {
        return [
          pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Add first text
                    pw.Center(
                      child: pw.Image(logo, width: 100, height: 100),
                    ),

                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Agro Btech ",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.orange,
                                fontSize: 12)),
                        pw.Text("Laboratório de Análises Biológicas ME ",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.orange,
                                fontSize: 12)),
                        pw.Text("CNPJ 41.966.054/0001-93 ",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.orange,
                                fontSize: 12)),
                      ],
                    ),
                    // Add spacer to create space between text
                    pw.SizedBox(width: 20),
                    // Add third text
                    pw.Center(
                      child: pw.Image(qr, width: 50, height: 50),
                    ),
                  ],
                ),
                pw.SizedBox(
                  height: 20,
                ),
                pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      color: PdfColors.black, // Cor da borda preta
                      width: 1, // Largura da borda
                    ),
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.SizedBox(
                        height: 5,
                        width: 5,
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Row(
                            children: [
                              pw.Text(
                                "Tipo análise",
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                          pw.Row(
                            children: [
                              pw.Text(
                                "Número Laudo:",
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                          pw.Row(
                            children: [
                              pw.Text(
                                "Contratante:",
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                              pw.SizedBox(width: 45),
                            ],
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                          pw.Row(
                            children: [
                              pw.Text(
                                "Material:",
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                          pw.Row(
                            children: [
                              pw.Text(
                                "Data Entrada:",
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Row(
                            children: [
                              pw.Text(tipoAnalise,
                                  style: const pw.TextStyle(fontSize: 10)),
                            ],
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                          pw.Row(
                            children: [
                              pw.Text(numeroLaudo,
                                  style: const pw.TextStyle(fontSize: 10)),
                            ],
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                          pw.Row(
                            children: [
                              pw.Text(contratante,
                                  style: const pw.TextStyle(fontSize: 10)),
                            ],
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                          pw.Row(
                            children: [
                              pw.Text(material,
                                  style: const pw.TextStyle(fontSize: 10)),
                            ],
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                          pw.Row(
                            children: [
                              pw.Text(dataEntrada,
                                  style: const pw.TextStyle(fontSize: 10)),
                            ],
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 30, width: 70),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Row(
                            children: [
                              pw.Text(
                                "Produtor:",
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                          pw.Row(
                            children: [
                              pw.Text(
                                "Fazenda:",
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                          pw.Row(
                            children: [
                              pw.Text(
                                "Data Emissão:",
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                      pw.SizedBox(width: 5),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Row(
                            children: [
                              pw.Text(produtor,
                                  style: const pw.TextStyle(fontSize: 10)),
                            ],
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                          pw.Row(
                            children: [
                              pw.Text(fazenda,
                                  style: const pw.TextStyle(fontSize: 10)),
                            ],
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                          pw.Row(
                            children: [
                              pw.Text(dataEmissao,
                                  style: const pw.TextStyle(fontSize: 10)),
                            ],
                          ),
                          pw.SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(
                  height: 5,
                ),
                pw.Container(
                    width: double.infinity,
                    height: 25,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                        color: PdfColors.orange, // Cor da borda preta
                        width: 1, // Largura da borda
                      ),
                      color: PdfColors.orange, // Cor de fundo branca
                    ),
                    child: pw.Center(
                        child: pw.Text("RESULTADOS",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 14,
                                color: PdfColors.white)))),
                pw.SizedBox(
                  height: 12,
                ),
                pw.Center(
                  child: pw.SizedBox(
                    height: 200,
                    width: 1000,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                        ),
                      ),
                      child: pw.Row(
                        children: [
                          // Coluna 1
                          pw.Expanded(
                            child: pw.Column(children: [
                              pw.Expanded(
                                child: pw.Container(
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  child: pw.Center(
                                    child: pw.Text(
                                      "Id. Laboratório",
                                      style: pw.TextStyle(fontSize: 9),
                                    ),
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  child: pw.Center(
                                    child: pw.Text(
                                      dataResults[0][0],
                                      style: pw.TextStyle(fontSize: 9),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),

                          // Coluna 2
                          pw.Expanded(
                            child: pw.Column(children: [
                              pw.Expanded(
                                child: pw.Container(
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  child: pw.Center(
                                    child: pw.Text(
                                      "Id. cliente",
                                      style: pw.TextStyle(fontSize: 9),
                                    ),
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  child: pw.Center(
                                    child: pw.Text(
                                      dataResults[0][1],
                                      style: pw.TextStyle(fontSize: 9),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),

                          // Coluna 3
                          pw.Expanded(
                            child: pw.Column(children: [
                              pw.Expanded(
                                child: pw.Container(
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  child: pw.Expanded(
                                    child: pw.Row(children: [
                                      pw.Expanded(
                                        child: pw.Container(
                                            decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                color: PdfColors.black,
                                              ),
                                            ),
                                            child: pw.Column(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.center,
                                                crossAxisAlignment: pw
                                                    .CrossAxisAlignment.center,
                                                children: [
                                                  pw.Text(
                                                    "Fusarium",
                                                    style: pw.TextStyle(
                                                        fontSize: 9,
                                                        fontStyle: pw
                                                            .FontStyle.italic),
                                                  ),
                                                  pw.Text(
                                                    "solani",
                                                    style: pw.TextStyle(
                                                        fontSize: 9,
                                                        fontStyle: pw
                                                            .FontStyle.italic),
                                                  ),
                                                ])),
                                      ),
                                      pw.Expanded(
                                        child: pw.Container(
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                              color: PdfColors.black,
                                            ),
                                          ),
                                          child: pw.Column(
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              children: [
                                                pw.Text(
                                                  "Fusarium",
                                                  style: pw.TextStyle(
                                                      fontSize: 9,
                                                      fontStyle:
                                                          pw.FontStyle.italic),
                                                ),
                                                pw.Text(
                                                  "oxysporium",
                                                  style: pw.TextStyle(
                                                      fontSize: 9,
                                                      fontStyle:
                                                          pw.FontStyle.italic),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  child: pw.Center(
                                    child: pw.Text(
                                      "UFC/g de solo1",
                                      style: pw.TextStyle(fontSize: 9),
                                    ),
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  child: pw.Center(
                                    child: pw.Expanded(
                                      child: pw.Row(children: [
                                        pw.Expanded(
                                          child: pw.Container(
                                            decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                color: PdfColors.black,
                                              ),
                                            ),
                                            child: pw.Center(
                                              child: pw.Text(
                                                dataResults[0][2],
                                                style:
                                                    pw.TextStyle(fontSize: 9),
                                              ),
                                            ),
                                          ),
                                        ),
                                        pw.Expanded(
                                          child: pw.Container(
                                            decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                color: PdfColors.black,
                                              ),
                                            ),
                                            child: pw.Center(
                                              child: pw.Text(
                                                dataResults[0][3],
                                                style:
                                                    pw.TextStyle(fontSize: 9),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),

                          // Coluna 4
                          pw.Expanded(
                            child: pw.Column(children: [
                              pw.Expanded(
                                child: pw.Container(
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  child: pw.Center(
                                    child: pw.Text(
                                      "Rhizoctonia spp",
                                      style: pw.TextStyle(
                                          fontSize: 9,
                                          fontStyle: pw.FontStyle.italic),
                                    ),
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  child: pw.Center(
                                    child: pw.Text(
                                      "%",
                                      style: pw.TextStyle(fontSize: 9),
                                    ),
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  child: pw.Center(
                                    child: pw.Text(
                                      dataResults[0][4],
                                      style: pw.TextStyle(fontSize: 9),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),

                          // Coluna 5
                          pw.Expanded(
                            child: pw.Column(children: [
                              pw.Expanded(
                                child: pw.Container(
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  child: pw.Center(
                                    child: pw.Text(
                                      "Macrophomina phaseolina",
                                      style: pw.TextStyle(
                                          fontSize: 9,
                                          fontStyle: pw.FontStyle.italic),
                                    ),
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  child: pw.Center(
                                    child: pw.Text(
                                      "Microescleródios/g de solo",
                                      style: pw.TextStyle(fontSize: 9),
                                    ),
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  child: pw.Center(
                                    child: pw.Text(
                                      dataResults[0][5],
                                      style: pw.TextStyle(fontSize: 9),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                pw.SizedBox(height: 15),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                                "1 Unidade formadora de colônia por grama de solo. ",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.grey,
                                    fontSize: 8)),
                            pw.SizedBox(height: 3),
                            pw.Text("NR: Não realizado ",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.grey,
                                    fontSize: 8)),
                            pw.SizedBox(height: 3),
                            pw.Text("EA: Em análise",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.grey,
                                    fontSize: 8)),
                            pw.SizedBox(height: 3),
                            pw.Text(
                                "As amostras foram examinadas segundo metodologia de diluição em série e plaqueamento profundo em meio Nash e Snyder para Fusarium solani,\n meio Komada para Fusarium oxysporium, densidade de microescleródios no solo em meio BDA+Triton para Macrophomina phaseolina e método de \n isca qualitativo em meio Ágar-água para Rhizoctonia spp.",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.grey,
                                    fontSize: 8))
                          ]),
                    ]),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Row(children: [
                  pw.SizedBox(
                    width: 35,
                  ),
                  pw.Text("Observações: ",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 10,
                      )),
                ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.SizedBox(
                        width: 70,
                      ),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [...observacoesWidgets])
                    ]),
                pw.SizedBox(
                  height: 25,
                ),
                pw.Center(
                  child: pw.SizedBox(
                    height: 350,
                    width: 1000,
                    child: pw.Column(
                      children: [
                        pw.Container(
                          width: double.infinity,
                          height: 25,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                              color: PdfColors.orange, // Cor da borda laranja
                              width: 1, // Largura da borda
                            ),
                            color: PdfColors.orange, // Cor de fundo laranja
                          ),
                          child: pw.Center(
                            child: pw.Text(
                              "INTERPRETAÇÃO DOS RESULTADOS",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 14,
                                color: PdfColors.white,
                              ),
                            ),
                          ),
                        ),
                        pw.SizedBox(height: 5),

                        // Linha 1 (Cabeçalho)
                        pw.Divider(height: 2),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Container(
                                child: pw.Center(
                                  child: pw.Text(
                                    "Risco",
                                    style: pw.TextStyle(
                                      fontSize: 11,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.Container(
                                child: pw.Center(
                                  child: pw.Text(
                                    "Critério para fator triplo",
                                    style: pw.TextStyle(
                                      fontSize: 11,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.Container(
                                child: pw.Center(
                                  child: pw.Text(
                                    "Critério para macrophomina",
                                    style: pw.TextStyle(
                                      fontSize: 11,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        pw.Divider(height: 2),
                        pw.SizedBox(height: 1),

                        // Linha 2 (Muito Alto)
                        pw.Expanded(
                          child: pw.Row(
                            children: [
                              pw.Expanded(
                                child: pw.Container(
                                  decoration:
                                      pw.BoxDecoration(color: PdfColors.red),
                                  child: pw.Center(
                                    child: pw.Text(
                                      "Muito alto",
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  height: 500,
                                  child: pw.Center(
                                    child: pw.Row(children: [
                                      pw.SizedBox(width: 15),
                                      pw.Column(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.center,
                                        children: [
                                          pw.RichText(
                                            text: pw.TextSpan(
                                              children: [
                                                pw.TextSpan(
                                                  text: "Fusarium solani",
                                                  style: pw.TextStyle(
                                                    fontSize: 6,
                                                    fontStyle: pw.FontStyle
                                                        .italic, // Itálico apenas para o nome científico
                                                  ),
                                                ),
                                                pw.TextSpan(
                                                  text: " ou ",
                                                  style:
                                                      pw.TextStyle(fontSize: 6),
                                                ),
                                                pw.TextSpan(
                                                  text: "Fusarium oxysporum",
                                                  style: pw.TextStyle(
                                                    fontSize: 6,
                                                    fontStyle: pw.FontStyle
                                                        .italic, // Itálico para o nome científico
                                                  ),
                                                ),
                                                pw.TextSpan(
                                                  text:
                                                      " superior a 3000 UFC/g solo",
                                                  style:
                                                      pw.TextStyle(fontSize: 6),
                                                ),
                                              ],
                                            ),
                                            textAlign: pw.TextAlign.center,
                                            softWrap: true,
                                          ),
                                          pw.Text(
                                            "E",
                                            style: pw.TextStyle(
                                              fontSize: 6,
                                              fontWeight: pw.FontWeight.bold,
                                            ),
                                            textAlign: pw.TextAlign.center,
                                            softWrap: true,
                                          ),
                                          pw.RichText(
                                            text: pw.TextSpan(
                                              children: [
                                                pw.TextSpan(
                                                  text: "Rhizoctonia solani",
                                                  style: pw.TextStyle(
                                                    fontSize: 6,
                                                    fontStyle: pw.FontStyle
                                                        .italic, // Itálico para o nome científico
                                                  ),
                                                ),
                                                pw.TextSpan(
                                                  text: " superior a 50%",
                                                  style:
                                                      pw.TextStyle(fontSize: 6),
                                                ),
                                              ],
                                            ),
                                            textAlign: pw.TextAlign.center,
                                            softWrap: true,
                                          ),
                                        ],
                                      )
                                    ]),
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  child: pw.Center(
                                    child: pw.Column(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.center,
                                        children: [
                                          pw.Text(
                                            "Superior a 80 Microescleródios, g",
                                            style: pw.TextStyle(fontSize: 6),
                                            textAlign: pw.TextAlign.center,
                                            softWrap:
                                                true, // Permite quebras de linha
                                          ),
                                          pw.Text(
                                            "de solo",
                                            style: pw.TextStyle(
                                              fontSize: 6,
                                            ),
                                            textAlign: pw.TextAlign.center,

                                            softWrap:
                                                true, // Permite quebras de linha
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Linha 3 (Alto)
                        pw.Expanded(
                          child: pw.Row(
                            children: [
                              pw.Expanded(
                                child: pw.Container(
                                  decoration:
                                      pw.BoxDecoration(color: PdfColors.orange),
                                  child: pw.Center(
                                    child: pw.Text(
                                      "Alto",
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  child: pw.Center(
                                    child: pw.Row(children: [
                                      pw.SizedBox(width: 15),
                                      pw.Column(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.center,
                                        children: [
                                          pw.RichText(
                                            text: pw.TextSpan(
                                              children: [
                                                pw.TextSpan(
                                                  text: "Fusarium solani",
                                                  style: pw.TextStyle(
                                                    fontSize: 6,
                                                    fontStyle: pw.FontStyle
                                                        .italic, // Itálico para nome científico
                                                  ),
                                                ),
                                                pw.TextSpan(
                                                  text: " ou ",
                                                  style:
                                                      pw.TextStyle(fontSize: 6),
                                                ),
                                                pw.TextSpan(
                                                  text: "Fusarium oxysporum",
                                                  style: pw.TextStyle(
                                                    fontSize: 6,
                                                    fontStyle: pw.FontStyle
                                                        .italic, // Itálico para nome científico
                                                  ),
                                                ),
                                                pw.TextSpan(
                                                  text:
                                                      " superior a 3000 UFC/g solo",
                                                  style:
                                                      pw.TextStyle(fontSize: 6),
                                                ),
                                              ],
                                            ),
                                            textAlign: pw.TextAlign.center,
                                            softWrap: true,
                                          ),
                                          pw.Text(
                                            "E",
                                            style: pw.TextStyle(
                                              fontSize: 6,
                                              fontWeight: pw.FontWeight.bold,
                                            ),
                                            textAlign: pw.TextAlign.center,
                                            softWrap: true,
                                          ),
                                          pw.RichText(
                                            text: pw.TextSpan(
                                              children: [
                                                pw.TextSpan(
                                                  text: "Rhizoctonia solani",
                                                  style: pw.TextStyle(
                                                    fontSize: 6,
                                                    fontStyle: pw.FontStyle
                                                        .italic, // Itálico para nome científico
                                                  ),
                                                ),
                                                pw.TextSpan(
                                                  text: " inferior a 50%",
                                                  style:
                                                      pw.TextStyle(fontSize: 6),
                                                ),
                                              ],
                                            ),
                                            textAlign: pw.TextAlign.center,
                                            softWrap: true,
                                          ),
                                        ],
                                      )
                                    ]),
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  child: pw.Center(
                                    child: pw.Column(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.center,
                                        children: [
                                          pw.Text(
                                            "Entre 40 a 80 Microescleródios, g ",
                                            style: pw.TextStyle(fontSize: 6),
                                            textAlign: pw.TextAlign.center,
                                            softWrap:
                                                true, // Permite quebras de linha
                                          ),
                                          pw.Text(
                                            "de solo",
                                            style: pw.TextStyle(
                                              fontSize: 6,
                                            ),
                                            textAlign: pw.TextAlign.center,

                                            softWrap:
                                                true, // Permite quebras de linha
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Linha 4 (Moderado)
                        pw.Expanded(
                          child: pw.Row(
                            children: [
                              pw.Expanded(
                                child: pw.Container(
                                  decoration:
                                      pw.BoxDecoration(color: PdfColors.amber),
                                  child: pw.Center(
                                    child: pw.Text(
                                      "Moderado",
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  child: pw.Center(
                                    child: pw.Row(children: [
                                      pw.SizedBox(width: 15),
                                      pw.Column(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.center,
                                        children: [
                                          pw.RichText(
                                            text: pw.TextSpan(
                                              children: [
                                                pw.TextSpan(
                                                  text: "Fusarium solani",
                                                  style: pw.TextStyle(
                                                    fontSize: 6,
                                                    fontStyle: pw.FontStyle
                                                        .italic, // Itálico para nome científico
                                                  ),
                                                ),
                                                pw.TextSpan(
                                                  text: " ou ",
                                                  style:
                                                      pw.TextStyle(fontSize: 6),
                                                ),
                                                pw.TextSpan(
                                                  text: "Fusarium oxysporum",
                                                  style: pw.TextStyle(
                                                    fontSize: 6,
                                                    fontStyle: pw.FontStyle
                                                        .italic, // Itálico para nome científico
                                                  ),
                                                ),
                                                pw.TextSpan(
                                                  text:
                                                      " entre 1500 e 3000 UFC/g solo",
                                                  style:
                                                      pw.TextStyle(fontSize: 6),
                                                ),
                                              ],
                                            ),
                                            textAlign: pw.TextAlign.center,
                                            softWrap: true,
                                          ),
                                          pw.Text(
                                            "E",
                                            style: pw.TextStyle(
                                              fontSize: 6,
                                              fontWeight: pw.FontWeight.bold,
                                            ),
                                            textAlign: pw.TextAlign.center,
                                            softWrap: true,
                                          ),
                                          pw.RichText(
                                            text: pw.TextSpan(
                                              children: [
                                                pw.TextSpan(
                                                  text: "Rhizoctonia solani",
                                                  style: pw.TextStyle(
                                                    fontSize: 6,
                                                    fontStyle: pw.FontStyle
                                                        .italic, // Itálico para nome científico
                                                  ),
                                                ),
                                                pw.TextSpan(
                                                  text: " inferior a 50%",
                                                  style:
                                                      pw.TextStyle(fontSize: 6),
                                                ),
                                              ],
                                            ),
                                            textAlign: pw.TextAlign.center,
                                            softWrap: true,
                                          ),
                                        ],
                                      )
                                    ]),
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  child: pw.Center(
                                    child: pw.Column(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.center,
                                        children: [
                                          pw.Text(
                                            "Entre 20 e 40 Microescleródios, g",
                                            style: pw.TextStyle(fontSize: 6),
                                            textAlign: pw.TextAlign.center,
                                            softWrap:
                                                true, // Permite quebras de linha
                                          ),
                                          pw.Text(
                                            "de solo",
                                            style: pw.TextStyle(
                                              fontSize: 6,
                                            ),
                                            textAlign: pw.TextAlign.center,

                                            softWrap:
                                                true, // Permite quebras de linha
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Linha 5 (Baixo)
                        pw.Expanded(
                          child: pw.Row(
                            children: [
                              pw.Expanded(
                                child: pw.Container(
                                  decoration: pw.BoxDecoration(
                                      color: PdfColors.green100),
                                  child: pw.Center(
                                    child: pw.Text(
                                      "Baixo",
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  child: pw.Center(
                                    child: pw.Row(children: [
                                      pw.SizedBox(width: 15),
                                      pw.Column(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.center,
                                        children: [
                                          pw.RichText(
                                            text: pw.TextSpan(
                                              children: [
                                                pw.TextSpan(
                                                  text: "Fusarium solani",
                                                  style: pw.TextStyle(
                                                    fontSize: 6,
                                                    fontStyle: pw.FontStyle
                                                        .italic, // Itálico para nome científico
                                                  ),
                                                ),
                                                pw.TextSpan(
                                                  text: " ou ",
                                                  style:
                                                      pw.TextStyle(fontSize: 6),
                                                ),
                                                pw.TextSpan(
                                                  text: "Fusarium oxysporum",
                                                  style: pw.TextStyle(
                                                    fontSize: 6,
                                                    fontStyle: pw.FontStyle
                                                        .italic, // Itálico para nome científico
                                                  ),
                                                ),
                                                pw.TextSpan(
                                                  text:
                                                      " inferior a 1500 UFC/g solo",
                                                  style:
                                                      pw.TextStyle(fontSize: 6),
                                                ),
                                              ],
                                            ),
                                            textAlign: pw.TextAlign.center,
                                            softWrap: true,
                                          ),
                                          pw.Text(
                                            "E",
                                            style: pw.TextStyle(
                                              fontSize: 6,
                                              fontWeight: pw.FontWeight.bold,
                                            ),
                                            textAlign: pw.TextAlign.center,
                                            softWrap: true,
                                          ),
                                          pw.RichText(
                                            text: pw.TextSpan(
                                              children: [
                                                pw.TextSpan(
                                                  text: "Rhizoctonia solani",
                                                  style: pw.TextStyle(
                                                    fontSize: 6,
                                                    fontStyle: pw.FontStyle
                                                        .italic, // Itálico para nome científico
                                                  ),
                                                ),
                                                pw.TextSpan(
                                                  text: " inferior a 50%",
                                                  style:
                                                      pw.TextStyle(fontSize: 6),
                                                ),
                                              ],
                                            ),
                                            textAlign: pw.TextAlign.center,
                                            softWrap: true,
                                          ),
                                        ],
                                      )
                                    ]),
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  child: pw.Center(
                                    child: pw.Column(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.center,
                                        children: [
                                          pw.Text(
                                            "Inferior a 20 Microescleródios, g",
                                            style: pw.TextStyle(fontSize: 6),
                                            textAlign: pw.TextAlign.center,
                                            softWrap:
                                                true, // Permite quebras de linha
                                          ),
                                          pw.Text(
                                            "de solo",
                                            style: pw.TextStyle(
                                              fontSize: 6,
                                            ),
                                            textAlign: pw.TextAlign.center,

                                            softWrap:
                                                true, // Permite quebras de linha
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        pw.Divider(height: 2),
                        pw.SizedBox(height: 2),

                        // Referências
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "Base de dados: Geraldine (2021)",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.grey,
                                    fontSize: 8,
                                  ),
                                ),
                                pw.SizedBox(height: 3),
                                pw.Text(
                                  "Base referencial 1: Gesimaria Ribeiro Costa, et al. 2007.",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.grey,
                                    fontSize: 8,
                                  ),
                                ),
                                pw.SizedBox(height: 3),
                                pw.Text(
                                  "Base referencial 2: Souza, Eliane Divina de Toledo et al. 2009.",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.grey,
                                    fontSize: 8,
                                  ),
                                ),
                                pw.SizedBox(height: 3),
                                pw.Text(
                                  "Base referencial 3: Alemu Mengistu et al 2009.",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.grey,
                                    fontSize: 8,
                                  ),
                                ),
                                pw.SizedBox(height: 3),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(
                  height: 25,
                ),
                pw.Container(
                    width: double.infinity,
                    height: 25,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                        color: PdfColors.orange, // Cor da borda preta
                        width: 1, // Largura da borda
                      ),
                      color: PdfColors.orange, // Cor de fundo branca
                    ),
                    child: pw.Center(
                        child: pw.Text("ANEXOS",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 14,
                                color: PdfColors.white)))),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [...anexos]),
                pw.Row(children: [
                  pw.SizedBox(
                    width: 35,
                  ),
                ]),
                pw.SizedBox(height: 10),
                pw.SizedBox(
                  height: 15,
                ),
                pw.SizedBox(
                  height: 5,
                ),
                pw.SizedBox(
                  height: 5,
                ),
                pw.Center(
                  child: pw.Image(rubrica, width: 175, height: 175),
                ),
                pw.SizedBox(
                  height: 25,
                ),
                pw.Center(
                  child: pw.Text(
                      "Avenida Lazinho Pimenta N° 440 Qd.20 Setor Municipal de Pequenas Empresas- Rio Verde GO",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 10,
                        color: PdfColors.grey,
                      )),
                ),
                pw.SizedBox(
                  height: 5,
                ),
                pw.SizedBox(
                  height: 5,
                ),
                pw.Center(
                  child: pw.Text(
                      "64 99612-0249 / E-mail: laboratorio@agrobiontech.com",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 10,
                        color: PdfColors.grey,
                      )),
                ),
              ])
        ];

        // Create a Container to position the Row and the "blackboard"
      },
    ),
  );

  String path = "";
  Directory documentsDirectory = await getApplicationDocumentsDirectory();

  // Criar a pasta "rascunhos" se não existir
  String folderPath =
      '${documentsDirectory.path}/gerador de laudos/pdfs/microbiológico';
  await Directory(folderPath).create(recursive: true);

  bool salvou = true;

  try {
    path = '$folderPath/' + nomeArquivo + ".pdf";

    // Salvar o PDF
    final file = File(path);
    await file.writeAsBytes(await pdf.save());
  } catch (e) {
    salvou = false;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        'Erro ao salvar o PDF!',
        style: TextStyle(fontSize: 18),
      ),
      duration: Duration(seconds: 3),
    ));
  }

  // Fecha o diálogo de carregamento, garantindo que o `pop` sempre seja chamado.
  Navigator.of(context, rootNavigator: true).pop();

  if (salvou) {
    // Caminho para o arquivo PDF
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PdfViewer(path)),
    ).then((value) {
      if (value == 1) {
        Navigator.of(context).pop();
      } else if (value == 2) {
        Navigator.of(context).pop(1);
      }
    });
  }
}
