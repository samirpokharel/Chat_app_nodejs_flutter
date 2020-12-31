import 'package:chat_app_frontend/model/user.dart';
import 'package:chat_app_frontend/screens/auth/authentication.dart';
import 'package:chat_app_frontend/screens/home/chat_page.dart';
import 'package:chat_app_frontend/services/list_user_service.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final String id;

  Home({this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat app"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Authentication()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: FutureBuilder(
          future: ListUser().listUser(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              Center(child: CircularProgressIndicator());
            }
            List<User> users = snapshot.data ?? [];
            print(users[0].username);
            return ListView.builder(
              itemCount: users?.length,
              itemBuilder: (context, index) {
                // if (users[index].id == id) {
                //   return null;
                // }
                return ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          reciverId: users[index].id,
                          senderId: id,
                        ),
                      )),
                  leading: CircleAvatar(
                    backgroundColor:
                        users[index].id == id ? Colors.green : Colors.blue,
                    child: Icon(Icons.person),
                  ),
                  title: Text(users[index].username ?? ''),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
