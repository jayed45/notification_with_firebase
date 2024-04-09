import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_con/notification_services.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
//    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      print("Device Token: ");
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            notificationServices.getDeviceToken().then((value) async {
              var data = {
                'to': 'f9n5CjljQ3Oyl0OMe08M6L:APA91bEPcbUPe2KNSkh5cQyHrvpGmFQTj43CufdZEmaxOksWknkZK2lH7nVQjcWvr309za0LFqukE6ZnqYJbcw4rdevzRht0yZ8EPheWM8uSDUL0BEoFxySjkOQfqm5iThLZ7axBk43j',
                'priority': 'high',
                'notification': {
                  'title': 'Notification',
                  'body': 'Sending Notification to other device',
                },
                'data': {
                  'type': 'message',
                  'id': '1234',
                  // Add extra parameter
                }
              };
              await http.post(
                Uri.parse('https://fcm.googleapis.com/fcm/send'),
                body: jsonEncode(data),
                headers: {
                  'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization': 'key=AAAA58WiiAw:APA91bGJgJMTqKPBmthCus2NFGFEgw42-DbB4oIb0ncdipO95MTOb44cYEtrb0Nes_DoCLdpAaL5HV7NmsIEIO2Yp3fRFMFr8zP9ghtdeXvG11OSKn9tlvzmdqXuaTLDlHPCxdaYWDUV',
                },
              );
            });
          },
          child: Text('Send Notification'),
        ),
      ),
    );
  }
}
