import 'package:flutter/material.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:agro_bio_tech_pc/pages/createFileScreen/controleDeQualidade/tableOfResults.dart';
import 'package:agro_bio_tech_pc/pages/createFileScreen/PdfviewScreen.dart';

Future<pw.Widget> _buildTable(List<dynamic> list) async {
  final headers = [
    'ID lab',
    'ID cliente',
    'Conídios/ml',
    'UFC/ml',
  ];
  final List<Map<String, dynamic>> data = [];
  for (final i in list) {
    data.add(
      {"id_lab": i[0], "id_cliente": i[1], "conidios_ml": i[2], "ufc_ml": i[3]},
    );
  }

  final tableHeaders = headers.map((header) {
    return pw.Container(
      alignment: pw.Alignment.center,
      child:
          pw.Text(header, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      padding: const pw.EdgeInsets.all(5),
      decoration: const pw.BoxDecoration(color: PdfColors.grey300),
    );
  }).toList();

  final tableRows = data.map((rowData) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Text(
            '${rowData["id_lab"]}',
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Text(
            '${rowData["id_cliente"]}',
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Text(
            '${rowData["conidios_ml"]}',
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Text(
            '${rowData["ufc_ml"]}',
          ),
        ),
      ],
    );
  }).toList();

  return pw.Container(
    child: pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          children: tableHeaders,
        ),
        ...tableRows,
      ],
    ),
  );
}

Future<void> createPDF(
    BuildContext context,
    String nomeArquivo,
    String tipoAnalise,
    String numeroLaudo,
    String contratante,
    String material,
    String dataEntrada,
    String cnpj,
    String fazenda,
    List<DataRow> resultados,
    List<TextEditingController> observacaoes,
    List<File> imagens,
    List<TextEditingController> descricoes) async {
  if(nomeArquivo.isEmpty){
    return;
  }
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
  if (cnpj.isEmpty) {
    cnpj = "-";
  }
  if (fazenda.isEmpty) {
    fazenda = "-";
  }

  final dataResults = [];

  for (final r in resultados) {
    final cells = [];
    for (final c in r.cells) {
      final cell = c.child as TableTextCell;
      // Adiciona tanto o texto do TextField quanto o valor selecionado do DropdownButton
      if (cell.isNumeric) {
        cells.add('${cell.controller.text} ${cell.controllerOfDopdown.text}');
        print("Valor: " + cell.controllerOfDopdown.text);
      } else {
        cells.add(cell.controller.text);
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
            pw.Text("Figura " + (i + 1).toString() + "." + descricoes[i].text,
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

  final tableOfResults = await _buildTable(dataResults);

  final fontData =
      await rootBundle.load("assets/fonts/Arial/Arial.ttf");
  final customFont = pw.Font.ttf(fontData);

  // Definindo o tema global com a fonte personalizada
  final theme = pw.ThemeData.withFont(
    base: customFont, // Define a fonte padrão para o texto
  );

  pdf.addPage(
    index: 0,
    pw.MultiPage(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      maxPages: 99,
      pageTheme: pw.PageTheme(
        theme: theme,
        clip: true,
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
                              fontSize: 10, fontWeight: pw.FontWeight.bold),
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
                              fontSize: 10, fontWeight: pw.FontWeight.bold),
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
                              fontSize: 10, fontWeight: pw.FontWeight.bold),
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
                              fontSize: 10, fontWeight: pw.FontWeight.bold),
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
                              fontSize: 10, fontWeight: pw.FontWeight.bold),
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
                          "CNPJ:",
                          style: pw.TextStyle(
                              fontSize: 10, fontWeight: pw.FontWeight.bold),
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
                              fontSize: 10, fontWeight: pw.FontWeight.bold),
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
                              fontSize: 10, fontWeight: pw.FontWeight.bold),
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
                        pw.Text(cnpj, style: const pw.TextStyle(fontSize: 10)),
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
          pw.SizedBox(height: 5),
          tableOfResults,
          pw.SizedBox(
            height: 2,
          ),
          pw.Row(children: [
            pw.SizedBox(
              width: 35,
            ),
            pw.Text(
                "NR: Não realizado. *Contaminação com bactérias e leveduras.",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 8,
                )),
          ]),
          pw.SizedBox(height: 10),
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
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
            pw.SizedBox(
              width: 70,
            ),
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [...observacoesWidgets])
          ]),
          pw.SizedBox(
            height: 15,
          ),
          pw.Center(
            child: pw.Text("ANEXOS:",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 14,
                )),
          ),
          pw.SizedBox(
            height: 5,
          ),
          ...anexos,
          pw.SizedBox(
            height: 5,
          ),
          pw.Center(
            child: pw.Image(rubrica, width: 175, height: 175),
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
            child:
                pw.Text("64 99612-0249 / E-mail: laboratorio@agrobiontech.com",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 10,
                      color: PdfColors.grey,
                    )),
          ),
        ];

        // Create a Container to position the Row and the "blackboard"
      },
    ),
  );
  String path = "";
  Directory documentsDirectory = await getApplicationDocumentsDirectory();

  // Criar a pasta "rascunhos" se não existir
  String folderPath =
      '${documentsDirectory.path}/gerador de laudos/pdfs/controle de qualidade';
  await Directory(folderPath).create(recursive: true);

  bool salvou = true;

  // Exibe o diálogo de carregamento

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
