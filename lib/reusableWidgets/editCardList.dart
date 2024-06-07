import 'package:flutter/material.dart';
import 'editCard.dart';

class EditCardList extends StatelessWidget {
  final List<String> _nomeArquivos;

  EditCardList(this._nomeArquivos);

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [];
    for (String string in _nomeArquivos) {
      cards.add(EditCard(text: string));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [...cards],
    );
  }
}
