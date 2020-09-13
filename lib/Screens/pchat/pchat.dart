import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/chat/chat.dart';
import 'package:flutter_auth/Screens/patient/patient.dart';
import 'package:flutter_auth/components/circular_button.dart';

import '../../constants.dart';

class Pchat extends StatefulWidget {
  final UserCredential user;

  Pchat(this.user);
  @override
  _PchatState createState() => _PchatState();
}

class _PchatState extends State<Pchat> {
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
        title: Text("chats"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('user').snapshots(),
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
                      onTap: () => print("the user is selected to chats"),
                      child: new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Container(
                            width: 400.0,
                            height: 110.0,
                            decoration: BoxDecoration(
                                color: kPrimaryLightColor,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(120.0, 20.0, 20.0, 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        document.data()["full_name"],
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.home,
                                            color: Colors.black45,
                                          ),
                                          Text(
                                            document.data()["degree"],
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  CircularButton(
                                    press: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Chat(
                                              user: widget.user,
                                              email: document.data()["email"]),
                                        ),
                                      );
                                    },
                                  )
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(200.0),
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(45.0),
                                child: Image.network(
                                  snapshot.data,
                                  fit: BoxFit.fill,
                                  width: 90.0,
                                  height: 90.0,
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
          if (_currentTab == 0) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Patient(widget.user);
              },
            ));
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
