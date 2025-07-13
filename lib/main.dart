import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'Constants/Localization/ScopeModelWrapper.dart';
import 'Constants/My_HttpOverrides.dart';
import 'my_app.dart';


Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  final appModel = AppModel();
  await appModel.loadSavedLanguage(); //  تحميل اللغة المحفوظة

  runApp(
    ScopedModel<AppModel>(
      model: appModel,
      child: MyApp(),
    ),
  );
}

