import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:agro_bio_tech_pc/homeTabBar.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'providers/fileNameProvider.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory documentsDirectory = await getApplicationDocumentsDirectory();

  // Obter o caminho da pasta "rascunhos"
  String path = '${documentsDirectory.path}/gerador de laudos';

  var files = await _listFiles(path + "/rascunhos/controle De Qualidade");
  final controleDeQualidadeR = _obterNomesArquivos(files);

  files = await _listFiles(path + "/rascunhos/diagnose");
  final diagnoseR = _obterNomesArquivos(files);

  files = await _listFiles(path + "/rascunhos/diferenciação De Raça");
  final racaR = _obterNomesArquivos(files);

  files = await _listFiles(path + "/rascunhos/microbiologico");
  final microR = _obterNomesArquivos(files);

  files = await _listFiles(path + "/rascunhos/laudo nematológico");
  final nemaR = _obterNomesArquivos(files);

  files = await _listFiles(path + "/rascunhos/sanidade De Sementes");
  final saniR = _obterNomesArquivos(files);

  files = await _listFiles(path + "/pdfs/controle De Qualidade");
  final controleDeQualidadeP = _obterNomesArquivos(files);

  files = await _listFiles(path + "/pdfs/diagnose");
  final diagnoseP = _obterNomesArquivos(files);

  files = await _listFiles(path + "/pdfs/diferenciação De Raça");
  final racaP = _obterNomesArquivos(files);

  files = await _listFiles(path + "/pdfs/microbiologico");
  final microP = _obterNomesArquivos(files);

  files = await _listFiles(path + "/pdfs/laudo nematológico");
  final nemaP = _obterNomesArquivos(files);

  files = await _listFiles(path + "/pdfs/sanidade De Sementes");
  final saniP = _obterNomesArquivos(files);

  runApp(
    ChangeNotifierProvider(
      create: (context) => FileNameProvider(
        controleDeQualidadeR,
        controleDeQualidadeP,
        diagnoseR,
        diagnoseP,
        racaR,
        racaP,
        microR,
        microP,
        nemaR,
        nemaP,
        saniP,
        saniR,
      ),
      child: const AgroBioTech(),
    ),
  );
}

class AgroBioTech extends StatelessWidget {
  const AgroBioTech({Key? key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: mainColor,
    ));

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      title: 'Agro Bio Tech: Gerador de laudos',
      theme: ThemeData(
        fontFamily: "Quicksand",
        primaryColor: mainColor,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

Future<List<FileSystemEntity>> _listFiles(String path) async {
  try {
    // Obter o diretório de documentos

    // Verificar se a pasta "rascunhos" existe
    if (await Directory(path).exists()) {
      // Listar todos os arquivos na pasta "rascunhos"
      List<FileSystemEntity> files = Directory(path).listSync();

      // Verificar se há arquivos
      if (files.isNotEmpty) {
        return files;
      } else {
        print('Nenhum arquivo encontrado na pasta "meus pdfs".');
      }
    } else {
      print('A pasta' + path + ' não existe.');
    }
  } catch (e) {
    print('Erro ao listar arquivos: $e');
  }
  return [];
}

List<String> _obterNomesArquivos(List<FileSystemEntity> entidades) {
  List<String> nomesArquivos = [];
  for (FileSystemEntity entidade in entidades) {
    // Verificar se a entidade é um arquivo
    if (entidade is File) {
      // Obter apenas o nome do arquivo sem o caminho nem a extensão
      String nomeArquivo = entidade.path;

      while (nomeArquivo.contains('\\') || nomeArquivo.contains('/')) {
        nomeArquivo = nomeArquivo.split('/').last;
        nomeArquivo = nomeArquivo.split('\\').last;
      }
      while (nomeArquivo.contains('.')) {
        nomeArquivo = nomeArquivo.split('.').first;
      }
      nomesArquivos.add(nomeArquivo);
    }
  }
  return nomesArquivos;
}
