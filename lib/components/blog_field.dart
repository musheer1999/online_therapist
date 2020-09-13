import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/constants.dart';

class Blog_Text extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const Blog_Text({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 400.0,
        width: 350.0,
        child: TextFieldContainer(
          child: TextFormField(
            validator: (input) {
              if (input.isEmpty) {
                return 'plzz enter email';
              }
            },
            onChanged: onChanged,
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
                hintText: hintText, border: InputBorder.none, hintMaxLines: 20),
          ),
        ),
      ),
    );
  }
}
