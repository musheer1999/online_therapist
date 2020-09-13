import 'package:flutter/material.dart';

class Full extends StatefulWidget {
  final String blogs;
  final String title;
  final String name;
  Full(this.blogs, this.title, this.name);
  @override
  _FullState createState() => _FullState();
}

class _FullState extends State<Full> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Blog"),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(10.0, 100.0, 10.0, 20.0),
                child: Text(widget.blogs)),
            Text("~${widget.title}")
          ],
        ));
  }
}
