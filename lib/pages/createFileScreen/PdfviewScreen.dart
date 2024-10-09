import 'package:flutter/material.dart';
import 'package:agro_bio_tech_pc/constants.dart'; // Suponho que contém 'mainColor' e 'secondaryColor'
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';

class PdfViewer extends StatelessWidget {
  final String path;
  const PdfViewer(this.path, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          secondaryColor, // Cor de fundo da tela (definida em constants.dart)
      body: Stack(
        children: [
          // Botões no topo da tela
          Positioned(
            top: 40,
            left: 10,
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                // Função de ação para o botão "Próximo"
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(30.0), // Bordas arredondadas
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 30.0), // Controle do padding
                minimumSize:
                    const Size(180, 60), // Tamanho mínimo (largura x altura)
                maximumSize:
                    const Size(250, 60), // Tamanho máximo (largura x altura)
              ),
              child: Row(
                mainAxisSize:
                    MainAxisSize.min, // Mantém o tamanho baseado no conteúdo
                children: const [
                  Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                  SizedBox(width: 10), // Espaço entre o texto e o ícone

                  Text(
                    "Voltar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 10,
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(1);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(30.0), // Bordas arredondadas
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 30.0), // Controle do padding
                minimumSize:
                    const Size(180, 60), // Tamanho mínimo (largura x altura)
                maximumSize:
                    const Size(250, 60), // Tamanho máximo (largura x altura)
              ),
              child: Row(
                mainAxisSize:
                    MainAxisSize.min, // Mantém o tamanho baseado no conteúdo
                children: const [
                  Text(
                    "Novo Laudo",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(width: 10), // Espaço entre o texto e o ícone
                  Icon(Icons.add, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Laudo Criado com Sucesso!',
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20), // Espaço entre o texto e o ícone
                const Icon(
                  Icons.picture_as_pdf,
                  color: mainColor,
                  size: 100,
                ),
                const SizedBox(height: 40), // Espaço entre o ícone e os botões
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        OpenFile.open(path);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0), // Bordas arredondadas
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 30.0), // Controle do padding
                        minimumSize: const Size(
                            180, 60), // Tamanho mínimo (largura x altura)
                        maximumSize: const Size(
                            250, 60), // Tamanho máximo (largura x altura)
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize
                            .min, // Mantém o tamanho baseado no conteúdo
                        children: const [
                          Text(
                            "Visualizar",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(width: 10), // Espaço entre o texto e o ícone
                          Icon(Icons.remove_red_eye,
                              color: Colors.white, size: 30),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20), // Espaço entre os botões
                    ElevatedButton(
                      onPressed: () async {
                        Share.shareXFiles([XFile(path)],
                            text: 'Compartilhando PDF');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0), // Bordas arredondadas
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 30.0), // Controle do padding
                        minimumSize: const Size(
                            180, 60), // Tamanho mínimo (largura x altura)
                        maximumSize: const Size(
                            250, 60), // Tamanho máximo (largura x altura)
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize
                            .min, // Mantém o tamanho baseado no conteúdo
                        children: const [
                          Text(
                            "Compartilhar",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(width: 10), // Espaço entre o texto e o ícone
                          Icon(Icons.share, color: Colors.white, size: 30),
                        ],
                      ),
                    ),
                  ],
                ),
               
              ],
            ),
          ),
        ],
      ),
    );
  }
}
