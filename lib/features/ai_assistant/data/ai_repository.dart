import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/models/chat_message_model.dart';

abstract class AiRepository {
  Future<ChatMessageModel> sendQuery(String query);
  Future<List<ChatMessageModel>> getConversationHistory();
}

class AiRepositoryImpl implements AiRepository {
  final ApiClient apiClient;

  AiRepositoryImpl({required this.apiClient});

  @override
  Future<ChatMessageModel> sendQuery(String query) async {
    try {
      final response = await apiClient.post(
        ApiEndpoints.aiQuery,
        data: {'query': query},
      );
      if (response != null) {
        return ChatMessageModel.fromJson(response);
      }
    } catch (_) {}

    // Mock response for UI integration
    await Future.delayed(const Duration(seconds: 1));
    return ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: 'ai',
      message:
          'Based on Indian legal precedents, you have full right to file a consumer complaint or issue a legal notice before proceeding to litigation.',
      timestamp: 'Just now',
    );
  }

  @override
  Future<List<ChatMessageModel>> getConversationHistory() async {
    try {
      final response = await apiClient.get(ApiEndpoints.aiConversations);
      if (response is List) {
        return response.map((e) => ChatMessageModel.fromJson(e)).toList();
      }
    } catch (_) {}

    return [
      ChatMessageModel(
        id: '1',
        sender: 'user',
        message: 'What are the steps for filing a divorce in India?',
        timestamp: '10:30 AM',
      ),
      ChatMessageModel(
        id: '2',
        sender: 'ai',
        message:
            'Here are the general steps to file a divorce in India:\n1. Meet a qualified lawyer\n2. File a petition in the appropriate family court\n3. Submit required documents\n4. Attend hearings\n5. Get the final decree',
        timestamp: '10:31 AM',
      ),
    ];
  }
}
