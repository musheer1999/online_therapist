import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/select/components/body.dart';

class Select extends StatelessWidget {
  UserCredential user;

  Select(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body(user));
  }
}
