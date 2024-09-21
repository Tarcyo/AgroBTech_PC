import 'package:flutter/material.dart';
import 'package:midas/constants.dart';

class URLItem extends StatefulWidget {
  final String token;
  final ValueChanged<String> onTokenRemoved;

  const URLItem({
    Key? key,
    required this.token,
    required this.onTokenRemoved,
  }) : super(key: key);

  @override
  State<URLItem> createState() => _URLItemState();
}

class _URLItemState extends State<URLItem> {
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
                InkWell(
                  onTap: () {
                    widget.onTokenRemoved(widget.token);
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  widget.token,
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
