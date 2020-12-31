import 'package:chat_app_frontend/screens/auth/login.dart';
import 'package:chat_app_frontend/screens/auth/signup.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool switchScreen = false;
  void toggleScreen() {
    setState(() {
      switchScreen = !switchScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (switchScreen) {
      return Signup(toggleScreen:toggleScreen);
    }
    return Login(toggleScreen:toggleScreen);
  }
}
