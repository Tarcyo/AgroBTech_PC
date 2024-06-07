import 'package:flutter/material.dart';
import 'pdfCard.dart';

class PdfCardList extends StatelessWidget {
  final List<String> _nomeArquivos;

  PdfCardList(this._nomeArquivos);

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [];
    for (String string in _nomeArquivos) {
      cards.add(PdfCard(text:string));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [...cards],
    );
  }
}
