import 'package:flutter/widgets.dart';

class LoginProvider extends ChangeNotifier {
  String get token => _token;
  String _token;
  void login(String authToken) {
    // print(authToken);
    _token = authToken;
    notifyListeners();
    // print(token);
  }

  void logout() {
    // token = null;
    notifyListeners();
  }
}
