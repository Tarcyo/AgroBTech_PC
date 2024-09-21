import 'package:flutter/material.dart';
import 'tabBarController.dart';
import 'pages/PdfsScreen/PdfsScreen.dart';
import 'pages/DraftScreen/DraftScreen.dart';
import 'pages/SpreadsheetScreen/SpreadsheetScreen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarController(
      items: [
        PersistentTabItem(
          title: 'Meus Laudos',
          tab: const PdfScreenTab(),
          icon: Icons.picture_as_pdf,
        ),
        PersistentTabItem(
          title: 'Rascunhos',
          tab: const DraftScreenTab(),
          icon: Icons.edit_document,
        ),
        PersistentTabItem(
          title: 'Planilhas',
          tab: const SpreadsheetScreenTab(),
          icon: Icons.grid_on,
        )
      ],
    );
  }
}

class PdfScreenTab extends StatefulWidget {
  const PdfScreenTab({Key? key}) : super(key: key);

  @override
  _PdfScreenTabState createState() => _PdfScreenTabState();
}

class _PdfScreenTabState extends State<PdfScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PdfsScreen();
  }

  @override
  bool get wantKeepAlive => true;
}

class DraftScreenTab extends StatefulWidget {
  const DraftScreenTab({Key? key}) : super(key: key);

  @override
  _DraftScreenTabState createState() => _DraftScreenTabState();
}

class _DraftScreenTabState extends State<DraftScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DraftScreen();
  }

  @override
  bool get wantKeepAlive => true;
}

class SpreadsheetScreenTab extends StatefulWidget {
  const SpreadsheetScreenTab({Key? key}) : super(key: key);

  @override
  _SpreadsheetScreenTabState createState() => _SpreadsheetScreenTabState();
}

class _SpreadsheetScreenTabState extends State<SpreadsheetScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SpreadsheetScreen();
  }

  @override
  bool get wantKeepAlive => true;
}
