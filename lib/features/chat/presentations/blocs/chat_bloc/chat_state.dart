import 'package:chat_with_us/features/chat/data/models/chat_session.dart';

class ChatStates {
  final ChatState status;
  final ChatSession? chatSession;
  final List<ChatSession> chatSessions;

  ChatStates({
    required this.status,
    this.chatSession,
    this.chatSessions = const [],
  });

  factory ChatStates.initial() {
    return ChatStates(
      status: ChatState.initial,
    );
  }
  ChatStates copyWith({
    ChatState? status,
    ChatSession? chatSession,
    List<ChatSession>? chatSessions,
  }) {
    return ChatStates(
      status: status ?? this.status,
      chatSession: chatSession ?? this.chatSession,
      chatSessions: chatSessions ?? this.chatSessions,
    );
  }
}

enum ChatState {
  initial,
  loading,
  loaded,
  error,
  offline,
}
