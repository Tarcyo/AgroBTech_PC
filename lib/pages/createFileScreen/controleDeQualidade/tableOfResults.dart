import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importar para TextInputFormatter

class DataTableWidget extends StatefulWidget {
  final List<DataRow>? initialRows;

  DataTableWidget({Key? key, this.initialRows}) : super(key: key);

  @override
  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  late List<DataRow> rows;

  @override
  void initState() {
    super.initState();
    rows = widget.initialRows ?? [];
    if (rows.isEmpty) {
      addRow();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                horizontalMargin: 10,
                columns: [
                  DataColumn(
                      label: Text('ID lab',
                          style: TextStyle(fontSize: 18, color: Colors.white))),
                  DataColumn(
                      label: Text('ID cliente',
                          style: TextStyle(fontSize: 18, color: Colors.white))),
                  DataColumn(
                      label: Text('Conídios/ml',
                          style: TextStyle(fontSize: 18, color: Colors.white))),
                  DataColumn(
                      label: Text('UFC/ml',
                          style: TextStyle(fontSize: 18, color: Colors.white))),
                ],
                rows: List.from(rows),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.030),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue, // Botão de adição em azul
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      addRow();
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    size: screenHeight * 0.02,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 300,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: IconButton(
                  onPressed: () {
                    removeRow();
                  },
                  icon: Icon(
                    Icons.remove,
                    size: screenHeight * 0.02,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void addRow() {
    setState(() {
      rows.add(
        DataRow(cells: [
          DataCell(TableTextCell(TextEditingController(),
              TextEditingController(text: '\×10⁰'))),
          DataCell(TableTextCell(TextEditingController(),
              TextEditingController(text: '\×10⁰'))),
          DataCell(TableTextCell(TextEditingController(),
              TextEditingController(text: '\×10⁰'),
              isNumeric: true)), // Campo numérico com dropdown
          DataCell(TableTextCell(TextEditingController(),
              TextEditingController(text: '\×10⁰'),
              isNumeric: true)), // Campo numérico com dropdown
        ]),
      );
    });
  }

  void removeRow() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Atenção",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ],
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Deseja remover a última linha?",
                style: TextStyle(color: Colors.grey[800], fontSize: 16),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(180.0),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (rows.isNotEmpty) {
                        rows.removeLast();
                      }
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Sim",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(180.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Não",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class TableTextCell extends StatefulWidget {
  final TextEditingController _controller;
  final bool isNumeric;
  final TextEditingController _controllerOfDopdown;

  TextEditingController get controllerOfDopdown => _controllerOfDopdown;

  TableTextCell(
    this._controller,
    this._controllerOfDopdown, {
    this.isNumeric = false,
  });

  TextEditingController get controller => _controller;

  @override
  _TableTextCellState createState() => _TableTextCellState();
}

class _TableTextCellState extends State<TableTextCell> {
  final List<String> dropdownValues = [
    '\×10⁰',
    '\×10¹',
    '\×10²',
    '\×10³',
    '\×10⁴',
    '\×10⁵',
    '\×10⁶',
    '\×10⁷',
    '\×10⁸',
    '\×10⁹',
    '\×10¹⁰',
    '\×10¹¹',
    '\×10¹²',
    '\×10¹³',
    '\×10¹⁴',
    '\×10¹⁵'
  ];

  String get selectedDropdownValue => widget._controllerOfDopdown.text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1, // Ajuste o valor do flex aqui
          child: Container(
            width: 50,
            child: TextField(
              style: TextStyle(color: Colors.white, fontSize: 14),
              controller: widget._controller,
              keyboardType: widget.isNumeric
                  ? TextInputType.numberWithOptions(decimal: true)
                  : TextInputType.text,
              inputFormatters: widget.isNumeric
                  ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))]
                  : [],
            ),
          ),
        ),
        if (widget.isNumeric) ...[
          SizedBox(width: 8),
          DropdownButton<String>(
            value: widget._controllerOfDopdown.text,
            onChanged: (String? newValue) {
              setState(() {
                widget._controllerOfDopdown.text = newValue!;
              });
            },
            items: dropdownValues.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              );
            }).toList(),
            dropdownColor: Colors.black,
            underline: SizedBox(),
          ),
        ],
      ],
    );
  }
}
