import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:flutter/services.dart';
//------------------------------------START-----------------------------------//
class VideoScreen extends StatefulWidget {
  @override
  VideoScreenState createState() => new VideoScreenState();
}
//-----------------------------------SplashScreenState------------------------//
class VideoScreenState extends State<VideoScreen> {
  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "GravitInfoSystem");
  final subjectText = TextEditingController(text: "Meet Join");
  final nameText = TextEditingController(text: "User Test");
  final emailText = TextEditingController(text: "fake@email.com");
  final iosAppBarRGBAColor = TextEditingController(text: "#0080FF80");//transparent blue
  var isAudioOnly = false;
  var isAudioMuted = false;
  var isVideoMuted = false;
  // ignore: non_constant_identifier_names
  bool Room = false;
  // ignore: non_constant_identifier_names
  // ignore: non_constant_identifier_names
  bool server = false;
  bool Name = false;
  bool Subject = false;
  bool DisplayName = false;
  bool Email = false;
  bool iosAppBarColor = false;
  var isAudioOnly1 = false;
  var isAudioMuted1 = false;
  var isVideoMuted1 = false;
//-----------------------------------initState--------------------------------//
  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }
//-----------------------------------------dispose()---------------------------//
  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }
//------------------------------------Widget build----------------------------//
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 14.0,
              ),
              Visibility(
                visible: server,
                child: TextField(
                  controller: serverText,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Server URL",
                      hintText: "Hint: Leave empty for meet.jitsi.si"),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),

              Visibility(
                visible: Room,
                child:TextField(
                  controller: roomText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Room",
                  ),
                ),),
              SizedBox(
                height: 16.0,
              ),

              Visibility(
                visible: Subject,
                child: TextField(
                  controller: subjectText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Subject",
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),

              Visibility(
                visible: DisplayName,
                child:TextField(
                  controller: nameText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Display Name",
                  ),
                ),
              ),
              SizedBox(
                height:50.0,
              ),

              Visibility(
                visible: Email,
                child:TextField(
                  controller: emailText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),

              Visibility(
                visible: iosAppBarColor,
                child:TextField(
                  controller: iosAppBarRGBAColor,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "AppBar Color(IOS only)",
                      hintText: "Hint: This HAS to be in HEX RGBA format"),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),

              Visibility(
                visible: isAudioOnly1,
                child: CheckboxListTile(
                  title: Text("Audio Only"),
                  value: isAudioOnly,
                  onChanged: _onAudioOnlyChanged,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),

              Visibility(
                visible: isAudioMuted1,
                child:CheckboxListTile(
                  title: Text("Audio Muted"),
                  value: isAudioMuted,
                  onChanged: _onAudioMutedChanged,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),

              Visibility(
                visible:isVideoMuted1,
                child:  CheckboxListTile(
                  title: Text("Video Muted"),
                  value: isVideoMuted,
                  onChanged: _onVideoMutedChanged,
                ),
              ),


              Container(
                child: Center(
                  child:SizedBox(
                    height: 64.0,
                    width: double.maxFinite,
                    child: RaisedButton(
                      onPressed: () {
                        _joinMeeting();
                      },
                      child: Text(
                        "Join Meeting",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.amber,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 48.0,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
//-----------------------------_onAudioOnlyChanged----------------------------//
  _onAudioOnlyChanged(bool value) {
    setState(() {
      isAudioOnly = value;
    });
  }
//-----------------------------_onAudioMutedChanged---------------------------//
  _onAudioMutedChanged(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }
//-----------------------------_onVideoMutedChanged---------------------------//
  _onVideoMutedChanged(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }
//-----------------------------_joinMeeting-----------------------------------//
  _joinMeeting() async {
    String serverUrl =
    serverText.text?.trim()?.isEmpty ?? "" ? null : serverText.text;
    try {
      // Enable or disable any feature flag here
      // If feature flag are not provided, default values will be used
      // Full list of feature flags (and defaults) available in the README
      Map<FeatureFlagEnum, bool> featureFlags =
      {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED : false,
        FeatureFlagEnum.INVITE_ENABLED : false,
        /* FeatureFlagEnum.ADD_PEOPLE_ENABLED : false,*/

      };
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid)
      {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
        featureFlags[FeatureFlagEnum.INVITE_ENABLED] = false;
        /*featureFlags[FeatureFlagEnum.ADD_PEOPLE_ENABLED] = false;*/

      }
      else if (Platform.isIOS)
      {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
        featureFlags[FeatureFlagEnum.INVITE_ENABLED] = false;
        /* featureFlags[FeatureFlagEnum.ADD_PEOPLE_ENABLED] = false;*/
      }
      // Define meetings options here
      var options = JitsiMeetingOptions()
        ..room = roomText.text
        ..serverURL = serverUrl
        ..subject = subjectText.text
        ..userDisplayName = nameText.text
        ..userEmail = emailText.text
        ..iosAppBarRGBAColor = iosAppBarRGBAColor.text
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlags.addAll(featureFlags);

      /*debugPrint("JitsiMeetingOptions: $options");*/
      await JitsiMeet.joinMeeting(options,
        listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
          /*debugPrint("${options.room} will join with message: $message");*/
        }, onConferenceJoined: ({message}) {
          /* debugPrint("${options.room} joined with message: $message");*/
        }, onConferenceTerminated: ({message}) {
          /*debugPrint("${options.room} terminated with message: $message");*/
        }),
        // by default, plugin default constraints are used
        //roomNameConstraints: new Map(), // to disable all constraints
        //roomNameConstraints: customContraints, // to use your own constraint(s)
      );
    } catch (error) {
      /*debugPrint("error: $error");*/
    }
  }
//---------------------------_onConferenceWillJoin----------------------------//
  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }
//---------------------------_onConferenceJoined------------------------------//
  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }
//---------------------------_onConferenceTerminated--------------------------//
  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }
//---------------------------_onError-----------------------------------------//
  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
//---------------------------------------END----------------------------------//
