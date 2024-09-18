import 'package:flutter/material.dart';

class TableOfInterpretation extends StatefulWidget {
  final List<TextEditingController> _criteriaByMacrophominaControllers;
  final List<TextEditingController> _criteriaByFactorControllers;

  TableOfInterpretation(
    this._criteriaByMacrophominaControllers,
    this._criteriaByFactorControllers,
  );

  @override
  _TableOfInterpretationState createState() => _TableOfInterpretationState();
}
class _TableOfInterpretationState extends State<TableOfInterpretation> {
  final List<String> riskLevels = ["Muito alto", "Alto", "Moderado", "Baixo"];
   

  final ScrollController _horizontalScrollController = ScrollController();

  @override
  void dispose() {
    _horizontalScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    List<TableInterpretationCell> criteriaByFactorCells = List.generate(
    4,
    (index) => TableInterpretationCell(
      controller: widget._criteriaByFactorControllers[index],
    ),
  );
  List<TableInterpretationCell> criteriaByMacrophominaCells =
      List.generate(
    4,
    (index) => TableInterpretationCell(
      controller: widget._criteriaByMacrophominaControllers[index],
    ),
  );

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Scrollbar(
            controller: _horizontalScrollController,
            thumbVisibility: true,
            thickness: 8.0,
            radius: Radius.circular(10.0),
            trackVisibility: true,
            interactive: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _horizontalScrollController,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  horizontalMargin: 10,
                  columns: [
                    DataColumn(
                      label: Text(
                        'Risco',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Critério por fator',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Critério por Macrophomina',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ],
                  rows: List.generate(riskLevels.length, (index) {
                    return DataRow(cells: [
                      DataCell(
                        Text(
                          riskLevels[index],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataCell(
                        criteriaByFactorCells[index],
                      ),
                      DataCell(
                        criteriaByMacrophominaCells[index],
                      ),
                    ]);
                  }),
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.030),
        ],
      ),
    );
  }
}

class TableInterpretationCell extends StatelessWidget {
  final TextEditingController controller;

  TableInterpretationCell({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      controller: controller,
    );
  }
}
