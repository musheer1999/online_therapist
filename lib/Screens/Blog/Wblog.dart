import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/blog_field.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';

class Wblog extends StatefulWidget {
  final UserCredential user;

  Wblog(this.user);
  @override
  _WblogState createState() => _WblogState();
}

class _WblogState extends State<Wblog> {
  String name;
  String blog;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Write your blogs")),
        body: Column(
          children: <Widget>[
            RoundedInputField(
              hintText: "Name",
              icon: Icons.person,
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            Blog_Text(
              hintText: "Write Blog",
              onChanged: (value) {
                setState(() {
                  blog = value;
                });
              },
            ),
          ],
        ));
  }
}
