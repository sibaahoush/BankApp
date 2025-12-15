class Ticket {
  final int id;
  final int customerId;
  final String title;
  final String message;
  final String status; // "sended", etc.
  final String priority; // "normal", "high", etc.
  final DateTime createdAt;
  final DateTime updatedAt;

  Ticket({
    required this.id,
    required this.customerId,
    required this.title,
    required this.message,
    required this.status,
    required this.priority,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'] as int,
      customerId: json['customer_id'] as int,
      title: json['title'] as String,
      message: json['message'] as String,
      status: json['status'] as String,
      priority: json['priority'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'title': title,
      'message': message,
      'status': status,
      'priority': priority,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
