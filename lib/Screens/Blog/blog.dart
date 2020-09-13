import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/patient/patient.dart';
import 'package:flutter_auth/Screens/pchat/pchat.dart';

import '../../constants.dart';

class Blog extends StatefulWidget {
  final UserCredential user;

  Blog(this.user);
  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  int _currentTab = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blogs"),
      ),
      body: Column(
        children: <Widget>[],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kPrimaryLightColor,
        currentIndex: _currentTab,
        onTap: (int value) {
          setState(() {
            _currentTab = value;
          });
          if (_currentTab == 0) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Patient(widget.user);
              },
            ));
          }
          if (_currentTab == 1) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Pchat(widget.user);
              },
            ));
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                size: 30.0,
              ),
              title: SizedBox.shrink()),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.chat_bubble,
                size: 30.0,
              ),
              title: SizedBox.shrink()),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.mode_edit,
                size: 30.0,
              ),
              title: SizedBox.shrink())
        ],
      ),
    );
  }
}
