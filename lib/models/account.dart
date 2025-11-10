import 'dart:convert';

class Account {
  final String id;
  final String name;
  final String lastName;
  final double balance;

  Account({
    required this.id,
    required this.name,
    required this.lastName,
    required this.balance,
  });

  /// 🏭 Factory constructor — cria um Account a partir de um Map (ex: de um banco ou API)
  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      lastName: map['lastName'] ?? '',
      balance: (map['balance'] ?? 0).toDouble(),
    );
  }

  /// 🔁 Converte o objeto em Map (útil para salvar no banco ou converter pra JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'balance': balance,
    };
  }

  /// 🧬 Cria uma cópia do objeto alterando apenas os campos desejados
  Account copyWith({
    String? id,
    String? name,
    String? lastName,
    double? balance,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      balance: balance ?? this.balance,
    );
  }

  /// 🧾 Converte para JSON (String)
  String toJson() => json.encode(toMap());

  /// 📥 Cria uma instância a partir de uma string JSON
  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source));

  /// 🧠 Facilita debug e logs
  @override
  String toString() {
    return 'Account(id: $id, name: $name, lastName: $lastName, balance: $balance)';
  }

  /// ⚖️ Garante que duas contas com os mesmos dados sejam consideradas iguais
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Account &&
        other.id == id &&
        other.name == name &&
        other.lastName == lastName &&
        other.balance == balance;
  }

  /// 🔢 Necessário quando sobrescrevemos `==`
  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        lastName.hashCode ^
        balance.hashCode;
  }
}
