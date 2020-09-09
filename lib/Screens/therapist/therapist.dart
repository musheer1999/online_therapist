import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/therapist/components/body.dart';

class Therapist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("this is app bar"),
      ),
      body: Body(),
    );
  }
}
