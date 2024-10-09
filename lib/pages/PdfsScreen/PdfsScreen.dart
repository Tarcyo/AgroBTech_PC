import 'package:flutter/material.dart';
import 'package:agro_bio_tech_pc/constants.dart';
import 'package:agro_bio_tech_pc/reusableWidgets/pdfCardList.dart';
import 'package:provider/provider.dart';
import 'package:agro_bio_tech_pc/providers/fileNameProvider.dart';

class PdfsScreen extends StatefulWidget {
  @override
  State<PdfsScreen> createState() => _PdfsScreenState();
}

ScrollController sc = ScrollController();

class _PdfsScreenState extends State<PdfsScreen> {
  String _index = "Controle de qualidade";

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
              Consumer<FileNameProvider>(
                builder: (context, provider, child) {
                  if (provider.controleDeQualidadePdfs.isNotEmpty)
                    return PdfCardList(
                        provider.controleDeQualidadePdfs, _index);
                  else
                    return Center(
                        child: Text(
                      "Nenhum Pdf encontrado!",
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
              Consumer<FileNameProvider>(
                builder: (context, provider, child) {
                  if (provider.sanidadePdfs.isNotEmpty)
                    return PdfCardList(provider.sanidadePdfs, _index);
                  else
                    return Center(
                        child: Text(
                      "Nenhum Pdf encontrado!",
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
              Consumer<FileNameProvider>(
                builder: (context, provider, child) {
                  if (provider.nematologicoPdfs.isNotEmpty)
                    return PdfCardList(provider.nematologicoPdfs, _index);
                  else
                    return Center(
                        child: Text(
                      "Nenhum Pdf encontrado!",
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
              Consumer<FileNameProvider>(
                builder: (context, provider, child) {
                  if (provider.microbiologicoPdfs.isNotEmpty)
                    return PdfCardList(provider.microbiologicoPdfs, _index);
                  else
                    return Center(
                        child: Text(
                      "Nenhum Pdf encontrado!",
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
              Consumer<FileNameProvider>(
                builder: (context, provider, child) {
                  if (provider.diagnosePdfs.isNotEmpty)
                    return PdfCardList(provider.diagnosePdfs, _index);
                  else
                    return Center(
                        child: Text(
                      "Nenhum Pdf encontrado!",
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
              Consumer<FileNameProvider>(
                builder: (context, provider, child) {
                  if (provider.diferenciacaoDeRacaPdfs.isNotEmpty)
                    return PdfCardList(
                        provider.diferenciacaoDeRacaPdfs, _index);
                  else
                    return Center(
                        child: Text(
                      "Nenhum Pdf encontrado!",
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
              child: Center(
                child: Text(
                  "Meus Laudos",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ScrollbarTheme(
                data: ScrollbarThemeData(
                  thumbColor: MaterialStateProperty.all<Color>(mainColor),
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
                                backgroundColor:
                                    _index == "Laudo Nematológico"
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
                                backgroundColor:
                                    _index == "Raça de Nematóides"
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
