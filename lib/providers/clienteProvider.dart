import 'package:flutter/material.dart';
import 'package:midas/model/clienteModel.dart';
class ClienteProvider with ChangeNotifier {
  Cliente? _cliente;  // Inicialmente o cliente é nulo

  // Getter para acessar o cliente
  Cliente? get cliente => _cliente;

  // Setter para atualizar os dados do cliente e notificar os listeners
  void setCliente(Cliente novoCliente) {
    _cliente = novoCliente;
    notifyListeners();
  }

  // Método para limpar os dados do cliente
  void clearCliente() {
    _cliente = null;
    notifyListeners();
  }
}