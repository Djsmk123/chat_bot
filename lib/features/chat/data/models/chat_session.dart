import 'package:chat_with_us/features/chat/data/models/chat_model.dart';
import 'package:hive/hive.dart';

part 'chat_session.g.dart';

@HiveType(typeId: 1)
class ChatSession {
  @HiveField(0)
  final String sessionId;

  @HiveField(2)
  final DateTime createdAt;
  @HiveField(3)
  final List<ChatModel> messages;

  ChatSession({
    required this.sessionId,
    required this.createdAt,
    required this.messages,
  });
  ChatSession copyWith({
    String? sessionId,
    DateTime? createdAt,
    List<ChatModel>? messages,
  }) {
    return ChatSession(
      sessionId: sessionId ?? this.sessionId,
      createdAt: createdAt ?? this.createdAt,
      messages: messages ?? this.messages,
    );
  }
}
