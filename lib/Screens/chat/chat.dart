import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import '../../constants.dart';

class Chat extends StatefulWidget {
  static const String id = "CHAT";
  final UserCredential user;
  final String email;

  const Chat({Key key, this.user, this.email}) : super(key: key);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> callback() async {
    if (messageController.text.length > 0) {
      await FirebaseFirestore.instance.collection('messages').add({
        'text': messageController.text,
        'from': widget.user.user.email,
        'between': "${widget.user.user.email} & ${widget.email}",
        'date': DateTime.now().toIso8601String().toString(),
        'to': "${widget.email}"
      });
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Icon(Icons.people),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _auth.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .orderBy('date')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  List<DocumentSnapshot> docs = snapshot.data.docs;

                  // List<Widget> messages = docs
                  //     .map((doc) => Message(
                  //           from: doc.data()['from'],
                  //           text: doc.data()['text'],
                  //           me: widget.user.user.email == doc.data()['from'],
                  //         ))
                  //     .toList();

                  List<Widget> messages = docs
                      .map((doc) => (doc.data()["between"].toString() ==
                                  "${widget.user.user.email} & ${widget.email}" ||
                              doc.data()["between"].toString() ==
                                  "${widget.email} & ${widget.user.user.email}")
                          ? Message(
                              from: doc.data()['from'],
                              text: doc.data()['text'],
                              me: widget.user.user.email == doc.data()['from'],
                            )
                          : Text(""))
                      .toList();
                  print(messages[0]);
                  List<Widget> messages2 = messages
                      .where((element) => element == Text("empty"))
                      .toList();

                  return ListView(
                    controller: scrollController,
                    children: messages.map((message) => message).toList(),
                  );
                },
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) => callback(),
                      decoration: InputDecoration(
                        hintText: "Enter a Message...",
                        border: const OutlineInputBorder(),
                      ),
                      controller: messageController,
                    ),
                  ),
                  SendButton(
                    callback: callback,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  final VoidCallback callback;

  const SendButton({Key key, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        color: kPrimaryColor, onPressed: callback, child: Icon(Icons.send));
  }
}

class Message extends StatelessWidget {
  final String from;
  final String text;

  final bool me;

  const Message({Key key, this.from, this.text, this.me}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            from,
          ),
          Material(
            color: me ? Colors.teal : Colors.red,
            borderRadius: BorderRadius.circular(10.0),
            elevation: 6.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Text(
                text,
              ),
            ),
          )
        ],
      ),
    );
  }
}
