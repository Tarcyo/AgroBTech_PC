import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:agro_bio_tech_pc/homeTabBar.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'providers/fileNameProvider.dart';
import 'constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setFullScreen(true);
  });

  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = '${documentsDirectory.path}/gerador de laudos';

  var files = await _listFiles(path + "/rascunhos/controle de qualidade");
  final controleDeQualidadeR = _obterNomesArquivos(files);

  files = await _listFiles(path + "/rascunhos/diagnose");
  final diagnoseR = _obterNomesArquivos(files);

  files = await _listFiles(path + "/rascunhos/diferenciação de raça");
  final racaR = _obterNomesArquivos(files);

  files = await _listFiles(path + "/rascunhos/microbiológico");
  final microR = _obterNomesArquivos(files);

  files = await _listFiles(path + "/rascunhos/nematológico");
  final nemaR = _obterNomesArquivos(files);

  files = await _listFiles(path + "/rascunhos/sanidade de sementes");
  final saniR = _obterNomesArquivos(files);

  files = await _listFiles(path + "/pdfs/controle de qualidade");
  final controleDeQualidadeP = _obterNomesArquivos(files);

  files = await _listFiles(path + "/pdfs/diagnose");
  final diagnoseP = _obterNomesArquivos(files);

  files = await _listFiles(path + "/pdfs/diferenciação de raça");
  final racaP = _obterNomesArquivos(files);

  files = await _listFiles(path + "/pdfs/microbiológico");
  final microP = _obterNomesArquivos(files);

  files = await _listFiles(path + "/pdfs/nematológico");
  final nemaP = _obterNomesArquivos(files);

  files = await _listFiles(path + "/pdfs/sanidade de sementes");
  final saniP = _obterNomesArquivos(files);

  files = await _listFiles(path + "/planilhas/controle de qualidade");
  final controS = _obterNomesArquivos(files);

  files = await _listFiles(path + "/planilhas/diagnose");
  final digS = _obterNomesArquivos(files);

  files = await _listFiles(path + "/planilhas/diferenciação de raça");
  final difrS = _obterNomesArquivos(files);

  files = await _listFiles(path + "/planilhas/microbiológico");
  final microS = _obterNomesArquivos(files);

  files = await _listFiles(path + "/planilhas/nematológico");
  final nemaS = _obterNomesArquivos(files);

  files = await _listFiles(path + "/planilhas/sanidade de sementes");
  final saniS = _obterNomesArquivos(files);

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
        saniR,
        saniP,
        controS,
        digS,
        difrS,
        microS,
        nemaS,
        saniS,
      ),
      child: const AgroBioTech(),
    ),
  );
}

class AgroBioTech extends StatelessWidget {
  const AgroBioTech({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: mainColor,
      statusBarIconBrightness: Brightness.light,
    ));


    return MaterialApp(
      title: 'Agro Bio Tech: Gerador de laudos',
      theme: ThemeData(
        fontFamily: "Quicksand",
        primaryColor: mainColor,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
      locale: const Locale('pt', 'BR'),
    );
  }
}

Future<List<FileSystemEntity>> _listFiles(String path) async {
  try {
    if (await Directory(path).exists()) {
      List<FileSystemEntity> files = Directory(path).listSync();
      if (files.isNotEmpty) {
        return files;
      } else {
        print('Nenhum arquivo encontrado na pasta "meus pdfs".');
      }
    } else {
      print('A pasta ' + path + ' não existe.');
    }
  } catch (e) {
    print('Erro ao listar arquivos: $e');
  }
  return [];
}

List<String> _obterNomesArquivos(List<FileSystemEntity> entidades) {
  List<String> nomesArquivos = [];
  for (FileSystemEntity entidade in entidades) {
    if (entidade is File) {
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
