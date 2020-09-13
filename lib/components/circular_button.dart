import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';

class CircularButton extends StatelessWidget {
  final Function press;
  final Color color, textColor;
  const CircularButton({
    Key key,
    this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: 60.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: RaisedButton(
          color: color,
          onPressed: press,
          child: Icon(
            Icons.chat,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
