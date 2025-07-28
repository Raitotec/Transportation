
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:transportation/PushNotificationService/NotifactionViewModel.dart';
import 'package:permission_handler/permission_handler.dart';

import 'UserNotifaction.dart';



class PushNotificationService {
  FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  Future initialize(BuildContext context) async {
    try {
      requestNotificationPermissions();

      // Initialize the plugin
      const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
      final  initializationSettingsIOS = DarwinInitializationSettings();
      final InitializationSettings initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      // Get the token
      await getToken();


      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        print('********* Got a message whilst in the foreground!'+message.data.toString());
        const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          importance: Importance.max,
          priority: Priority.high,
        );
        const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
        UserNotifaction? userData = message.data != null ?  UserNotifaction.fromJson(message.data) : null;
        if(userData!= null && userData.title != null && userData.body != null) {
          print("**********"+userData.body.toString());
          await flutterLocalNotificationsPlugin.show(
            0,
            userData.title!,
            userData.body!,
            platformChannelSpecifics,
          );
        }
        NotifactionViewModel.instance.Refresh();
      });

      FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    }
    catch(e)
    {
      print("*********** Exceptoion "+e.toString());
    }
  }

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    print('********* Token: $token');
    return token;
  }

  Future<void> requestNotificationPermissions() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,badge: true,sound: true);
    print('******** User granted permission: ${settings.authorizationStatus}');
  }


}

String? currentUuid;
final GlobalKey<NavigatorState> myNavigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {
   await Firebase.initializeApp();
   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
   const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
     'channel_id',
     'channel_name',
     importance: Importance.max,
     priority: Priority.high,
   );
   const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
   print("********* onBackgroundMessageFun notification");

   UserNotifaction? userData = message.data != null ?  UserNotifaction.fromJson(message.data) : null;
   if(userData!= null && userData.title != null && userData.body != null) {
     print("**********"+userData.body.toString());
     await flutterLocalNotificationsPlugin.show(
       0,
       userData.title!,
       userData.body!,
       platformChannelSpecifics,
     );
   }


}


