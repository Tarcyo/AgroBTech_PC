import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> registerSite(String name, String siteUrl, String clientEmail) async {
  // Defina a URL da API para a qual você vai fazer a requisição
  final String apiUrl = 'http://localhost:8080/sites';

  // Crie o corpo da requisição com os parâmetros recebidos
  final Map<String, dynamic> requestBody = {
    'name': name,
    'url': siteUrl,
    'clientEmail': clientEmail,
  };

  // Faça a requisição POST
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    // Verifique se a requisição foi bem-sucedida
    if (response.statusCode == 201) {
      // Analise o corpo da resposta
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print('Novo site registrado com sucesso.');
      print('Dados do registro: $responseData');

      // Imprima a URL para recuperar o registro
      print('URL de recuperação: ${apiUrl}/${responseData['id']}');
    } else {
      print('Falha ao registrar o site. Status code: ${response.statusCode}');
      print('Erro: ${response.body}');
    }
  } catch (error) {
    print('Erro ao fazer a requisição: $error');
  }
}