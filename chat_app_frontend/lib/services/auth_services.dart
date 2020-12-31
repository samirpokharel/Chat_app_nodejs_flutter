import 'dart:convert';

import 'package:http/http.dart';

class AuthServices {
  String username;
  String password;
  AuthServices({this.username, this.password});
  String url = 'http://10.0.2.2:3000/api/users/';

  Future createUser() async {
    try {
      Response response = await post(
        "$url/signup",
        headers: {"Content-Type": "application/json"},
        body: json.encode({"username": username, "password": password}),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future loginUser() async {
    try {
      Response response = await post(
        "$url/login",
        headers: {"Content-Type": "application/json"},
        body: json.encode({"username": username, "password": password}),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      // print(response.body);
    } catch (e) {
      print(e);
    }
  }
}
