import 'package:flutter/material.dart';
import 'UrlItem.dart';

class UrlList extends StatefulWidget {
  final List<String> strings;
  final ValueChanged<String> onTokenRemoved;

  const UrlList({
    Key? key,
    required this.strings,
    required this.onTokenRemoved,
  }) : super(key: key);

  @override
  State<UrlList> createState() => _UrlListState();
}

class _UrlListState extends State<UrlList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> tokens = [];
    double tamanhoBarra = 250;

    for (int i = 0; i < widget.strings.length; i++) {
      tokens.add(Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              URLItem(
                token: widget.strings[i],
                onTokenRemoved: (token) {
                  widget.onTokenRemoved(token);
                  setState(() {
                    widget.strings.remove("token");
                  });
                },
              ),
            ],
          ),
        ],
      ));
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
