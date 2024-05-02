import 'package:chat_with_us/features/chat/data/models/chat_model.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final ChatModel chatModel;
  const ChatBubble({super.key, required this.chatModel});

  @override
  Widget build(BuildContext context) {
    bool isMe = chatModel.chatUserTypeEnum == ChatUserType.user;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isMe ? Colors.blue : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isMe ? 14 : 0),
                  topRight: Radius.circular(isMe ? 0 : 14),
                  bottomLeft: const Radius.circular(14),
                  bottomRight: const Radius.circular(14),
                ),
              ),
              child: Text(
                chatModel.message,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
