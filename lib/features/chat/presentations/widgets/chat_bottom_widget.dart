import 'package:chat_with_us/core/utils/theme/theme.dart';
import 'package:chat_with_us/core/widgets/custom_text_field.dart';
import 'package:chat_with_us/features/chat/presentations/blocs/chat_bloc/chat_bloc.dart';
import 'package:chat_with_us/features/chat/presentations/blocs/chat_bloc/chat_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBottomWidget extends StatelessWidget {
  const ChatBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();
    return Row(
      children: [
        Flexible(
          child: CustomTextField(
            labelText: '',
            hintText: 'Type your message...',
            style: context.textTheme.copyWith(
              fontSize: context.fontSize(12),
            ),
            controller: messageController,
            suffixIcon: IconButton(
              icon: Icon(
                Icons.send,
                color: context.isDarkMode() ? Colors.white : Colors.black,
              ),
              onPressed: () {
                context
                    .read<ChatBloc>()
                    .add(ChatEventSendMessage(messageController.text));
                messageController.clear();
              },
            ),
          ),
        )
      ],
    );
  }
}
