import 'package:flutter/material.dart';

class FileNameProvider extends ChangeNotifier {
  FileNameProvider(this._nomesRascunhos, this._nomesPdfs);
  List<String> _nomesRascunhos = [];
  List<String> _nomesPdfs = [];

  List<String> get nomesRascunhos => _nomesRascunhos;
  List<String> get nomesPdfs => _nomesPdfs;

  void atualizaRascunhos(List<String> rascunhos) {
    _nomesRascunhos = rascunhos;
    notifyListeners(); // Notifica os consumidores sobre a mudança no estado
  }

  void atualizaPdfs(List<String> pdfs) {
    _nomesPdfs = pdfs;
    notifyListeners(); // Notifica os consumidores sobre a mudança no estado
  }

  void adicionaRascunho(String rascunho) {
    if (_nomesRascunhos.contains(rascunho) == false &&
        rascunho.isEmpty == false) {
      _nomesRascunhos.add(rascunho);
    }
    notifyListeners(); // Notifica os consumidores sobre a mudança no estado
  }

  void adicionaPdf(String pdf) {
    if (_nomesPdfs.contains(pdf) == false && pdf.isEmpty == false) {
      _nomesPdfs.add(pdf);
    }
    notifyListeners(); // Notifica os consumidores sobre a mudança no estado
  }

  void removeRascunho(String rascunho) {
    for (int i = 0; i < _nomesRascunhos.length; i++) {
      if (_nomesRascunhos[i] == rascunho) {
        _nomesRascunhos.removeAt(i);
      }
    }
    notifyListeners();
  }

  void removePdf(String pdf) {
    for (int i = 0; i < _nomesPdfs.length; i++) {
      if (_nomesPdfs[i] == pdf) {
        _nomesPdfs.removeAt(i);
      }
    }
    notifyListeners();
  }
}
