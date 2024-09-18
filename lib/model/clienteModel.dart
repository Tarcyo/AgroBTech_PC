class Cliente {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final List<Commodity> commodities;
  final List<Token> tokens;
  final List<Site> sites;
  final List<Strategy> strategies;
  final List<Group> groups;

  Cliente({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.commodities,
    required this.tokens,
    required this.sites,
    required this.strategies,
    required this.groups,
  });

  // Factory para criar Cliente a partir de JSON
  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      commodities: (json['commodities'] as List)
          .map((commodity) => Commodity.fromJson(commodity))
          .toList(),
      tokens: (json['tokens'] as List)
          .map((token) => Token.fromJson(token))
          .toList(),
      sites: (json['sites'] as List)
          .map((site) => Site.fromJson(site))
          .toList(),
      strategies: (json['strategies'] as List)
          .map((strategy) => Strategy.fromJson(strategy))
          .toList(),
      groups: (json['groups'] as List)
          .map((group) => Group.fromJson(group))
          .toList(),
    );
  }
}

// Classes auxiliares para as listas de commodities, tokens, sites, estratégias e grupos
class Commodity {
  final int id;
  final String name;
  final String code;

  Commodity({required this.id, required this.name, required this.code});

  factory Commodity.fromJson(Map<String, dynamic> json) {
    return Commodity(id: json['id'], name: json['name'], code: json['code']);
  }
}

class Token {
  final int id;
  final String token;

  Token({required this.id, required this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(id: json['id'], token: json['token']);
  }
}

class Site {
  final int id;
  final String name;
  final String url;

  Site({required this.id, required this.name, required this.url});

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(id: json['id'], name: json['name'], url: json['url']);
  }
}

class Strategy {
  final int id;
  final String name;
  final data;

  Strategy({required this.id, required this.name, required this.data});

  factory Strategy.fromJson(Map<String, dynamic> json) {
    return Strategy(id: json['id'], name: json['name'],data: json['strategyData']);
  }
}

class Group {
  final int id;
  final String name;
  final String description;

  Group({required this.id, required this.name, required this.description});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(id: json['id'], name: json['name'], description: json['description']);
  }
}