
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:transportation/Constants/Localization/LanguageData.dart';

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

        print('********* Got a message whilst in the foreground!');
        const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          importance: Importance.max,
          priority: Priority.high,
        );
        const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
        try {
          UserNotifaction? userData = message.data != null ? new UserNotifaction.fromJson(message.data) : null;
          if (userData != null && userData.userId != null && userData.userId != "0" &&
              userData.userId!.isNotEmpty) {

            UserNotifactionData.userNotifactionData = userData;
            await removeUserNotifactionDate();
            await saveUserNotifactionData(userData!);
            await flutterLocalNotificationsPlugin.show(
                0,
                userData.title!,
                userData.body!,
                platformChannelSpecifics,
                payload: "ChatNotifaction"
            );
          }
          else {
            await flutterLocalNotificationsPlugin.show(
              0,
              message.notification!.title!,
              message.notification!.body!,
              platformChannelSpecifics,
            );
            //    await CallKit();
          }
        }
        catch(e)
        {
          print("*********"+e.toString());
        }

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
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('******** User granted permission: ${settings.authorizationStatus}');
  }


}

String? currentUuid;
final GlobalKey<NavigatorState> myNavigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  print("********* onBackgroundMessageFun notification");
  var x= LanguageData.languageData;
  print("********"+x);
  print("********"+message.data.toString());
  UserNotifaction? userData = message.data != null ? new UserNotifaction.fromJson(message.data) : null;
  if(userData!= null && userData.userId != null && userData.userId != "0"&& userData.userId!.isNotEmpty) {
    UserNotifactionData.userNotifactionData = userData;
    await removeUserNotifactionDate();
    await saveUserNotifactionData(userData!);
  }
  // await CallKit();
}


