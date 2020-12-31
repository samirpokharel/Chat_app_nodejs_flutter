import 'package:chat_app_frontend/screens/home/home.dart';
import 'package:chat_app_frontend/services/auth_services.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  final Function toggleScreen;
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  Signup({Key key, this.toggleScreen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFormField(
                controller: username,
                decoration: InputDecoration(hintText: "Username"),
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                controller: password,
                decoration: InputDecoration(hintText: "password"),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: FlatButton(
                  onPressed: () async {
                    if (username.text.isNotEmpty && password.text.isNotEmpty) {
                      await AuthServices(
                        username: username.text,
                        password: password.text,
                      ).createUser().then((value) {
                        if (value["error"]) {
                          showDialog(
                            context: context,
                            child: AlertDialog(
                              title: Text("login error"),
                              content: Text(
                                  "${value["username"]} ${value["password"]}"),
                              actions: [
                                FlatButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("OK"),
                                )
                              ],
                            ),
                          );
                          return;
                        }
                        if (value["token"] != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Home(id: value["id"],)),
                          );
                        }
                        print(value);
                      });
                    }
                  },
                  child: Text("Signup"),
                  textColor: Colors.white,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 6),
              TextButton(
                onPressed: () => toggleScreen(),
                child: Text("Already have an acount"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
