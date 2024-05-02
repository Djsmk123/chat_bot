import 'package:auto_route/auto_route.dart';
import 'package:chat_with_us/core/utils/theme/theme.dart';
import 'package:chat_with_us/features/chat/presentations/blocs/chat_bloc/chat_bloc.dart';
import 'package:chat_with_us/features/chat/presentations/blocs/chat_bloc/chat_event.dart';
import 'package:chat_with_us/features/chat/presentations/widgets/chat_drawer.dart';
import 'package:chat_with_us/features/chat/presentations/widgets/chats_bot_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:resizable_widget/resizable_widget.dart';

@RoutePage()
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isMobile = constraints.maxWidth < 600;

      return BlocProvider<ChatBloc>(
        create: (context) => ChatBloc()..add(ChatEventConnectSocket()),
        child: Scaffold(
          drawer: isMobile ? const ChatHeaderWidget() : null,
          appBar: isMobile
              ? AppBar(
                  leading: Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                  title: Text(
                    'Chats',
                    style: context.textTheme.copyWith(),
                  ),
                )
              : null,
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<ChatBloc>().add(ChatEventGetSessions());
            },
            child: Center(
              child: ResizableWidget(
                isDisabledSmartHide: true,
                separatorColor: Colors.white12,
                percentages: !isMobile
                    ? [
                        0.2,
                        0.8,
                      ]
                    : [
                        1.0,
                      ],
                children: [
                  if (!isMobile) const ChatHeaderWidget(),
                  const ChatsBotWidget(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
