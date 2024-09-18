import 'package:flutter/material.dart';
import 'planilhaCard.dart';

class PlanilhaCardList extends StatelessWidget {
  final List<String> _nomeArquivos;
  final String _tipoArquivos;

  PlanilhaCardList(this._nomeArquivos, this._tipoArquivos);

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [];
    for (String string in _nomeArquivos) {
      cards.add(PlanilhaCard(string, _tipoArquivos));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [...cards],
    );
  }
}
