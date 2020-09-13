import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/patient/patient.dart';
import 'package:flutter_auth/Screens/therapist/components/body.dart';

class Bottom extends StatefulWidget {
  final UserCredential user;

  Bottom(this.user);

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _currentTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Patient(widget.user)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF6200EE),
        onTap: (int value) {
          print("tapped");
          setState(() {
            _currentTab = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 30.0,
              ),
              title: SizedBox.shrink()),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30.0,
              ),
              title: SizedBox.shrink()),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                size: 30.0,
              ),
              title: SizedBox.shrink())
        ],
      ),
    );
  }
}
