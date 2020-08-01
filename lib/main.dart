//-----------------------------Import-Libraries-------------------------------//
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meetjoin/SplashScreen.dart';
//-----------------------------------------------------------------------------//
void main() {
  runApp(MyApp());
}
//-----------------------------------------------------------------------------//
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor:Colors.amber));
    return new MaterialApp(
      theme: new ThemeData(
        backgroundColor: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
