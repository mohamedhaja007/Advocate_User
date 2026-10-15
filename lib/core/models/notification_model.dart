class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String timestamp;
  final bool isRead;
  final String? type;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    this.type,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? '',
      isRead: json['is_read'] ?? json['isRead'] ?? false,
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'message': message,
        'timestamp': timestamp,
        'is_read': isRead,
        'type': type,
      };
}
