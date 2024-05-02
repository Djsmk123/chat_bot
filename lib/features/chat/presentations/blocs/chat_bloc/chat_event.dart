import 'package:chat_with_us/features/chat/data/models/chat_session.dart';

sealed class ChatEvent {}

class ChatEventConnectSocket extends ChatEvent {}

class ChatEventDisconnectSocket extends ChatEvent {}

class ChatEventSendMessage extends ChatEvent {
  final String message;

  ChatEventSendMessage(this.message);
}

class ChatLoadEvent extends ChatEvent {
  final ChatSession? chatSessionId;

  ChatLoadEvent({this.chatSessionId});
}

class ChatEventGetSessions extends ChatEvent {}

class ChatEventGetMessages extends ChatEvent {}

class DeleteChatSession extends ChatEvent {
  final ChatSession chatSession;

  DeleteChatSession(this.chatSession);
}
