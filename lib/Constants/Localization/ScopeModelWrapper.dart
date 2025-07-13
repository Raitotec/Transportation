import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Locale get appLocal => _appLocale;


  Future<void> changeLanguage(String languageCode) async {
    _appLocale = Locale(languageCode);
    print("Changed language to $languageCode");
    await _saveLanguage(languageCode);
    // لو عندك حفظ في SharedPreferences
    print("Changed language to $languageCode");
    notifyListeners();
  }


  bool get isRTL => ['ar', 'ur'].contains(_appLocale.languageCode);

  /// ✅ حفظ اللغة المختارة
  Future<void> _saveLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', langCode);
    LanguageData.languageData= langCode;
    notifyListeners();
  }

  /// ✅ تحميل اللغة عند بدء التشغيل
  Future<void> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? code = prefs.getString('language_code');
    if (code != null) {
      _appLocale = Locale(code);
      LanguageData.languageData= code;
      notifyListeners();
    }
  }
}