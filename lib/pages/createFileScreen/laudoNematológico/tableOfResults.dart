import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Necessário para usar os inputFormatters

class DataTableWidget extends StatefulWidget {
  final List<DataRow>? initialRows;

  DataTableWidget({Key? key, this.initialRows}) : super(key: key);

  @override
  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  late List<DataRow> rows;
  late ScrollController _horizontalScrollController;

  @override
  void initState() {
    super.initState();
    rows = widget.initialRows ?? [];
    if (rows.isEmpty) {
      addRow(); // Adiciona uma linha inicial caso não haja linhas iniciais
    }
    _horizontalScrollController = ScrollController();
  }

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Scrollbar(
            thickness: 12,
            controller: _horizontalScrollController,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _horizontalScrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DataTable(
                    horizontalMargin: 10,
                    columnSpacing: 10,
                    columns: [
                      DataColumn(
                        label: Column(
                          children: [
                            Text('Id.',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                            Text('laboratório',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                          ],
                        ),
                      ),
                      DataColumn(
                        label: Column(
                          children: [
                            Text('Id.',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                            Text('amostra',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                          ],
                        ),
                      ),
                      DataColumn(
                        label: Column(
                          children: [
                            Text('Material',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                            Text('Analisado',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                          ],
                        ),
                      ),
                      DataColumn(
                        label: Column(
                          children: [
                            Text('Meloidogyne',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                            Text('sp',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                          ],
                        ),
                      ),
                      DataColumn(
                        label: Column(
                          children: [
                            Text('Pratylenchus',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                            Text('sp',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                          ],
                        ),
                      ),
                      DataColumn(
                        label: Column(
                          children: [
                            Text('Pratylenchus',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                            Text('brachyurus',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                          ],
                        ),
                      ),
                      DataColumn(
                        label: Column(
                          children: [
                            Text('Pratylenchus',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                            Text('zeae',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                          ],
                        ),
                      ),
                      DataColumn(
                        label: Row(
                          children: [
                            Column(
                              children: [
                                Text('Heterodera',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white)),
                                Text('sp',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      DataColumn(
                        label: Column(
                          children: [
                            Text('Tubixaba',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                            Text('sp',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                          ],
                        ),
                      ),
                      DataColumn(
                        label: Column(
                          children: [
                            Text('Rotylechulus',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                            Text('reniformis',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                          ],
                        ),
                      ),
                      DataColumn(
                        label: Column(
                          children: [
                            Text('Helicotylenchus',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                            Text('dihystera',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                          ],
                        ),
                      ),
                      DataColumn(
                        label: Column(
                          children: [
                            Text('Cistos',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                            Text('viáveis',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                          ],
                        ),
                      ),
                      DataColumn(
                        label: Column(
                          children: [
                            Column(
                              children: [
                                Text('Cistos',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white)),
                                Text('inviáveis',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    rows: List.from(rows),
                  ),
                  SizedBox(
                    height: screenHeight * 0.015,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Centraliza os botões
                      children: [
                        SizedBox(width: 220), // Espaçamento entre os botões

                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              addRow();
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 70), // Espaçamento entre os botões
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              showDeleteConfirmationDialog();
                            },
                            icon: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addRow() {
    setState(() {
      rows.add(
        DataRow(cells: [
          DataCell(TableTextCell(TextEditingController(), [])),
          DataCell(TableTextCell(TextEditingController(), [])),
          DataCell(TableTextCell(TextEditingController(),
              [FilteringTextInputFormatter.digitsOnly])),
          DataCell(TableTextCell(TextEditingController(),
              [FilteringTextInputFormatter.digitsOnly])),
          DataCell(TableTextCell(TextEditingController(),
              [FilteringTextInputFormatter.digitsOnly])),
          DataCell(TableTextCell(TextEditingController(),
              [FilteringTextInputFormatter.digitsOnly])),
          DataCell(TableTextCell(TextEditingController(),
              [FilteringTextInputFormatter.digitsOnly])),
          DataCell(TableTextCell(TextEditingController(),
              [FilteringTextInputFormatter.digitsOnly])),
          DataCell(TableTextCell(TextEditingController(),
              [FilteringTextInputFormatter.digitsOnly])),
          DataCell(TableTextCell(TextEditingController(),
              [FilteringTextInputFormatter.digitsOnly])),
          DataCell(TableTextCell(TextEditingController(),
              [FilteringTextInputFormatter.digitsOnly])),
          DataCell(TableTextCell(TextEditingController(),
              [FilteringTextInputFormatter.digitsOnly])),
          DataCell(TableTextCell(TextEditingController(),
              [FilteringTextInputFormatter.digitsOnly])),
        ]),
      );
    });
  }

  void removeRow() {
    setState(() {
      if (rows.isNotEmpty) {
        rows.removeLast();
      }
    });
  }

  void showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(32.0), // Ajuste o valor conforme desejado
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

class TableTextCell extends StatelessWidget {
  final TextEditingController controller;
  final List<TextInputFormatter> formatter;

  TableTextCell(this.controller, this.formatter);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
      controller: controller,
      keyboardType: TextInputType.number, // Teclado numérico
      inputFormatters: [
        ...formatter, // Permite apenas números
      ],
    );
  }
}
