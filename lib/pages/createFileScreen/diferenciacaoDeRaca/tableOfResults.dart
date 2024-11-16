import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import necessário para TextInputFormatter

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
                columnSpacing: 10,
                columns: [
                  DataColumn(
                    label: Text('ID lab',
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('ID Cliente',
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('Pickett',
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('Peking',
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('PI88788',
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('PI90763',
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('Raça estimada',
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                ],
                rows: List.from(rows),
              ),
            ),
          ),
          SizedBox(
              height: screenHeight * 0.015),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
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
                width: 150,
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
          DataCell(TableTextCell(TextEditingController())),
          DataCell(TableTextCell(TextEditingController())),
          DataCell(OptionDropdownCell(DropdownController('-'))),
          DataCell(OptionDropdownCell(DropdownController('-'))),
          DataCell(OptionDropdownCell(DropdownController('-'))),
          DataCell(OptionDropdownCell(DropdownController('-'))),
          DataCell(TableTextCell(TextEditingController(), isNumeric: true)), // Aqui modificamos para aceitar apenas números
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
            borderRadius:
                BorderRadius.circular(32.0),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Atenção",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
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

class TableTextCell extends StatelessWidget {
  final TextEditingController controller;
  final bool isNumeric; // Adicionando o parâmetro isNumeric

  TableTextCell(this.controller, {this.isNumeric = false}); // Adicionando um valor padrão para isNumeric

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text, // Ajusta o tipo de teclado
      inputFormatters: isNumeric
          ? [FilteringTextInputFormatter.digitsOnly] // Adiciona formatação para permitir apenas números
          : [],
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
      controller: controller,
    );
  }
}

class DropdownController {
  String _selectedValue;

  DropdownController(this._selectedValue);

  String get selectedValue => _selectedValue;

  set selectedValue(String value) {
    _selectedValue = value;
  }
}

class OptionDropdownCell extends StatefulWidget {
  final DropdownController controller;

  OptionDropdownCell(this.controller);

  @override
  _OptionDropdownCellState createState() => _OptionDropdownCellState();
}

class _OptionDropdownCellState extends State<OptionDropdownCell> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.controller.selectedValue,
      icon: Icon(Icons.arrow_downward, color: Colors.white),
      iconSize: 16,
      elevation: 16,
      style: TextStyle(color: Colors.white, fontSize: 25),
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      dropdownColor: Colors.black,
      onChanged: (String? newValue) {
        setState(() {
          widget.controller.selectedValue = newValue!;
        });
      },
      items: <String>['+', '-'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.white, fontSize: 20)),
        );
      }).toList(),
    );
  }
}