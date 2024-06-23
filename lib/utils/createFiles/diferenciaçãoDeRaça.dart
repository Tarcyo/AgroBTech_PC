import 'package:flutter/material.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:agro_bio_tech_pc/pages/createFileScreen/diferenciacaoDeRaca/tableOfResults.dart';

pw.Widget _buildTable(List<dynamic> list) {
  print(
      list); // Certifique-se de que os dados estão sendo recebidos corretamente

  final headers = [
    'ID lab',
    'ID cliente',
    'Pickett',
    'Peking',
    'PI88788',
    'PI90763',
    'Raça estimada',
  ];

  final List<Map<String, dynamic>> data = [];

  for (final item in list) {
    // Certifique-se de que o item tem todos os dados esperados
    if (item.length >= 7) {
      data.add({
        "ID lab": item[0],
        "ID cliente": item[1],
        "Pickett": item[2],
        "Peking": item[3],
        "PI88788": item[4],
        "PI90763": item[5],
        "Raça estimada": item[6],
      });
    } else {
      // Trate o caso em que o item não tem dados suficientes
      // ou revise o código para garantir que os dados sejam completos
      print("Item incompleto: $item");
    }
  }

  final tableHeaders = headers.map((header) {
    return pw.Container(
      alignment: pw.Alignment.center,
      child: pw.Text(
        header,
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      ),
      padding: const pw.EdgeInsets.all(5),
      decoration: const pw.BoxDecoration(color: PdfColors.grey300),
    );
  }).toList();

  final tableRows = data.map((rowData) {
    return pw.TableRow(
      children: headers.map((header) {
        return pw.Padding(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Text(
            '${rowData[header]}', // Acessa os dados pelo nome do header
          ),
        );
      }).toList(),
    );
  }).toList();

  return pw.Container(
    child: pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(children: tableHeaders),
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
  if (contratante.isEmpty) {
    contratante = "-";
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
      if (c.child is TableTextCell) {
        final cell = c.child as TableTextCell;
        cells.add(cell.controller.text);
        print("Resultado: " + cell.controller.text);
      } else if (c.child is OptionDropdownCell) {
        final cell = c.child as OptionDropdownCell;
        cells.add(cell.controller.selectedValue);
        print("Resultado: " + cell.controller.selectedValue);
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

  final pdf = pw.Document();

  pdf.addPage(
    index: 0,
    pw.MultiPage(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      maxPages: 27,
      pageTheme: pw.PageTheme(
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
          pw.Divider(
            color: PdfColors.black,
            thickness: 0.5,
          ),
          pw.SizedBox(
            height: 3,
          ),
          pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.RichText(
                text: pw.TextSpan(
                  children: [
                    pw.TextSpan(
                      text: "Laudo:  " + numeroLaudo + " ",
                      style: pw.TextStyle(color: PdfColors.black, fontSize: 11),
                    ),
                    pw.TextSpan(
                      text: tipoAnalise,
                      style: pw.TextStyle(
                          color: PdfColors.black,
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(
                height: 18,
              ),
              pw.RichText(
                text: pw.TextSpan(
                  children: [
                    pw.TextSpan(
                      text: "Contratante ",
                      style: pw.TextStyle(color: PdfColors.black, fontSize: 11),
                    ),
                    pw.TextSpan(
                      text: contratante,
                      style: pw.TextStyle(
                          color: PdfColors.black,
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(
                height: 3,
              ),
              pw.Text("Material analisado: " + material,
                  style: pw.TextStyle(color: PdfColors.black, fontSize: 11)),
              pw.SizedBox(
                height: 3,
              ),
              pw.Text("Proprietário: " + proprietario,
                  style: pw.TextStyle(color: PdfColors.black, fontSize: 11)),
              pw.SizedBox(
                height: 3,
              ),
              pw.Text("Fazenda:  " + fazenda,
                  style: pw.TextStyle(color: PdfColors.black, fontSize: 11)),
              pw.SizedBox(
                height: 3,
              ),
              pw.Text("Data de entrada no laboratório: " + dataEntrada,
                  style: pw.TextStyle(color: PdfColors.black, fontSize: 11)),
              pw.SizedBox(
                height: 3,
              ),
              pw.Text("Data do laudo " + dataEmissao,
                  style: pw.TextStyle(color: PdfColors.black, fontSize: 11)),
              pw.SizedBox(
                height: 3,
              ),
              pw.Text("Responsável pela entrega: " + responsavel,
                  style: pw.TextStyle(color: PdfColors.black, fontSize: 11)),
              pw.SizedBox(
                height: 10,
              ),
            ],
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
                  child: pw.Text("Reação sobre a diferenciadora ",
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 14,
                          color: PdfColors.white)))),
          pw.SizedBox(
            height: 6,
          ),
          _buildTable(dataResults),
          pw.SizedBox(
            width: 30,
          ),
          pw.SizedBox(
            height: 3,
          ),
          pw.SizedBox(
            height: 5,
          ),
          pw.SizedBox(height: 5),
          pw.SizedBox(
            height: 2,
          ),
          pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                    "*Caracterização de raças de Heterodera glycines em ensaios conduzidos em vasos de 8L, utilizando plantas diferenciadoras",
                    style: pw.TextStyle(
                      fontSize: 8,
                    )),
                pw.Text(
                    "conforme metodologia descrita por Golden et al. (1970) e Riggs e Schmitt (1988) ",
                    style: pw.TextStyle(
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
            height: 50,
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
