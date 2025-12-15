class Transaction {
  final int id;
  final int accountId;
  final String status;
  final double amount;
  final String type; // "withdraw" or "deposit"
  final int? accountRelatedId;
  final int? roleId;
  final String? employeeName;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;

  Transaction({
    required this.id,
    required this.accountId,
    required this.status,
    required this.amount,
    required this.type,
    this.accountRelatedId,
    this.roleId,
    this.employeeName,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as int,
      accountId: json['account_id'] as int,
      status: json['status'] as String,
      amount: (json['amount'] is int)
          ? (json['amount'] as int).toDouble()
          : json['amount'] as double,
      type: json['type'] as String,
      accountRelatedId: json['account_related_id'] as int?,
      roleId: json['role_id'] as int?,
      employeeName: json['employee_name'] as String?,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_id': accountId,
      'status': status,
      'amount': amount,
      'type': type,
      'account_related_id': accountRelatedId,
      'role_id': roleId,
      'employee_name': employeeName,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Helper methods
  bool get isDeposit => type.toLowerCase() == 'deposit';
  bool get isWithdraw => type.toLowerCase() == 'withdraw';
  bool get isCompleted => status.toLowerCase() == 'completed';
}
