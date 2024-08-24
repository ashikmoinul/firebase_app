import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FirebaseNotificationService._(); // no one can create instance

  static final FirebaseNotificationService instance =
      FirebaseNotificationService._();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initialize(BuildContext buildContext, RemoteMessage message) async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    //Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.notification?.title);
      print(message.notification?.body);
      print(message.data);
    });

    void firebaseInit(BuildContext context) {
      FirebaseMessaging.onMessage.listen(
            (message) {
          // Print notification details to console
          debugPrint(message.notification!.title.toString());
          debugPrint(message.notification!.body.toString());
          debugPrint(message.data['type']);

          // Show notification on Android if the app is in foreground
          if (Platform.isAndroid) {
            if (context.mounted) {
              initialize(context, message); // Initialize local notifications
            }
            showNotification(message); // Show the notification
          }
        },
      );
    }


    //Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(message.notification?.title);
      print(message.notification?.body);
      print(message.data);
    });

    //Terminated
    FirebaseMessaging.onBackgroundMessage(doNothing);
    String? token = await getToken();
    print(token);
  }

  Future<String?> getToken() async{
    String? token = await _firebaseMessaging.getToken();
    return token;
  }
  Future<void> onTokenRefresh() async{
    _firebaseMessaging.onTokenRefresh.listen((token){
      // call an api
      // send new token
    });
  }

  void showNotification(RemoteMessage message) {

  }
}

  Future<void> doNothing(RemoteMessage message) async {}
