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

  final files = await _listFilesInRascunhos();
  final filesNames = _obterNomesArquivos(files);
  final pdfs = await _listFilesInMeusPdfs();
  final pdfNames = _obterNomesArquivos(pdfs);
  runApp(
    ChangeNotifierProvider(
      create: (context) => FileNameProvider(filesNames,pdfNames),
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

Future<List<FileSystemEntity>> _listFilesInRascunhos() async {
  try {
  
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

 
    String rascunhosPath = '${documentsDirectory.path}/rascunhos';

   
    if (await Directory(rascunhosPath).exists()) {
      
      List<FileSystemEntity> files = Directory(rascunhosPath).listSync();

      if (files.isNotEmpty) {
        return files;
      } else {
        print('Nenhum arquivo encontrado na pasta "rascunhos".');
      }
    } else {
      print('A pasta "rascunhos" não existe.');
    }
  } catch (e) {
    print('Erro ao listar arquivos: $e');
  }
  return [];
}

Future<List<FileSystemEntity>> _listFilesInMeusPdfs() async {
  try {
    // Obter o diretório de documentos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // Obter o caminho da pasta "rascunhos"
    String rascunhosPath = '${documentsDirectory.path}/meus pdfs';
    

    // Verificar se a pasta "rascunhos" existe
    if (await Directory(rascunhosPath).exists()) {
      // Listar todos os arquivos na pasta "rascunhos"
      List<FileSystemEntity> files = Directory(rascunhosPath).listSync();

      // Verificar se há arquivos
      if (files.isNotEmpty) {
        return files;
      } else {
        print('Nenhum arquivo encontrado na pasta "meus pdfs".');
      }
    } else {
      print('A pasta "meus pdfs" não existe.');
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
