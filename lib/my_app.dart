
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:transportation/ViewModel/ExpensesViewModel.dart';
import 'package:transportation/ViewModel/HomeViewModel.dart';

import 'Constants/Localization/ScopeModelWrapper.dart';
import 'Constants/Localization/TranslationsDelegate.dart';
import 'Constants/Routes/custom_router.dart';
import 'Constants/Routes/route_constants.dart';

import 'package:sizer/sizer.dart' ;

import 'ViewModel/LoginViewModel.dart';
import 'ViewModel/UserViewModel.dart';


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  final GlobalKey<NavigatorState> myNavigatorKey = GlobalKey<NavigatorState>();
  final homeViewModel = HomeViewModel();
  final expensesViewModel = ExpensesViewModel();
  @override
  Widget build(BuildContext contextt) {
    return
           ResponsiveSizer(
                builder: (context, orientation, deviceType) {
                  return  ScopedModelDescendant<AppModel>(
                      builder: (context, child, model) =>
                          MultiProvider(
                              providers: [
                                ChangeNotifierProvider(create: (_) => LoginViewModel()),
                                ChangeNotifierProvider(create: (_) => UserViewModel()),
                                ChangeNotifierProvider.value(value: homeViewModel),
                                ChangeNotifierProvider.value(value: expensesViewModel),
                              ],
                              child:MaterialApp(
                            navigatorKey: myNavigatorKey,
                            locale: model.appLocal,
                            localizationsDelegates: const [
                              TranslationsDelegate(),
                              GlobalMaterialLocalizations.delegate,
                              GlobalWidgetsLocalizations.delegate,
                              GlobalCupertinoLocalizations.delegate
                            ],
                            supportedLocales: const [
                              Locale("en", "US"),
                              Locale("ar", "SA"),
                              Locale('ur', 'PK')
                            ],
                                builder: (context, child) {
                                  return Directionality(
                                    textDirection: model.isRTL ? TextDirection.rtl : TextDirection.ltr,
                                    child: child!,
                                  );
                                },  debugShowCheckedModeBanner: false,
                            color: Colors.white,
                            title: "النقليات",
                            onGenerateRoute: CustomRouter.generatedRoute,
                            initialRoute: Splash_Route,
                          ))

                  );
                }

    );
  }
}


