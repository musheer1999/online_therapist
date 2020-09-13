import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/chat/chat.dart';
import 'package:flutter_auth/components/circular_button.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TherapistScreen extends StatefulWidget {
  final String id;
  final UserCredential users;
  final Map<String, dynamic> document;
  TherapistScreen(this.id, this.document, this.users);
  @override
  _TherapistScreenState createState() => _TherapistScreenState();
}

class _TherapistScreenState extends State<TherapistScreen> {
  Future<String> url(String context) async {
    final ref = FirebaseStorage.instance.ref().child(context);
// no need of the file extension, the name will do fine.
    var url = await ref.getDownloadURL();

    return (url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                FutureBuilder(
                  future: url(widget.id),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                          height: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0)),
                            child: Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/hackathin-7db2f.appspot.com/o/default.png?alt=media&token=bc384991-0530-49b6-8a02-ef442e9baf70",
                              fit: BoxFit.fill,
                            ),
                          ));
                    } else {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width * 0.8,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0)),
                            child: Image.network(
                              snapshot.data,
                              fit: BoxFit.fill,
                            ),
                          ));
                    }
                  },
                ),
                Positioned(
                    bottom: 20.0,
                    left: 20.0,
                    child: Text(widget.document["full_name"],
                        style: TextStyle(fontSize: 25.0, color: Colors.black)))
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(300.0, 10.0, 1.0, 1.0),
              child: CircularButton(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Chat(
                          user: widget.users, email: widget.document["email"]),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent[100],
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(5.0, 5.0),
                      blurRadius: 2.0,
                    )
                  ]),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          " Name     : ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2),
                        ),
                        Text(
                          "${widget.document["full_name"]}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 1.2),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " Address : ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2),
                        ),
                        Container(
                            width: 200.0,
                            child: Text(
                              "${widget.document["address"]}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 1.2),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          " Degree   : ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2),
                        ),
                        Text(
                          "${widget.document["degree"]}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 1.2),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          " Contact  : ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2),
                        ),
                        Text(
                          "${widget.document["Mob"]},",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 1.2),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          " Email-Id : ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2),
                        ),
                        Text(
                          "${widget.document["email"]}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 1.2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
