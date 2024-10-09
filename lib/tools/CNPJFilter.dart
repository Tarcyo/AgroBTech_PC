import 'package:flutter/services.dart';

class CnpjInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove caracteres não numéricos
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Limita o número de dígitos a 14
    if (digitsOnly.length > 14) {
      digitsOnly = digitsOnly.substring(0, 14);
    }

    // Aplica a máscara de CNPJ
    String formatted = '';
    
    if (digitsOnly.isNotEmpty) {
      formatted += digitsOnly.substring(0, digitsOnly.length >= 2 ? 2 : digitsOnly.length); // XX
    }
    if (digitsOnly.length > 2) {
      formatted += '.' + digitsOnly.substring(2, digitsOnly.length >= 5 ? 5 : digitsOnly.length); // XX.XXX
    }
    if (digitsOnly.length > 5) {
      formatted += '.' + digitsOnly.substring(5, digitsOnly.length >= 8 ? 8 : digitsOnly.length); // XX.XXX.XXX
    }
    if (digitsOnly.length > 8) {
      formatted += '/' + digitsOnly.substring(8, digitsOnly.length >= 12 ? 12 : digitsOnly.length); // XX.XXX.XXX/0001
    }
    if (digitsOnly.length > 12) {
      formatted += '-' + digitsOnly.substring(12, digitsOnly.length); // XX.XXX.XXX/0001-XX
    }

    // Retorna o valor formatado
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}