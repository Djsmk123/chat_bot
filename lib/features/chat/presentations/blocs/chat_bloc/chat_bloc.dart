//ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:chat_with_us/core/models/result.dart';
import 'package:chat_with_us/core/utils/toast.dart';
import 'package:chat_with_us/features/chat/data/models/chat_model.dart';
import 'package:chat_with_us/features/chat/data/models/chat_session.dart';
import 'package:chat_with_us/features/chat/data/repo/chat_repo.dart';
import 'package:chat_with_us/features/chat/presentations/blocs/chat_bloc/chat_event.dart';
import 'package:chat_with_us/features/chat/presentations/blocs/chat_bloc/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class ChatBloc extends Bloc<ChatEvent, ChatStates> {
  ChatBloc() : super(ChatStates.initial()) {
    on<ChatEvent>((event, emit) async {
      if (event is ChatEventConnectSocket) {
        try {
          await ChatRepo.connect();
          add(ChatLoadEvent());
          add(ChatEventGetSessions());
          add(ChatEventGetMessages());
        } catch (e) {
          Utility.showToast('Failed to connect', ToastType.error);
        }
      }
      if (event is ChatEventGetMessages) {
        await emit.forEach(ChatRepo.getMessages(), onData: (data) {
          if (data != null) {
            if (data.chatUserTypeEnum == ChatUserType.bot) {
              ChatRepo.addMessage(
                data,
              );
            }

            return state.copyWith(
              chatSession: state.chatSession?.copyWith(
                messages: [...state.chatSession!.messages, data],
              ),
            );
          }
          return state;
        });
      }
      if (event is ChatEventSendMessage) {
        try {
          var chatModel = ChatModel(
            message: event.message,
            id: const Uuid().v1().toString(),
            chatUserType: ChatUserType.user.value,
            createdAt: DateTime.now(),
          );
          await ChatRepo.sendMessage(chatModel);
          await ChatRepo.addMessage(chatModel);
          add(ChatEventGetSessions());
          emit(state.copyWith(
            chatSession: state.chatSession?.copyWith(
              messages: [...state.chatSession!.messages, chatModel],
            ),
          ));
        } catch (e) {
          Utility.showToast('Failed to send message', ToastType.error);
        }
      }
      if (event is ChatEventDisconnectSocket) {
        try {
          await ChatRepo.disconnect();
        } catch (e) {
          Utility.showToast('Failed to disconnect', ToastType.error);
        }
      }
      if (event is ChatLoadEvent) {
        try {
          emit(state.copyWith(
            status: ChatState.loading,
          ));
          if (event.chatSessionId == null) {
            ChatRepo.createChatSession();
          } else {
            ChatRepo.currentSession = event.chatSessionId;
          }
          final res = await ChatRepo.getChatSession();
          if (res is Success<ChatSession>) {
            emit(state.copyWith(
              status: ChatState.loaded,
              chatSession: res.data,
            ));
          } else {
            emit(state.copyWith(
              status: ChatState.error,
            ));
            return;
          }
        } catch (e) {
          emit(state.copyWith(
            status: ChatState.error,
          ));
        }
      }
      if (event is DeleteChatSession) {
        await ChatRepo.deleteChatSession(event.chatSession.sessionId);
        emit(state.copyWith(
          chatSessions: state.chatSessions
              .where(
                  (element) => element.sessionId != event.chatSession.sessionId)
              .toList(),
        ));
      }
      if (event is ChatEventGetSessions) {
        emit(state.copyWith(
          status: ChatState.loading,
        ));
        try {
          final res = await ChatRepo.getChatSessions();
          if (res is Success<List<ChatSession>>) {
            emit(state.copyWith(
              status: ChatState.loaded,
              chatSessions: res.data,
            ));
          }
        } catch (e) {
          emit(state.copyWith(
            status: ChatState.error,
          ));
        }
      }
    });
  }
}
