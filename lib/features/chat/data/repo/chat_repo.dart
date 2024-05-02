import 'package:chat_with_us/core/models/result.dart';

import 'package:chat_with_us/features/chat/data/models/chat_model.dart';
import 'package:chat_with_us/features/chat/data/models/chat_session.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ChatRepo {
  static const baseUrl = "wss://echo.websocket.org/";
  static WebSocketChannel? channel;
  static Future<void> connect() async {
    channel = WebSocketChannel.connect(Uri.parse(baseUrl));
    await channel?.ready;
  }

  static Future<void> sendMessage(ChatModel chatModel) async {
    channel?.sink.add(chatModel.message);
  }

  static Future<void> disconnect() async {
    await channel?.sink.close(status.goingAway);
  }

  static Stream<ChatModel?> getMessages() {
    return channel?.stream.map((event) {
          if (!event.toString().contains('Request served by')) {
            ChatModel chatModel = ChatModel(
              chatUserType: ChatUserType.bot.value,
              message: 'Replied to ${event.toString()}',
              id: const Uuid().v1(),
              createdAt: DateTime.now(),
            );

            return chatModel;
          }
          return null;
        }) ??
        const Stream.empty();
  }

  static ChatSession? currentSession;

  static ChatSession createChatSession() {
    currentSession = ChatSession(
      sessionId: const Uuid().v1(),
      createdAt: DateTime.now(),
      messages: [],
    );
    return currentSession!;
  }

  static Future<Result<ChatSession>> getChatSession() async {
    final res = await Hive.openBox<ChatSession>('chat_session');
    if (res.isNotEmpty) {
      var data = res.get(currentSession?.sessionId);
      if (data != null) {
        currentSession = data;
      }
    }
    return Success(data: currentSession!);
  }

  //hive
  static Future<void> saveChatSession() async {
    //save to hive
    final res = await Hive.openBox<ChatSession>('chat_session');
    if (res.isNotEmpty) {
      res.put(currentSession!.sessionId, currentSession!);
    }
    res.put(currentSession!.sessionId, currentSession!);
  }

  static Future<bool> addMessage(ChatModel chatModel) async {
    if (currentSession == null) {
      createChatSession();
    }
    currentSession?.messages.add(chatModel);
    await saveChatSession();

    return true;
  }

  static Future<Result<List<ChatSession>>> getChatSessions() async {
    final res = await Hive.openBox<ChatSession>('chat_session');
    if (res.isNotEmpty) {
      //remove empty chat session from the list
      List<ChatSession> sessionKeys = res.values.toList();
      sessionKeys.removeWhere((element) => element.messages.isEmpty);
      return Success(
        data: sessionKeys,
      );
    }
    return const Success(data: []);
  }

  static Future<void> deleteChatSession(String sessionId) async {
    final res = await Hive.openBox<ChatSession>('chat_session');
    res.delete(sessionId);
  }

  static Future<void> deleteAllChatSession() async {
    final res = await Hive.openBox<ChatSession>('chat_session');
    res.clear();
  }
}
