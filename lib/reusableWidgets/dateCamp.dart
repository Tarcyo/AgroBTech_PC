import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatar a data
import 'package:agro_bio_tech_pc/constants.dart'; // Certifique-se de que essa linha é relevante

class RoundedDatePickerField extends StatefulWidget {
  final TextEditingController _controller;

  RoundedDatePickerField(this._controller, {Key? key}) : super(key: key);

  @override
  _RoundedDatePickerFieldState createState() => _RoundedDatePickerFieldState();
}

class _RoundedDatePickerFieldState extends State<RoundedDatePickerField> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2150),
      locale: const Locale("pt", "BR"), // Português (Brasil)
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: mainColor, // Cor do texto dos ícones no topo
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      setState(() {
        widget._controller.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Indica que o widget é clicável
      child: Container(
        width: 500,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () => _selectDate(context), // Torna todo o campo clicável
          child: AbsorbPointer(
            // Absorve os eventos do TextField, impedindo interação direta
            child: TextField(
              controller: widget._controller,
              readOnly: true, // Impede a digitação direta
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Selecione uma data',
                suffixIcon: Icon(Icons.calendar_today, color: mainColor),
              ),
              style: TextStyle(fontSize: 14, color: Colors.grey[900]),
            ),
          ),
        ),
      ),
    );
  }
}
