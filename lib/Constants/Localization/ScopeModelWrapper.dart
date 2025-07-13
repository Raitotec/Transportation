import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../my_app.dart';
import 'LanguageData.dart';



class ScopeModelWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(model: AppModel(), child: MyApp());
  }
}

class AppModel extends Model {
  Locale _appLocale = Locale('ar');
  Locale get appLocal => _appLocale ;



  void changeLanguage(String languageCode) {
    _appLocale = Locale(languageCode);
    print("Changed language to $languageCode");

    saveLanguageData(languageCode); // لو عندك حفظ في SharedPreferences
    print("Changed language to $languageCode");

    notifyListeners();
  }

  bool get isRTL => ['ar', 'ur'].contains(_appLocale.languageCode);
}
