// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:chat_with_us/core/routes/routes.gr.dart';
import 'package:chat_with_us/core/utils/theme/theme.dart';
import 'package:chat_with_us/features/auth/data/repo/auth_services.dart';
import 'package:chat_with_us/features/chat/presentations/blocs/chat_bloc/chat_bloc.dart';
import 'package:chat_with_us/features/chat/presentations/blocs/chat_bloc/chat_event.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatHeaderWidget extends StatelessWidget {
  const ChatHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var chats = context.watch<ChatBloc>().state.chatSessions;
    bool isMobile = context.screenSize.width < 600;
    //new chats and chat groups list
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      elevation: 0,
      child: Column(
        children: [
          SizedBox(
            height: 80.h,
            child: DrawerHeader(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: !context.isDarkMode()
                      ? const Color(0XFFB9B4C7)
                      : const Color(0XFF0F0F0F)),
              child: GestureDetector(
                onTap: () {
                  context.read<ChatBloc>().add(ChatLoadEvent());
                  if (isMobile) {
                    Navigator.pop(context);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('New Chat', style: context.textTheme.copyWith()),
                    const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    chats[index].messages.last.message,
                    style: context.textTheme.copyWith(
                        // color:
                        //     !context.isDarkMode() ? Colors.white : Colors.black,
                        ),
                  ),
                  onTap: () {
                    context.read<ChatBloc>().add(
                          ChatLoadEvent(
                            chatSessionId: chats[index],
                          ),
                        );
                    if (isMobile) {
                      //close the drawer
                      Navigator.pop(context);
                    }
                  },
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      context.read<ChatBloc>().add(
                            DeleteChatSession(
                              chats[index],
                            ),
                          );
                      if (isMobile) {
                        //close the drawer
                        Navigator.pop(context);
                      }
                    },
                  ),
                );
              },
            ),
          ),
          Divider(
            color: context.isDarkMode() ? Colors.white : Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  context.read<ChatBloc>().add(ChatEventGetSessions());
                },
                child: Text(
                  'Logout',
                  style: context.textTheme.copyWith(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await AuthService.logout();
                  context.router.replace(const LoginScreen());
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
