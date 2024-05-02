import 'package:chat_with_us/core/utils/theme/theme.dart';

import 'package:chat_with_us/features/chat/presentations/blocs/chat_bloc/chat_bloc.dart';
import 'package:chat_with_us/features/chat/presentations/blocs/chat_bloc/chat_state.dart';
import 'package:chat_with_us/features/chat/presentations/widgets/chat_bottom_widget.dart';

import 'package:chat_with_us/features/chat/presentations/widgets/chat_list.dart';
import 'package:chat_with_us/features/chat/presentations/widgets/empty_chat.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatsBotWidget extends StatelessWidget {
  const ChatsBotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = context.screenSize.width < 600;
    var state = context.watch<ChatBloc>().state;

    return SizedBox(
      height: 1.sh,
      width: 1.sw,
      child: Stack(
        clipBehavior: Clip.none,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 1.sh,
            width: 1.sw,
          ),

          if (state.status == ChatState.loading ||
              (state.status == ChatState.loaded &&
                  (state.chatSession?.messages.isEmpty == true ||
                      state.chatSession == null)))
            EmptyChatWidget(
              isLoading: state.status == ChatState.loading,
            ),
          // if (state.status == ChatState.loaded &&
          //     state.chatSession?.messages.isNotEmpty == true)
          Positioned(
              bottom: 20.h,
              left: isMobile ? 20.w : 0.2.sw,
              right: isMobile ? 20.w : 0.2.sw,
              child: Column(
                children: [
                  if (state.status == ChatState.loaded &&
                      state.chatSession?.messages.isNotEmpty == true)
                    ChatList(
                      chatSession: state.chatSession!,
                    ),
                  SizedBox(height: 20.h),
                  const ChatBottomWidget(),
                ],
              )),
        ],
      ),
    );
  }
}
