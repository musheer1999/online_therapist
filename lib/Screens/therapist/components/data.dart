import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/d_personal/d_personal.dart';
import 'package:flutter_auth/Screens/select/select_screen.dart';
import 'package:flutter_auth/components/rounded_button.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';

class Adduser extends StatelessWidget {
  final String fullName;
  final String mob;
  final String email;
  final String add;
  final String deg;
  final String uid;
  final File _image;
  Adduser(
    this.fullName,
    this.mob,
    this.email,
    this.add,
    this.deg,
    this.uid,
    this._image,
  );
  @override
  Widget build(BuildContext context) {
    CollectionReference users2 = FirebaseFirestore.instance.collection('user2');

    Future<void> addUser() async {
      String fileName = basename(uid);
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);

      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      var downloadUrl = await firebaseStorageRef.getDownloadURL();
      print(
          " this is the URL of the image downloaded : ${downloadUrl.toString()}");

      // Call the user's CollectionReference to add a new user
      return users2
          .doc(uid)
          .set({
            'full_name': fullName, // John Doe
            'Mob': mob, // Stokes and Sons
            'email': email,
            'address': add,
            'degree': deg, // 42
          })
          .then((value) => print("User Added $uid $fullName"))
          .catchError((error) => print("Failed to add user: $error"));

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return Select();
      //     },
      //   ),
      // );
    }

    return RoundedButton(
      text: "Register",
      press: () {
        addUser();
      },
    );
  }
}
