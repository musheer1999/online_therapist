import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import '../../../constants.dart';
import 'data.dart';

class Body extends StatefulWidget {
  // const Body({key, @required this.user}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File _image;
  UserCredential user;
  User usercurrent = FirebaseAuth.instance.currentUser;
  String fullName;
  String mob;
  String email;
  String add;
  String deg;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print(' the image is :   ${image}');
    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }

  @override
  Widget build(BuildContext context) {
    print('the current user email is : ${usercurrent.email}');
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 65,
                    backgroundColor: kPrimaryLightColor,
                    child: ClipOval(
                      child: new SizedBox(
                        width: 120.0,
                        height: 120.0,
                        child: (_image != null)
                            ? Image.file(
                                _image,
                                fit: BoxFit.fill,
                              )
                            : Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/hackathin-7db2f.appspot.com/o/default.png?alt=media&token=bc384991-0530-49b6-8a02-ef442e9baf70",
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.camera,
                      size: 30.0,
                    ),
                    onPressed: () {
                      getImage();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            RoundedInputField(
              hintText: "Name",
              icon: Icons.person,
              onChanged: (value) {
                setState(() {
                  fullName = value;
                });
              },
            ),
            RoundedInputField(
              hintText: "Mob Number",
              icon: Icons.phone,
              onChanged: (value) {
                setState(() {
                  mob = value;
                });
                // _email = value;
              },
            ),
            RoundedInputField(
              hintText: "Email Id",
              icon: Icons.email,
              onChanged: (value) {
                setState(() {
                  email = value;
                });
                // _email = value;
              },
            ),
            RoundedInputField(
              hintText: "Adress",
              icon: Icons.home,
              onChanged: (value) {
                setState(() {
                  add = value;
                });
                // _email = value;
              },
            ),
            RoundedInputField(
              hintText: "Education",
              icon: Icons.school,
              onChanged: (value) {
                setState(() {
                  deg = value;
                });
                // _email = value;
              },
            ),
            SizedBox(height: size.height * 0.05),
            Adduser(fullName, mob, email, add, deg, usercurrent.uid, _image),
            // AddUser(widget.user.user.uid, name, company, age),
          ],
        ),
      ),
    );
  }

  input() {
    print(add);
    print(deg);
    print(email);
    print(mob);
  }
}
