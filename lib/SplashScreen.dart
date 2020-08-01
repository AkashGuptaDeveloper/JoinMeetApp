import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meetjoin/VideoScreen.dart';
//------------------------------------START-----------------------------------//
class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}
//-----------------------------------SplashScreenState------------------------//
class SplashScreenState extends State<SplashScreen> {
  Timer timer;
//-----------------------------------handleTimeout----------------------------//
  void handleTimeout() async {
    Navigator.of(context).push(new MaterialPageRoute(builder: (_) => VideoScreen()));
  }
//-----------------------------------startTimeout-----------------------------//
  startTimeout() async {
    var duration = const Duration(seconds: 4);
    /*return*/ new Timer(duration, handleTimeout);
  }
//-----------------------------------initState--------------------------------//
  @override
  void initState() {
    super.initState();
    startTimeout();
  }
//-----------------------------------------dispose()---------------------------//
  @override
  void dispose() {
    super.dispose();
    startTimeout();
  }
//------------------------------------Widget build----------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: new Form(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                FormLogo(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.060,
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
//-------------------------------AppDeveloperName-----------------------------//
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 24.0),
        child: new Text(
          "Copyright © 2020 MeetJoin \n Developed By Gravit Infosystems".toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color:Colors.black,
          ),
        ),
      ),
    );
  }
//-----------------------------------------------------FormLogo---------------//
  // ignore: non_constant_identifier_names
  Widget FormLogo() {
    return new Column(
      children: <Widget>[
        new Container(
          child: new Container(
            child: Image.asset("assets/images/splash.jpg",
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.fill),
          ),
        ),
      ],
    );
  }
}
//---------------------------------------END----------------------------------//
