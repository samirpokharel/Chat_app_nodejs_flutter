import 'package:chat_app_frontend/model/user.dart';

class Conversation {
  Conversation({
    this.users,
    this.id,
    this.message,
  });

  List<User> users;
  String id;
  List<Message> message;

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      id: json["_id"],
      message:
          List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
    );
  }
}

class Message {
  Message({
    this.id,
    this.sendby,
    this.message,
  });

  String id;
  String sendby;
  String message;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        sendby: json["sendby"],
        message: json["message"],
      );
}
