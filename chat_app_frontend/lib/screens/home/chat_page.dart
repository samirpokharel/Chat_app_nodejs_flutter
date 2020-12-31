import 'dart:async';

import 'package:chat_app_frontend/model/message.dart';
import 'package:chat_app_frontend/services/chat_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String senderId;
  final String reciverId;

  const ChatPage({Key key, this.senderId, this.reciverId}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController message = TextEditingController();
  Stream _stream;
  StreamController _streamController;
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    _streamController = StreamController();
    _stream = _streamController.stream;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ChatService(reciverId: widget.reciverId, senderId: widget.senderId)
        .messageGet()
        .then((value) {
      if (value != null) {
        _streamController.add(value);
      }
      setState(() {});
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Page"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StreamBuilder(
              stream: _stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center();
                }
                // Conversation data = snapshot.data;
                List<Message> message = snapshot.data.message ?? [];

                return Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    controller: listScrollController,
                    child: Column(
                      children: List.generate(
                        message.length,
                        (index) => Row(
                          mainAxisAlignment:
                              message[index].sendby == widget.senderId
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: message[index].sendby == widget.senderId
                                    ? Colors.blue
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 13),
                              child: Text(
                                message[index].message,
                                style: TextStyle(
                                  color:
                                      message[index].sendby == widget.senderId
                                          ? Colors.white
                                          : Colors.grey[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).toList(),
                    ),
                  ),
                ));
              }),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: TextFormField(
              controller: message,
              decoration: InputDecoration(
                hintText: "message",
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (message.text.isNotEmpty) {
                      print(widget.senderId);
                      // listScrollController.jumpTo(
                      //     listScrollController.position.maxScrollExtent);
                      await ChatService(
                        senderId: widget.senderId,
                        reciverId: widget.reciverId,
                      ).messagePost(message.text.trim()).whenComplete(() {
                        setState(() {
                          message.text = '';
                        });
                      });
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
