import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'Constants/Localization/ScopeModelWrapper.dart';
import 'Constants/My_HttpOverrides.dart';
import 'PushNotificationService/PushNotificationService.dart';
import 'my_app.dart';


Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  final appModel = AppModel();
  await appModel.loadSavedLanguage(); //  تحميل اللغة المحفوظة
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(
    ScopedModel<AppModel>(
      model: appModel,
      child: MyApp(),
    ),
  );
}

