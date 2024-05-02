import 'package:hive/hive.dart';

part 'chat_model.g.dart';

enum ChatUserType {
  user,
  bot;

  String get value {
    switch (this) {
      case ChatUserType.user:
        return 'user';
      case ChatUserType.bot:
        return 'bot';
      default:
        return 'user';
    }
  }
}

@HiveType(typeId: 0)
class ChatModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String message;
  @HiveField(2)
  final String chatUserType;
  @HiveField(3)
  final DateTime createdAt;

  ChatModel({
    required this.id,
    required this.message,
    required this.chatUserType,
    required this.createdAt,
  });
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      message: json['message'],
      chatUserType: json['chatUserType'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'chatUserType': chatUserType,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  ChatUserType get chatUserTypeEnum {
    if (chatUserType == ChatUserType.user.value) {
      return ChatUserType.user;
    } else {
      return ChatUserType.bot;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatModel && other.id == message;
  }

  @override
  int get hashCode =>
      message.hashCode ^
      id.hashCode ^
      chatUserType.hashCode ^
      createdAt.hashCode;
}

extension ChatModelListExt on List<ChatModel> {
  //remove duplicate chat session
  List<ChatModel> removeDuplicates() {
    return toSet().toList();
  }
}
