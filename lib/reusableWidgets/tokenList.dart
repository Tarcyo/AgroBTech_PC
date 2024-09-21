import 'package:flutter/material.dart';
import 'tokenItem.dart';

class TokenList extends StatefulWidget {
  final List<String> strings;
  final ValueChanged<String> onTokenRemoved;

  const TokenList({
    Key? key,
    required this.strings,
    required this.onTokenRemoved,
  }) : super(key: key);

  @override
  State<TokenList> createState() => _TokenListState();
}

class _TokenListState extends State<TokenList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> tokens = [];
    double tamanhoBarra = 25;
    if (widget.strings.length > 0) {
      tamanhoBarra = 50;
    }
    if (widget.strings.length > 3) {
      tamanhoBarra = 100;
    }
    if (widget.strings.length > 6) {
      tamanhoBarra = 150;
    }

    int cont = 0;
    List<Widget> linha = [];
    for (int i = 0; i < widget.strings.length; i++) {
      linha.add(
        TokenItem(
          token: widget.strings[i],
          onTokenRemoved: (token) {
            widget.onTokenRemoved(token);
            setState(() {
              widget.strings.remove("token");
            });
          },
        ),
      );
      linha.add(const SizedBox(
        width: 15,
      ));
      if (cont == 2 || i == widget.strings.length - 1) {
        tokens.add(Row(
          children: [...linha],
        ));
        tokens.add(SizedBox(
          height: 15,
        ));
        linha = [];
        cont = 0;
      } else {
        cont++;
      }
    }

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        height: tamanhoBarra,
        width: 410, // Altura fixa do contêiner branco
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [...tokens],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
