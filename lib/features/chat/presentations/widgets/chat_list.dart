import 'package:chat_with_us/features/chat/data/models/chat_session.dart';

import 'package:chat_with_us/features/chat/presentations/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  final ChatSession chatSession;
  const ChatList({super.key, required this.chatSession});

  @override
  Widget build(BuildContext context) {
    var data = chatSession.messages.toSet().toList();
    return ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ChatBubble(chatModel: data[index]);
      },
    );
  }
}
