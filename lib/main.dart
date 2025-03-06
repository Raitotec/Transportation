import 'dart:io';

import 'package:flutter/material.dart';

import 'Constants/Localization/ScopeModelWrapper.dart';
import 'Constants/My_HttpOverrides.dart';


void main() {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new ScopeModelWrapper());
}

