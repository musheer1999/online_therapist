import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'Screens/image.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter A',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}

//  Positioned(
//                         left: 20.0,
//                         top: 15.0,
//                         bottom: 15.0,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(20.0),
//                           child: Image.network(
//                             url(document.id.toString()).toString(),
//                             fit: BoxFit.fill,
//                             width: 90.0,
//                             height: 100.0,
//                           ),
//                         ))
