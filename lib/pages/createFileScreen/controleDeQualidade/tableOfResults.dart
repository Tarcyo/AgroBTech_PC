import 'package:flutter/material.dart';

class DataTableWidget extends StatefulWidget {
  final List<DataRow>?
      initialRows; // Alterando a lista de linhas para ser opcional

  DataTableWidget({Key? key, this.initialRows}) : super(key: key);

  @override
  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  late List<DataRow> rows;

  @override
  void initState() {
    super.initState();
    // Inicializando a lista de linhas com a lista recebida no construtor ou uma lista vazia se não for fornecida
    rows = widget.initialRows ?? [];
    if (rows.isEmpty) {
      addRow(); // Adicionando uma linha inicial se a lista estiver vazia
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
                  color: Colors.green,
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
          DataCell(TableTextCell(TextEditingController())),
          DataCell(TableTextCell(TextEditingController())),
          DataCell(TableTextCell(TextEditingController())),
          DataCell(TableTextCell(TextEditingController())),
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
                "Deseja remover a ultima linha?",
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

                    // Implementar aqui a lógica para sair
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
                    // Fechar o diálogo sem sair
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
  final TextEditingController _controller;

  TextEditingController get controller => _controller;

  TableTextCell(
    this._controller,
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
          color: Colors.white,
          fontSize: 14), // Definindo a cor do texto como branco
      controller: _controller,
    );
  }
}
