import 'dart:convert';

import 'package:chat_app_frontend/model/user.dart';
import 'package:http/http.dart';

class ListUser {
  String url = 'http://10.0.2.2:3000/api/users/';
  Future<List<User>>  listUser() async {
    try {
      Response response = await get(url);
      // print(response.body);
      if (response.statusCode == 200) {
        return List.from(
          json.decode(response.body).map((e) => User.fromJson(e)),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
