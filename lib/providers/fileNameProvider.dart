import 'package:flutter/material.dart';

class FileNameProvider extends ChangeNotifier {
  FileNameProvider(
    this._controleDeQualidadeRasunhos,
    this._controleDeQualidadePdfs,
    this._diagnoseRasunhos,
    this._diagnosePdfs,
    this._diferenciacaoDeRacaRascunhos,
    this._diferenciacaoDeRacaPdfs,
    this._microbiologicoRascunhos,
    this._microbiologicoPdfs,
    this._nematologicoRascunhos,
    this._nematologicoPdfs,
    this._sanidadePdfs,
    this._sanidadeRascunhos,
  );

  List<String> _controleDeQualidadeRasunhos;
  List<String> _controleDeQualidadePdfs;
  List<String> _diagnoseRasunhos;
  List<String> _diagnosePdfs;
  List<String> _diferenciacaoDeRacaRascunhos;
  List<String> _diferenciacaoDeRacaPdfs;
  List<String> _microbiologicoRascunhos;
  List<String> _microbiologicoPdfs;
  List<String> _nematologicoRascunhos;
  List<String> _nematologicoPdfs;
  List<String> _sanidadePdfs;
  List<String> _sanidadeRascunhos;

  // Getters for all the variables
  List<String> get controleDeQualidadeRascunhos => _controleDeQualidadeRasunhos;
  List<String> get controleDeQualidadePdfs => _controleDeQualidadePdfs;
  List<String> get diagnoseRascunhos => _diagnoseRasunhos;
  List<String> get diagnosePdfs => _diagnosePdfs;
  List<String> get diferenciacaoDeRacaRascunhos =>
      _diferenciacaoDeRacaRascunhos;
  List<String> get diferenciacaoDeRacaPdfs => _diferenciacaoDeRacaPdfs;
  List<String> get microbiologicoRascunhos => _microbiologicoRascunhos;
  List<String> get microbiologicoPdfs => _microbiologicoPdfs;
  List<String> get nematologicoRascunhos => _nematologicoRascunhos;
  List<String> get nematologicoPdfs => _nematologicoPdfs;
  List<String> get sanidadeRascunhos => _sanidadeRascunhos;
  List<String> get sanidadePdfs => _sanidadePdfs;

  void atualizaControleDeQualidadeRascunhos(List<String> rascunhos) {
    _controleDeQualidadeRasunhos = rascunhos;
    notifyListeners();
  }

  void atualizaControleDeQualidadePdfs(List<String> pdfs) {
    _controleDeQualidadePdfs = pdfs;
    notifyListeners();
  }

  void adicionaControleDeQualidadeRascunho(String rascunho) {
    if (_controleDeQualidadeRasunhos.contains(rascunho) == false &&
        rascunho.isEmpty == false) {
      _controleDeQualidadeRasunhos.add(rascunho);
    }
    notifyListeners();
  }

  void adicionaControleDeQualidadePdf(String pdf) {
    if (_controleDeQualidadePdfs.contains(pdf) == false &&
        pdf.isEmpty == false) {
      _controleDeQualidadePdfs.add(pdf);
    }
    notifyListeners();
  }

  void removeControleDeQualidadeRascunho(String rascunho) {
    for (int i = 0; i < _controleDeQualidadeRasunhos.length; i++) {
      if (_controleDeQualidadeRasunhos[i] == rascunho) {
        _controleDeQualidadeRasunhos.removeAt(i);
      }
    }
    notifyListeners();
  }

  void removeControleDeQualidadePdf(String pdf) {
    for (int i = 0; i < _controleDeQualidadePdfs.length; i++) {
      if (_controleDeQualidadePdfs[i] == pdf) {
        _controleDeQualidadePdfs.removeAt(i);
      }
    }
    notifyListeners();
  }

  void atualizaDiagnoseRascunhos(List<String> rascunhos) {
    _diagnoseRasunhos = rascunhos;
    notifyListeners();
  }

  void atualizaDiagnosePdfs(List<String> pdfs) {
    _diagnosePdfs = pdfs;
    notifyListeners();
  }

  void adicionaDiagnoseRascunho(String rascunho) {
    if (_diagnoseRasunhos.contains(rascunho) == false &&
        rascunho.isEmpty == false) {
      _diagnoseRasunhos.add(rascunho);
    }
    notifyListeners();
  }

  void adicionaDiagnosePdf(String pdf) {
    if (_diagnosePdfs.contains(pdf) == false && pdf.isEmpty == false) {
      _diagnosePdfs.add(pdf);
    }
    notifyListeners();
  }

  void removeDiagnoseRascunho(String rascunho) {
    for (int i = 0; i < _diagnoseRasunhos.length; i++) {
      if (_diagnoseRasunhos[i] == rascunho) {
        _diagnoseRasunhos.removeAt(i);
      }
    }
    notifyListeners();
  }

  void removeDiagnosePdf(String pdf) {
    for (int i = 0; i < _diagnosePdfs.length; i++) {
      if (_diagnosePdfs[i] == pdf) {
        _diagnosePdfs.removeAt(i);
      }
    }
    notifyListeners();
  }

  void atualizaDiferenciacaoDeRacaRascunhos(List<String> rascunhos) {
    _diferenciacaoDeRacaRascunhos = rascunhos;
    notifyListeners();
  }

  void atualizaDiferenciacaoDeRacaPdfs(List<String> pdfs) {
    _diferenciacaoDeRacaPdfs = pdfs;
    notifyListeners();
  }

  void adicionaDiferenciacaoDeRacaRascunho(String rascunho) {
    if (_diferenciacaoDeRacaRascunhos.contains(rascunho) == false &&
        rascunho.isEmpty == false) {
      _diferenciacaoDeRacaRascunhos.add(rascunho);
    }
    notifyListeners();
  }

  void adicionaDiferenciacaoDeRacaPdf(String pdf) {
    if (_diferenciacaoDeRacaPdfs.contains(pdf) == false &&
        pdf.isEmpty == false) {
      _diferenciacaoDeRacaPdfs.add(pdf);
    }
    notifyListeners();
  }

  void removeDiferenciacaoDeRacaRascunho(String rascunho) {
    for (int i = 0; i < _diferenciacaoDeRacaRascunhos.length; i++) {
      if (_diferenciacaoDeRacaRascunhos[i] == rascunho) {
        _diferenciacaoDeRacaRascunhos.removeAt(i);
      }
    }
    notifyListeners();
  }

  void removeDiferenciacaoDeRacaPdf(String pdf) {
    for (int i = 0; i < _diferenciacaoDeRacaPdfs.length; i++) {
      if (_diferenciacaoDeRacaPdfs[i] == pdf) {
        _diferenciacaoDeRacaPdfs.removeAt(i);
      }
    }
    notifyListeners();
  }

  void atualizaMicrobiologicoRascunhos(List<String> rascunhos) {
    _microbiologicoRascunhos = rascunhos;
    notifyListeners();
  }

  void atualizaMicrobiologicoPdfs(List<String> pdfs) {
    _microbiologicoPdfs = pdfs;
    notifyListeners();
  }

  void adicionaMicrobiologicoRascunho(String rascunho) {
    if (_microbiologicoRascunhos.contains(rascunho) == false &&
        rascunho.isEmpty == false) {
      _microbiologicoRascunhos.add(rascunho);
    }
    notifyListeners();
  }

  void adicionaMicrobiologicoPdf(String pdf) {
    if (_microbiologicoPdfs.contains(pdf) == false && pdf.isEmpty == false) {
      _microbiologicoPdfs.add(pdf);
    }
    notifyListeners();
  }

  void removeMicrobiologicoRascunho(String rascunho) {
    for (int i = 0; i < _microbiologicoRascunhos.length; i++) {
      if (_microbiologicoRascunhos[i] == rascunho) {
        _microbiologicoRascunhos.removeAt(i);
      }
    }
    notifyListeners();
  }

  void removeMicrobiologicoPdf(String pdf) {
    for (int i = 0; i < _microbiologicoPdfs.length; i++) {
      if (_microbiologicoPdfs[i] == pdf) {
        _microbiologicoPdfs.removeAt(i);
      }
    }
    notifyListeners();
  }

  void atualizaNematologicoRascunhos(List<String> rascunhos) {
    _nematologicoRascunhos = rascunhos;
    notifyListeners();
  }

  void atualizaNematologicoPdfs(List<String> rascunhos) {
    _nematologicoPdfs = rascunhos;
    notifyListeners();
  }

  void adicionaNematologicoRascunho(String rascunho) {
    if (_nematologicoRascunhos.contains(rascunho) == false &&
        rascunho.isEmpty == false) {
      _nematologicoRascunhos.add(rascunho);
    }
    notifyListeners();
  }

  void adicionaNematologicoPdf(String rascunho) {
    if (_nematologicoPdfs.contains(rascunho) == false &&
        rascunho.isEmpty == false) {
      _nematologicoPdfs.add(rascunho);
    }
    notifyListeners();
  }

  void removeNematologicoRascunho(String rascunho) {
    for (int i = 0; i < _nematologicoRascunhos.length; i++) {
      if (_nematologicoRascunhos[i] == rascunho) {
        _nematologicoRascunhos.removeAt(i);
      }
    }
    notifyListeners();
  }

  void removeNematologicoPdf(String rascunho) {
    for (int i = 0; i < _nematologicoPdfs.length; i++) {
      if (_nematologicoPdfs[i] == rascunho) {
        _nematologicoPdfs.removeAt(i);
      }
    }
    notifyListeners();
  }

  void atualizaSanidadeRascunhos(List<String> rascunhos) {
    _sanidadeRascunhos = rascunhos;
    notifyListeners();
  }

  void atualizaSanidadePdfs(List<String> pdfs) {
    _sanidadePdfs = pdfs;
    notifyListeners();
  }

  void adicionaSanidadeRascunho(String rascunho) {
    if (_sanidadeRascunhos.contains(rascunho) == false &&
        rascunho.isEmpty == false) {
      _sanidadeRascunhos.add(rascunho);
    }
    notifyListeners();
  }

  void adicionaSanidadePdf(String pdf) {
    if (_sanidadePdfs.contains(pdf) == false && pdf.isEmpty == false) {
      _sanidadePdfs.add(pdf);
    }
    notifyListeners();
  }

  void removeSanidadeRascunho(String rascunho) {
    for (int i = 0; i < _sanidadeRascunhos.length; i++) {
      if (_sanidadeRascunhos[i] == rascunho) {
        _sanidadeRascunhos.removeAt(i);
      }
    }
    notifyListeners();
  }

  void removeSanidadePdf(String pdf) {
    for (int i = 0; i < _sanidadePdfs.length; i++) {
      if (_sanidadePdfs[i] == pdf) {
        _sanidadePdfs.removeAt(i);
      }
    }
    notifyListeners();
  }
}
