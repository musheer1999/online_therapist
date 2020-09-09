// import 'package:flutter/material.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'dart:io';
// import 'package:path/path.dart';

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   File _image;

//   @override
//   Widget build(BuildContext context) {
//     Future getImage() async {
//       var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//       print(' the image is :   ${image}');
//       setState(() {
//         _image = image;
//         print('Image Path $_image');
//       });
//     }

//     Future uploadPic(BuildContext context) async {
//       String fileName = basename("default6.png");
//       StorageReference firebaseStorageRef =
//           FirebaseStorage.instance.ref().child(fileName);
//       StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);

//       print(_image);
//       StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//       var downloadUrl = await firebaseStorageRef.getDownloadURL();
//       print(
//           " this is the URL of the image downloaded : ${downloadUrl.toString()}");
//       setState(() {
//         print("Profile Picture uploaded");
//         Scaffold.of(context)
//             .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
//       });
//     }

//     Future uploadPic2(BuildContext context) async {
//       final ref = FirebaseStorage.instance.ref().child('this is DP');
// // no need of the file extension, the name will do fine.
//       var url = await ref.getDownloadURL();
//       print(url);
//     }

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             icon: Icon(
//               Icons.arrow_left,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             }),
//         title: Text('Edit Profile'),
//       ),
//       body: Builder(
//         builder: (context) => Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(
//                 height: 20.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Align(
//                     alignment: Alignment.center,
//                     child: CircleAvatar(
//                       radius: 100,
//                       backgroundColor: Color(0xff476cfb),
//                       child: ClipOval(
//                         child: new SizedBox(
//                           width: 180.0,
//                           height: 180.0,
//                           child: (_image != null)
//                               ? Image.file(
//                                   _image,
//                                   fit: BoxFit.fill,
//                                 )
//                               : Image.network(
//                                   "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
//                                   fit: BoxFit.fill,
//                                 ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 60.0),
//                     child: IconButton(
//                       icon: Icon(
//                         Icons.camera,
//                         size: 30.0,
//                       ),
//                       onPressed: () {
//                         getImage();
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Container(
//                       child: Column(
//                         children: <Widget>[
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text('Username',
//                                 style: TextStyle(
//                                     color: Colors.blueGrey, fontSize: 18.0)),
//                           ),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text('Michelle James',
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 20.0,
//                                     fontWeight: FontWeight.bold)),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Container(
//                       child: Icon(
//                         Icons.edit,
//                         color: Color(0xff476cfb),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Container(
//                       child: Column(
//                         children: <Widget>[
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text('Birthday',
//                                 style: TextStyle(
//                                     color: Colors.blueGrey, fontSize: 18.0)),
//                           ),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text('1st April, 2000',
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 20.0,
//                                     fontWeight: FontWeight.bold)),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Container(
//                       child: Icon(
//                         Icons.edit,
//                         color: Color(0xff476cfb),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Container(
//                       child: Column(
//                         children: <Widget>[
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text('Location',
//                                 style: TextStyle(
//                                     color: Colors.blueGrey, fontSize: 18.0)),
//                           ),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text('Paris, France',
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 20.0,
//                                     fontWeight: FontWeight.bold)),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Container(
//                       child: Icon(
//                         Icons.edit,
//                         color: Color(0xff476cfb),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 margin: EdgeInsets.all(20.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     Text('Email',
//                         style:
//                             TextStyle(color: Colors.blueGrey, fontSize: 18.0)),
//                     SizedBox(width: 20.0),
//                     Text('michelle123@gmail.com',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   RaisedButton(
//                     color: Color(0xff476cfb),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     elevation: 4.0,
//                     splashColor: Colors.blueGrey,
//                     child: Text(
//                       'Cancel',
//                       style: TextStyle(color: Colors.white, fontSize: 16.0),
//                     ),
//                   ),
//                   RaisedButton(
//                     color: Color(0xff476cfb),
//                     onPressed: () {
//                       uploadPic(context);
//                     },
//                     elevation: 4.0,
//                     splashColor: Colors.blueGrey,
//                     child: Text(
//                       'Submit',
//                       style: TextStyle(color: Colors.white, fontSize: 16.0),
//                     ),
//                   ),
//                   RaisedButton(
//                     color: Color(0xff476cfb),
//                     onPressed: () {
//                       uploadPic2(context);
//                     },
//                     elevation: 4.0,
//                     splashColor: Colors.blueGrey,
//                     child: Text(
//                       'Submit2',
//                       style: TextStyle(color: Colors.white, fontSize: 16.0),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
