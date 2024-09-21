import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> registerStrategy(String name, String clientEmail,
    String commodityCode, List<String> tokens, List<String> sites) async {
  final String url = 'http://localhost:8080/strategies';

  final Map<String, dynamic> requestBody = {
    'name': name,
    'clientEmail': clientEmail,
    'commodityCode': commodityCode,
    'tokens': tokens,
    'sites': sites,
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print('Novo registro criado com sucesso.');
      print('Dados do registro: $responseData');

      print('URL de recuperação: ${url}/${responseData['id']}');
    } else {
      print('Falha ao criar o registro. Status code: ${response.statusCode}');
      print('Erro: ${response.body}');
    }
  } catch (error) {
    print('Erro ao fazer a requisição: $error');
  }
}

Future<dynamic> getEstrategiaPorId(int id) async {
  final url = Uri.parse(
      'http://localhost:8080/strategies/$id'); // Altere o endpoint conforme necessário

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Decodifica o corpo da resposta JSON
      final decodedBody =
          utf8.decode(response.bodyBytes); // Decodifica o corpo como UTF-8

      final estrategia = json.decode(decodedBody);

      // Exibe os dados da estratégia
      print('Estratégia encontrada:');
      print('ID: ${estrategia['id']}');
      print('Nome: ${estrategia['name']}');
      print('Cliente:');
      print('  ID: ${estrategia['client']['id']}');
      print(
          '  Nome: ${estrategia['client']['firstName']} ${estrategia['client']['lastName']}');
      print('  Email: ${estrategia['client']['email']}');
      print('Commodity:');
      print('  Nome: ${estrategia['commodity']['name']}');
      print('  Código: ${estrategia['commodity']['code']}');

      // Lista os tokens
      print('Tokens:');
      for (var token in estrategia['tokens']) {
        print('  ID: ${token['id']}, Token: ${token['token']}');
      }

      // Lista os sites
      print('Sites:');
      for (var site in estrategia['sites']) {
        print('  Nome: ${site['name']}, URL: ${site['url']}');
      }
      return estrategia;
    } else {
      print(
          'Falha ao buscar estratégia. Código de status: ${response.statusCode}');
      print(response.body);
    }
  } catch (e) {
    print('Erro ao fazer requisição: $e');
  }
}


Future<void> updateStrategy(int id, String name, String commodityCode, List<String> tokens, List<String> sites) async {
  // URL da API
  final String url = 'http://localhost:8080/strategies/$id';

  // Cabeçalhos da requisição
  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  // Corpo da requisição
  final Map<String, dynamic> body = {
    'name': name,
    'commodityCode': commodityCode,
    'tokens': tokens,
    'sites': sites,
  };

  try {
    // Fazendo a requisição PUT
    final response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body), // Codifica o JSON em UTF-8 diretamente
    );

    if (response.statusCode == 200) {
      print('Estratégia atualizada com sucesso!');
    } else {
      print('Falha ao atualizar estratégia. Código: ${response.statusCode}');
      print('Resposta: ${response.body}');
    }
  } catch (e) {
    print('Erro na requisição: $e');
  }
}
