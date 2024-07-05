import 'package:flutter/material.dart';
import 'package:agro_bio_tech_pc/constants.dart';
import 'package:agro_bio_tech_pc/reusableWidgets/pdfCardList.dart';
import 'package:provider/provider.dart';
import 'package:agro_bio_tech_pc/providers/fileNameProvider.dart';
import '../createFileScreen/selectTypeScreen.dart';

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
                  if (provider.controleDeQualidadePdfs.isEmpty == false)
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
                  if (provider.sanidadePdfs.isEmpty == false)
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
                  if (provider.nematologicoPdfs.isEmpty == false)
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
                  if (provider.microbiologicoPdfs.isEmpty == false)
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
                  if (provider.diagnosePdfs.isEmpty == false)
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
                  if (provider.diferenciacaoDeRacaPdfs.isEmpty == false)
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
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
                width: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Criar novo',
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 25.0,
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      IconButton(
                        onPressed: () {
                          // Navegue para a RegisterScreen quando o botão for pressionado
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 600),
                              transitionsBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                  Widget child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return SelectTypeScreen();
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: mainColor,
                          size: 33,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: Text(
                  "Meus Laudos:",
                  style: TextStyle(color: mainColor, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
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
                              SizedBox(
                                width: 5,
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              rascunhos,
            ],
          ),
        ),
      ),
    );
  }
}
