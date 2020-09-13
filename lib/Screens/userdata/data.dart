import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/d_personal/d_personal.dart';
import 'package:flutter_auth/Screens/patient/patient.dart';
import 'package:flutter_auth/components/rounded_button.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';

class Adduser2 extends StatefulWidget {
  final String fullName;
  final String mob;
  final String email;
  final String add;
  final String deg;
  final String uid;
  final File _image;
  final UserCredential pas;
  Adduser2(this.fullName, this.mob, this.email, this.add, this.deg, this.uid,
      this._image, this.pas);

  @override
  _Adduser2State createState() => _Adduser2State();
}

class _Adduser2State extends State<Adduser2> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users2 = FirebaseFirestore.instance.collection('user');

    Future<void> addUser2() async {
      String fileName = basename(widget.uid);
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(widget._image);

      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      var downloadUrl = await firebaseStorageRef.getDownloadURL();
      print(
          " this is the URL of the image downloaded : ${downloadUrl.toString()}");

      // Call the user's CollectionReference to add a new user
      return users2
          .doc(widget.uid)
          .set({
            'full_name': widget.fullName, // John Doe
            'Mob': widget.mob, // Stokes and Sons
            'email': widget.email,
            'address': widget.add,
            'degree': widget.deg, // 42
          })
          .then((value) => print("User Added ${widget.uid} ${widget.fullName}"))
          .catchError((error) => print("Failed to add user: $error"));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Patient(widget.pas);
          },
        ),
      );
    }

    return RoundedButton(
      text: "Register",
      press: () {
        addUser2();
      },
    );
  }
}
