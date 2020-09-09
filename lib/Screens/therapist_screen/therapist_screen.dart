import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class TherapistScreen extends StatefulWidget {
  final String id;
  final Map<String, dynamic> document;
  TherapistScreen(
    this.id,
    this.document,
  );
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
      body: Column(
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
          SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(" Name : "),
                Text("${widget.document["full_name"]}"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(" Address : "),
                Container(
                    width: 200.0, child: Text("${widget.document["address"]}")),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(" Degree : "),
                Text("${widget.document["degree"]}"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(" Contact : "),
                Text("${widget.document["Mob"]}"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(" Email-Id: "),
                Text("${widget.document["email"]}"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
