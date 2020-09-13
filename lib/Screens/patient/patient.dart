import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/Screens/Blog/blog.dart';
import 'package:flutter_auth/Screens/pchat/pchat.dart';
import 'package:flutter_auth/Screens/therapist_screen/therapist_screen.dart';

import '../../constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Patient extends StatefulWidget {
  final UserCredential user;

  Patient(this.user);
  @override
  _PatientState createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  int _currentTab = 0;
  Future<String> url(String context) async {
    final ref = FirebaseStorage.instance.ref().child(context);
// no need of the file extension, the name will do fine.
    var url = await ref.getDownloadURL();

    return (url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [Icon(Icons.local_hospital), Text("Therapists")],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('user2').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return Text("loading");
            }

            return new ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return TherapistScreen(document.id.toString(),
                              document.data(), widget.user);
                        },
                      )),
                      child: new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Container(
                            height: 150.0,
                            decoration: BoxDecoration(
                                color: kPrimaryLightColor,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(120.0, 20.0, 20.0, 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    document.data()["full_name"],
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.school,
                                        color: kPrimaryColor,
                                      ),
                                      Text(
                                        (document.data()["degree"]).toString(),
                                      ),
                                    ],
                                  ),
                                  Text(document.data()["address"].toString()),
                                ],
                              ),
                            )),
                      ),
                    ),
                    FutureBuilder(
                      future: url(document.id.toString()),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Positioned(
                              left: 20.0,
                              top: 15.0,
                              bottom: 15.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/hackathin-7db2f.appspot.com/o/default.png?alt=media&token=bc384991-0530-49b6-8a02-ef442e9baf70",
                                  fit: BoxFit.fill,
                                  width: 90.0,
                                  height: 100.0,
                                ),
                              ));
                        } else {
                          return Positioned(
                              left: 20.0,
                              top: 15.0,
                              bottom: 15.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.network(
                                  snapshot.data,
                                  fit: BoxFit.fill,
                                  width: 90.0,
                                  height: 100.0,
                                ),
                              ));
                        }
                      },
                    )
                  ],
                );
              }).toList(),
            );
          }),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kPrimaryLightColor,
        currentIndex: _currentTab,
        onTap: (int value) {
          setState(() {
            _currentTab = value;
          });
          if (_currentTab == 1) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Pchat(widget.user);
              },
            ));
          }
          if (_currentTab == 2) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Blog(widget.user);
              },
            ));
            // Navigator.push(context, MaterialPageRoute(
            //   builder: (context) {
            //     return Patient(widget.user);
            //   },
            // ));
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                size: 30.0,
              ),
              title: SizedBox.shrink()),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.chat_bubble,
                size: 30.0,
              ),
              title: SizedBox.shrink()),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30.0,
              ),
              title: SizedBox.shrink())
        ],
      ),
    );
  }
}

// Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: new Container(
//                     height: 150.0,
//                     decoration: BoxDecoration(
//                         color: Colors.grey,
//                         borderRadius: BorderRadius.circular(20.0)),
//                   ),
//                 );

//  title: new Text(document.data()['full_name']),
//                   subtitle: new Text(document.data()['degree']),
