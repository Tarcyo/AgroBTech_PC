import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Necessário para usar FilteringTextInputFormatter

class DataTableWidget extends StatelessWidget {
  final List<String> fungusNames = [
    "Cercospora kikuchii",
    "Colletotrichum truncatum",
    "Fusarium spp",
    "Macrophomina phaseolina",
    "Phomopsis sp",
    "Rhizoctonia solani",
    "Sclerotinia sclerotiorum",
    "Sclerotium rolfsii",
    "Aspergillus spp",
    "Penicillium sp",
    "Alternaria spp",
    "Cladosporium spp",
    "Rhizopus spp.",
    "Trichoderma spp",
    "Bactérias",
    "Outros"
  ];

  final List<TextEditingController> controllers;

  DataTableWidget({required this.controllers});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                'Nome',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            DataColumn(
              label: Text(
                '%',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
          rows: List.generate(fungusNames.length, (index) {
            return DataRow(
              cells: [
                DataCell(
                  Text(
                    fungusNames[index],
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                DataCell(
                  TextField(
                    controller: controllers[index],
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // Filtro para aceitar apenas números
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
