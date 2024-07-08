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
    this._sanidadeRascunhos,
    this._sanidadePdfs,
    this._controleDeQualidadePlanilhas,
    this._diagnosePlanilhas,
    this._diferenciacaoDeRacaPlanilhas,
    this._microbiologicoPlanilhas,
    this._nematologicoPlanilhas,
    this._sanidadePlanilhas,
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
  List<String> _sanidadeRascunhos;
  List<String> _sanidadePdfs;
  List<String> _controleDeQualidadePlanilhas;
  List<String> _diagnosePlanilhas;
  List<String> _diferenciacaoDeRacaPlanilhas;
  List<String> _microbiologicoPlanilhas;
  List<String> _nematologicoPlanilhas;
  List<String> _sanidadePlanilhas;

  // Getters for all the variables
  List<String> get controleDeQualidadeRascunhos => _controleDeQualidadeRasunhos;
  List<String> get controleDeQualidadePdfs => _controleDeQualidadePdfs;
  List<String> get diagnoseRascunhos => _diagnoseRasunhos;
  List<String> get diagnosePdfs => _diagnosePdfs;
  List<String> get diferenciacaoDeRacaRascunhos => _diferenciacaoDeRacaRascunhos;
  List<String> get diferenciacaoDeRacaPdfs => _diferenciacaoDeRacaPdfs;
  List<String> get microbiologicoRascunhos => _microbiologicoRascunhos;
  List<String> get microbiologicoPdfs => _microbiologicoPdfs;
  List<String> get nematologicoRascunhos => _nematologicoRascunhos;
  List<String> get nematologicoPdfs => _nematologicoPdfs;
  List<String> get sanidadeRascunhos => _sanidadeRascunhos;
  List<String> get sanidadePdfs => _sanidadePdfs;
  List<String> get controleDeQualidadePlanilhas => _controleDeQualidadePlanilhas;
  List<String> get diagnosePlanilhas => _diagnosePlanilhas;
  List<String> get diferenciacaoDeRacaPlanilhas => _diferenciacaoDeRacaPlanilhas;
  List<String> get microbiologicoPlanilhas => _microbiologicoPlanilhas;
  List<String> get nematologicoPlanilhas => _nematologicoPlanilhas;
  List<String> get sanidadePlanilhas => _sanidadePlanilhas;

  // Methods for updating lists
  void atualizaControleDeQualidadeRascunhos(List<String> rascunhos) {
    _controleDeQualidadeRasunhos = rascunhos;
    notifyListeners();
  }

  void atualizaControleDeQualidadePdfs(List<String> pdfs) {
    _controleDeQualidadePdfs = pdfs;
    notifyListeners();
  }

  void atualizaControleDeQualidadePlanilhas(List<String> planilhas) {
    _controleDeQualidadePlanilhas = planilhas;
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

  void atualizaDiagnosePlanilhas(List<String> planilhas) {
    _diagnosePlanilhas = planilhas;
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

  void atualizaDiferenciacaoDeRacaPlanilhas(List<String> planilhas) {
    _diferenciacaoDeRacaPlanilhas = planilhas;
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

  void atualizaMicrobiologicoPlanilhas(List<String> planilhas) {
    _microbiologicoPlanilhas = planilhas;
    notifyListeners();
  }

  void atualizaNematologicoRascunhos(List<String> rascunhos) {
    _nematologicoRascunhos = rascunhos;
    notifyListeners();
  }

  void atualizaNematologicoPdfs(List<String> pdfs) {
    _nematologicoPdfs = pdfs;
    notifyListeners();
  }

  void atualizaNematologicoPlanilhas(List<String> planilhas) {
    _nematologicoPlanilhas = planilhas;
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

  void atualizaSanidadePlanilhas(List<String> planilhas) {
    _sanidadePlanilhas = planilhas;
    notifyListeners();
  }

  // Methods for adding items
  void adicionaControleDeQualidadeRascunho(String rascunho) {
    if (!_controleDeQualidadeRasunhos.contains(rascunho) && rascunho.isNotEmpty) {
      _controleDeQualidadeRasunhos.add(rascunho);
      notifyListeners();
    }
  }

  void adicionaControleDeQualidadePdf(String pdf) {
    if (!_controleDeQualidadePdfs.contains(pdf) && pdf.isNotEmpty) {
      _controleDeQualidadePdfs.add(pdf);
      notifyListeners();
    }
  }

  void adicionaControleDeQualidadePlanilha(String planilha) {
    if (!_controleDeQualidadePlanilhas.contains(planilha) && planilha.isNotEmpty) {
      _controleDeQualidadePlanilhas.add(planilha);
      notifyListeners();
    }
  }

  void adicionaDiagnoseRascunho(String rascunho) {
    if (!_diagnoseRasunhos.contains(rascunho) && rascunho.isNotEmpty) {
      _diagnoseRasunhos.add(rascunho);
      notifyListeners();
    }
  }

  void adicionaDiagnosePdf(String pdf) {
    if (!_diagnosePdfs.contains(pdf) && pdf.isNotEmpty) {
      _diagnosePdfs.add(pdf);
      notifyListeners();
    }
  }

  void adicionaDiagnosePlanilha(String planilha) {
    if (!_diagnosePlanilhas.contains(planilha) && planilha.isNotEmpty) {
      _diagnosePlanilhas.add(planilha);
      notifyListeners();
    }
  }

  void adicionaDiferenciacaoDeRacaRascunho(String rascunho) {
    if (!_diferenciacaoDeRacaRascunhos.contains(rascunho) && rascunho.isNotEmpty) {
      _diferenciacaoDeRacaRascunhos.add(rascunho);
      notifyListeners();
    }
  }

  void adicionaDiferenciacaoDeRacaPdf(String pdf) {
    if (!_diferenciacaoDeRacaPdfs.contains(pdf) && pdf.isNotEmpty) {
      _diferenciacaoDeRacaPdfs.add(pdf);
      notifyListeners();
    }
  }

  void adicionaDiferenciacaoDeRacaPlanilha(String planilha) {
    if (!_diferenciacaoDeRacaPlanilhas.contains(planilha) && planilha.isNotEmpty) {
      _diferenciacaoDeRacaPlanilhas.add(planilha);
      notifyListeners();
    }
  }

  void adicionaMicrobiologicoRascunho(String rascunho) {
    if (!_microbiologicoRascunhos.contains(rascunho) && rascunho.isNotEmpty) {
      _microbiologicoRascunhos.add(rascunho);
      notifyListeners();
    }
  }

  void adicionaMicrobiologicoPdf(String pdf) {
    if (!_microbiologicoPdfs.contains(pdf) && pdf.isNotEmpty) {
      _microbiologicoPdfs.add(pdf);
      notifyListeners();
    }
  }

  void adicionaMicrobiologicoPlanilha(String planilha) {
    if (!_microbiologicoPlanilhas.contains(planilha) && planilha.isNotEmpty) {
      _microbiologicoPlanilhas.add(planilha);
      notifyListeners();
    }
  }

  void adicionaNematologicoRascunho(String rascunho) {
    if (!_nematologicoRascunhos.contains(rascunho) && rascunho.isNotEmpty) {
      _nematologicoRascunhos.add(rascunho);
      notifyListeners();
    }
  }

  void adicionaNematologicoPdf(String pdf) {
    if (!_nematologicoPdfs.contains(pdf) && pdf.isNotEmpty) {
      _nematologicoPdfs.add(pdf);
      notifyListeners();
    }
  }

  void adicionaNematologicoPlanilha(String planilha) {
    if (!_nematologicoPlanilhas.contains(planilha) && planilha.isNotEmpty) {
      _nematologicoPlanilhas.add(planilha);
      notifyListeners();
    }
  }

  void adicionaSanidadeRascunho(String rascunho) {
    if (!_sanidadeRascunhos.contains(rascunho) && rascunho.isNotEmpty) {
      _sanidadeRascunhos.add(rascunho);
      notifyListeners();
    }
  }

  void adicionaSanidadePdf(String pdf) {
    if (!_sanidadePdfs.contains(pdf) && pdf.isNotEmpty) {
      _sanidadePdfs.add(pdf);
      notifyListeners();
    }
  }

  void adicionaSanidadePlanilha(String planilha) {
    if (!_sanidadePlanilhas.contains(planilha) && planilha.isNotEmpty) {
      _sanidadePlanilhas.add(planilha);
      notifyListeners();
    }
  }

  // Methods for removing items
  void removeControleDeQualidadeRascunho(String rascunho) {
    _controleDeQualidadeRasunhos.remove(rascunho);
    notifyListeners();
  }

  void removeControleDeQualidadePdf(String pdf) {
    _controleDeQualidadePdfs.remove(pdf);
    notifyListeners();
  }

  void removeControleDeQualidadePlanilha(String planilha) {
    _controleDeQualidadePlanilhas.remove(planilha);
    notifyListeners();
  }

  void removeDiagnoseRascunho(String rascunho) {
    _diagnoseRasunhos.remove(rascunho);
    notifyListeners();
  }

  void removeDiagnosePdf(String pdf) {
    _diagnosePdfs.remove(pdf);
    notifyListeners();
  }

  void removeDiagnosePlanilha(String planilha) {
    _diagnosePlanilhas.remove(planilha);
    notifyListeners();
  }

  void removeDiferenciacaoDeRacaRascunho(String rascunho) {
    _diferenciacaoDeRacaRascunhos.remove(rascunho);
    notifyListeners();
  }

  void removeDiferenciacaoDeRacaPdf(String pdf) {
    _diferenciacaoDeRacaPdfs.remove(pdf);
    notifyListeners();
  }

  void removeDiferenciacaoDeRacaPlanilha(String planilha) {
    _diferenciacaoDeRacaPlanilhas.remove(planilha);
    notifyListeners();
  }

  void removeMicrobiologicoRascunho(String rascunho) {
    _microbiologicoRascunhos.remove(rascunho);
    notifyListeners();
  }

  void removeMicrobiologicoPdf(String pdf) {
    _microbiologicoPdfs.remove(pdf);
    notifyListeners();
  }

  void removeMicrobiologicoPlanilha(String planilha) {
    _microbiologicoPlanilhas.remove(planilha);
    notifyListeners();
  }

  void removeNematologicoRascunho(String rascunho) {
    _nematologicoRascunhos.remove(rascunho);
    notifyListeners();
  }

  void removeNematologicoPdf(String pdf) {
    _nematologicoPdfs.remove(pdf);
    notifyListeners();
  }

  void removeNematologicoPlanilha(String planilha) {
    _nematologicoPlanilhas.remove(planilha);
    notifyListeners();
  }

  void removeSanidadeRascunho(String rascunho) {
    _sanidadeRascunhos.remove(rascunho);
    notifyListeners();
  }

  void removeSanidadePdf(String pdf) {
    _sanidadePdfs.remove(pdf);
    notifyListeners();
  }

  void removeSanidadePlanilha(String planilha) {
    _sanidadePlanilhas.remove(planilha);
    notifyListeners();
  }
}