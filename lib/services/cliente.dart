import 'dart:convert';
import 'package:http/http.dart' as http;
import 'estrategia.dart';
final Uri url = Uri.parse('http://localhost:8080/clients');

Future<bool> registerClient(final String firstName, final String lastName,final String email, final String phone) async {
      
  final body = jsonEncode({
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'phone': phone,
  });

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      print('Cliente registrado com sucesso: $responseData');
      return true;
    } else {
      print(
          'Falha ao registrar o cliente. Código de status: ${response.statusCode}');
          print(response.body);
      return false;
    }
  } catch (error) {
    print('Erro ao enviar requisição: $error');
    return false;
  }
}


Future<dynamic> fetchClientById(int id) async {
  // URL base da API, substitua com o endpoint correto
  final url = Uri.parse('http://localhost:8080/clients/$id'); 

  try {
    // Faz a requisição GET
    final response = await http.get(url, headers: {
      'Accept': 'application/json',  // Define o tipo de resposta esperado
    });

    // Verifica se a requisição foi bem-sucedida (status code 200)
    if (response.statusCode == 200) {
      // Decodifica o corpo da resposta (JSON) para um Map
      final Map<String, dynamic> data = json.decode(response.body);

      // Exibe os dados do cliente no console
      print('Cliente encontrado:');
      print('ID: ${data['id']}');
      print('Nome: ${data['firstName']} ${data['lastName']}');
      print('Email: ${data['email']}');
      print('Telefone: ${data['phone']}');

      // Exibe os commodities
      final commodities = data['commodities'] as List;
      print('Commodities:');
      for (var commodity in commodities) {
        print('  - ID: ${commodity['id']}, Nome: ${commodity['name']}, Código: ${commodity['code']}');
      }

      // Exibe os tokens
      final tokens = data['tokens'] as List;
      print('Tokens:');
      for (var token in tokens) {
        print('  - ID: ${token['id']}, Token: ${token['token']}');
      }

      // Exibe os sites
      final sites = data['sites'] as List;
      print('Sites:');
      for (var site in sites) {
        print('  - ID: ${site['id']}, Nome: ${site['name']}, URL: ${site['url']}');
      }

      // Exibe as estratégias e inclui 'strategyData' usando a função getEstrategiaPorId
      final strategies = data['strategies'] as List;
      print('Estratégias:');
      for (var strategy in strategies) {
        print('  - ID: ${strategy['id']}, Nome: ${strategy['name']}');
        
        // Faz a requisição para obter os dados da estratégia
        final strategyData = await getEstrategiaPorId(strategy['id']);
        
        // Adiciona 'strategyData' à estratégia original
        strategy['strategyData'] = strategyData;

        // Exibe os dados da estratégia adicional
        print('  Dados da Estratégia Adicional:');
        print('  - Nome: ${strategyData['name']}');
        print('  - Commodity: ${strategyData['commodity']['name']}');
      }

      // Exibe os grupos
      final groups = data['groups'] as List;
      print('Grupos:');
      for (var group in groups) {
        print('  - ID: ${group['id']}, Nome: ${group['name']}, Descrição: ${group['description']}');
      }
      return data;
    } else {
      // Exibe uma mensagem de erro se o status code não for 200
      print('Erro ao buscar o cliente. Código de status: ${response.statusCode}');
    }
  } catch (e) {
    // Trata qualquer exceção que possa ocorrer durante a requisição
    print('Erro ao fazer a requisição: $e');
  }
}

 