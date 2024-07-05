import 'package:flutter/material.dart';
import 'pdfCard.dart';

class PdfCardList extends StatelessWidget {
  final List<String> _nomeArquivos;
  final String _tipoArquivos;

  PdfCardList(this._nomeArquivos, this._tipoArquivos);

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [];
    for (String string in _nomeArquivos) {
      cards.add(PdfCard(string, _tipoArquivos));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [...cards],
    );
  }
}
