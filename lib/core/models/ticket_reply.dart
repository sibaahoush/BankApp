class TicketReply {
  final int id;
  final int supportedTicketId;
  final int senderId;
  final String senderType; // "user" or "employee"
  final String message;
  final bool isPrivate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic>? sender;

  TicketReply({
    required this.id,
    required this.supportedTicketId,
    required this.senderId,
    required this.senderType,
    required this.message,
    required this.isPrivate,
    required this.createdAt,
    required this.updatedAt,
    this.sender,
  });

  factory TicketReply.fromJson(Map<String, dynamic> json) {
    return TicketReply(
      id: json['id'] as int,
      supportedTicketId: json['supported_ticket_id'] as int,
      senderId: json['sender_id'] as int,
      senderType: json['sender_type'] as String,
      message: json['message'] as String,
      isPrivate: json['is_private'] == 1 || json['is_private'] == true,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      sender: json['sender'] as Map<String, dynamic>?,
    );
  }

  String get senderName => sender?['name'] as String? ?? 'Unknown';
}
