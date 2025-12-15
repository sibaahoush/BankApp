class Account {
  final int id;
  final String number;
  final String type;
  final String status;
  final double balance;
  final List<dynamic> features;
  final List<Account> children;

  Account({
    required this.id,
    required this.number,
    required this.type,
    required this.status,
    required this.balance,
    this.features = const [],
    this.children = const [],
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as int,
      number: json['number'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      balance: (json['balance'] is int)
          ? (json['balance'] as int).toDouble()
          : json['balance'] as double,
      features: json['features'] as List<dynamic>? ?? [],
      children: json['children'] != null
          ? (json['children'] as List)
              .map((child) => Account.fromJson(child as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'type': type,
      'status': status,
      'balance': balance,
      'features': features,
      'children': children.map((c) => c.toJson()).toList(),
    };
  }

  // Calculate total balance including children
  double get totalBalance {
    double total = balance;
    for (var child in children) {
      total += child.totalBalance;
    }
    return total;
  }
}
