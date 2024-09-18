import 'package:flutter/material.dart';
import 'package:midas/constants.dart';

class TokenItem extends StatefulWidget {
  final String token;
  final ValueChanged<String> onTokenRemoved;

  const TokenItem({
    Key? key,
    required this.token,
    required this.onTokenRemoved,
  }) : super(key: key);

  @override
  State<TokenItem> createState() => _TokenItemState();
}

class _TokenItemState extends State<TokenItem> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 80.0),
      child: SizedBox(
        height: 30.0,
        child: Container(
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(180),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.token,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 10,),
                InkWell(
                  onTap: () {
                    // Ao clicar no botão "X", chame a função de callback passando o token
                    widget.onTokenRemoved(widget.token);
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}