import 'package:flutter/material.dart';
import 'package:agro_bio_tech_pc/constants.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback onSearchPressed; // Ação para o botão de pesquisa
  final VoidCallback onClearPressed; // Ação para o botão de limpar

  const SearchBarWidget({
    Key? key,
    required this.controller,
    required this.onSearchPressed, // Requer a função ao pressionar o botão de pesquisa
    required this.onClearPressed, // Requer a função ao pressionar o botão de limpar
    this.hintText = "Pesquisar...",
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.all(15),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: mainColor), // Borda verde
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: mainColor, width: 0.5), // Borda verde mais grossa ao focar
          ),
          suffixIcon: Container(
            width: 100, // Largura fixa para alinhar os ícones
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end, // Alinha os ícones à direita
              mainAxisSize: MainAxisSize.min, // Minimiza o espaço ocupado
              children: [
                IconButton(
                  icon: Icon(Icons.restart_alt_outlined, color: mainColor), // Ícone para limpar
                  onPressed: onClearPressed,
                ),
                IconButton(
                  icon: Icon(Icons.search, color: mainColor), // Ícone de pesquisa
                  onPressed: onSearchPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}