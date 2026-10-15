import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/chat_message_model.dart';
import '../../data/ai_repository.dart';

abstract class AiAssistantState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AiAssistantInitial extends AiAssistantState {}
class AiAssistantLoading extends AiAssistantState {}
class AiAssistantLoaded extends AiAssistantState {
  final List<ChatMessageModel> messages;
  final bool isThinking;

  AiAssistantLoaded({
    required this.messages,
    this.isThinking = false,
  });

  @override
  List<Object?> get props => [messages, isThinking];
}
class AiAssistantError extends AiAssistantState {
  final String message;
  AiAssistantError(this.message);
  @override
  List<Object?> get props => [message];
}

class AiAssistantCubit extends Cubit<AiAssistantState> {
  final AiRepository aiRepository;
  final List<ChatMessageModel> _messages = [];

  AiAssistantCubit({required this.aiRepository}) : super(AiAssistantInitial());

  Future<void> loadHistory() async {
    emit(AiAssistantLoading());
    try {
      final history = await aiRepository.getConversationHistory();
      _messages.clear();
      _messages.addAll(history);
      emit(AiAssistantLoaded(messages: List.from(_messages)));
    } catch (e) {
      emit(AiAssistantError(e.toString()));
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMsg = ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: 'user',
      message: text,
      timestamp: 'Just now',
    );

    _messages.add(userMsg);
    emit(AiAssistantLoaded(messages: List.from(_messages), isThinking: true));

    try {
      final aiMsg = await aiRepository.sendQuery(text);
      _messages.add(aiMsg);
      emit(AiAssistantLoaded(messages: List.from(_messages), isThinking: false));
    } catch (e) {
      emit(AiAssistantError(e.toString()));
    }
  }
}
