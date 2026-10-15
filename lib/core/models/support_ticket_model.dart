class SupportTicketModel {
  final String id;
  final String ticketNumber;
  final String subject;
  final String description;
  final String status; // Open, Pending, Resolved, Closed
  final String createdAt;

  SupportTicketModel({
    required this.id,
    required this.ticketNumber,
    required this.subject,
    required this.description,
    required this.status,
    required this.createdAt,
  });

  factory SupportTicketModel.fromJson(Map<String, dynamic> json) {
    return SupportTicketModel(
      id: json['id'] ?? '',
      ticketNumber: json['ticket_number'] ?? json['ticketNumber'] ?? '',
      subject: json['subject'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 'Open',
      createdAt: json['created_at'] ?? json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'ticket_number': ticketNumber,
        'subject': subject,
        'description': description,
        'status': status,
        'created_at': createdAt,
      };
}
