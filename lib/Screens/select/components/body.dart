import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/chat/chat.dart';
import 'package:flutter_auth/Screens/d_personal/d_personal.dart';
import 'package:flutter_auth/Screens/patient/body.dart';
import 'package:flutter_auth/Screens/patient/patient.dart';
import 'package:flutter_auth/Screens/pchat/pchat.dart';
import 'package:flutter_auth/Screens/therapist/therapist.dart';
import 'package:flutter_auth/Screens/userdata/user.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatefulWidget {
  final UserCredential user;

  Body(this.user);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/app_logo.png",
            width: size.width * 0.60,
          ),
          SizedBox(height: size.height * 0.03),
          Text(
            "SELECT",
            style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryColor),
          ),
          RoundedButton(
            text: "Give Service",
            press: () {
              navi(context, widget.user.user.email, widget.user);
            },
          ),
          RoundedButton(
            text: "Take Service",
            color: kPrimaryLightColor,
            textColor: Colors.black,
            press: () {
              navi2(context, widget.user.user.email, widget.user);
            },
          ),
        ],
      ),
    );
  }
}

void navi2(context, user, p) {
  Iterable<String> x;
  int i = 0;
  FirebaseFirestore.instance
      .collection("user")
      .get()
      .then((QuerySnapshot snapshot) {
    x = snapshot.docs.map((f) => f.data()["email"].toString());
  }).then((value) => {
            // print(x[1]),
            x.any((element) => element == user)
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Patient(p);
                      },
                    ),
                  )
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Users(p);
                      },
                    ),
                  )
          });
}

void navi(context, user, p) {
  Iterable<String> x;
  int i = 0;
  FirebaseFirestore.instance
      .collection("user2")
      .get()
      .then((QuerySnapshot snapshot) {
    x = snapshot.docs.map((f) => f.data()["email"].toString());
  }).then((value) => {
            // print(x[1]),
            x.any((element) => element == user)
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Dpersonal(p);
                      },
                    ),
                  )
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Therapist();
                      },
                    ),
                  )
          });
}
