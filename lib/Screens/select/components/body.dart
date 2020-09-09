import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/patient/patient.dart';
import 'package:flutter_auth/Screens/therapist/therapist.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';

class Body extends StatefulWidget {
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Therapist();
                  },
                ),
              );
            },
          ),
          RoundedButton(
            text: "Take Service",
            color: kPrimaryLightColor,
            textColor: Colors.black,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Patient();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
