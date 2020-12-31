import 'dart:convert';

import 'package:chat_app_frontend/model/message.dart';
import 'package:http/http.dart';

class ChatService {
  String senderId;
  String reciverId;
  ChatService({this.reciverId, this.senderId});

  Future messagePost(String message) async {
    String url = "http://10.0.2.2:3000/api/chat/$senderId/$reciverId";
    try {
      Response response = await post(
        "$url",
        headers: {"Content-Type": "application/json"},
        body: json.encode({"message": message,"sendby":senderId}),
      );
      print(response.body);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Conversation> messageGet() async {
    String url = "http://10.0.2.2:3000/api/chat/$senderId/$reciverId";
    try {
      Response response = await get(
        url,
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Conversation.fromJson(data[0]);
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
