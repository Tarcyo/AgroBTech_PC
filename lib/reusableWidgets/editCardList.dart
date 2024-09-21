import 'package:flutter/material.dart';
import 'editCard.dart';

class EditCardList extends StatelessWidget {
  final List<String> _nomeArquivos;
  final String tipoArquivos;

  EditCardList(this._nomeArquivos, this.tipoArquivos);

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [];
    for (String string in _nomeArquivos) {
      cards.add(EditCard(string, tipoArquivos));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [...cards],
    );
  }
}
