import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Blog/Wblog.dart';
import 'package:flutter_auth/Screens/Blog/full.dart';
import 'package:flutter_auth/Screens/patient/patient.dart';
import 'package:flutter_auth/Screens/pchat/pchat.dart';
import 'package:flutter_auth/components/circular_button.dart';

import '../../constants.dart';

class Blog extends StatefulWidget {
  final UserCredential user;

  Blog(this.user);
  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  int _currentTab = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blogs"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('blog').snapshots(),
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
                                  EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        document.data()["Title"],
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return Full(
                                                document.data()["blog"],
                                                document.data()["Title"],
                                                document.data()["name"]);
                                          },
                                        )),
                                        child: Container(
                                          width: 300.0,
                                          child: Text(
                                            document.data()["blog"],
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
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
          if (_currentTab == 1) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Pchat(widget.user);
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
                Icons.mode_edit,
                size: 30.0,
              ),
              title: SizedBox.shrink())
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Wblog(widget.user);
          },
        )),
        tooltip: 'Increment',
        child: Icon(Icons.mode_edit),
      ),
    );
  }
}
