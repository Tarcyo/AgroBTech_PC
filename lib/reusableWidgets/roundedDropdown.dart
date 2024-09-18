import 'package:flutter/material.dart';

class RoundedDropdown extends StatelessWidget {
  final TextEditingController controller;
  final List<String> options;
  final String? selectedOption;
  final ValueChanged<String?> onChanged;

  const RoundedDropdown({
    Key? key,
    required this.controller,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 285, // Aumentando a largura
      height: 20, // Ajustando a altura
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(180), // Ajustando o raio
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // Alterando posição da sombra
          ),
        ],
      ),
      child: Center(
        child: DropdownButton<String>(
          value: selectedOption,
          onChanged: onChanged,
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: Colors.black), // Definindo a cor do texto como preto
              ),
            );
          }).toList(),
          underline: Container(), // Remove a linha por baixo do DropdownButton
          isExpanded: true, // Expande o DropdownButton para ocupar todo o espaço disponível
        ),
      ),
    );
  }
}