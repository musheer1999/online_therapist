import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wblog extends StatefulWidget {
  final UserCredential user;

  Wblog(this.user);
  @override
  _WblogState createState() => _WblogState();
}

class _WblogState extends State<Wblog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Write your blogs")),
        body: Text("write your own blog"));
  }
}
