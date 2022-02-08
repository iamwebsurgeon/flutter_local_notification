import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
void main() {
  runApp(MaterialApp(home: MyCoolApp()));
}
// void main() => runApp(MyCoolApp());


class MyCoolApp extends StatefulWidget {
  const MyCoolApp({Key? key}) : super(key: key);

  @override
  _MyCoolAppState createState() => _MyCoolAppState();
}

class _MyCoolAppState extends State<MyCoolApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(
        initSettings, onSelectNotification: onSelectNotification);
  }
   Future onSelectNotification(String? payload) async{
    debugPrint("payload: $payload");
    showDialog(context: context, builder: (_)=> new AlertDialog(
      title: new Text("Notification"),
      content: new Text('$payload'),
    ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: showNotification,
          child: Text('Click Me'),
        ),
      ),
    );


  }
  showNotification() async {
    var android = new AndroidNotificationDetails('channel id', 'channel name');
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(0, 'New Notification', 'Flutter Flutter Description', platform, payload: 'Ali is a nice boy.');
  }
}
