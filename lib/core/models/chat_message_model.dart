class ChatMessageModel {
  final String id;
  final String sender; // 'user' or 'ai'
  final String message;
  final String timestamp;

  ChatMessageModel({
    required this.id,
    required this.sender,
    required this.message,
    required this.timestamp,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] ?? '',
      sender: json['sender'] ?? 'ai',
      message: json['message'] ?? json['text'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'sender': sender,
        'message': message,
        'timestamp': timestamp,
      };
}
