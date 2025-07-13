
import 'package:shared_preferences/shared_preferences.dart';

class LanguageData {
  static String languageData= "ar";
}


class LanguageModel {
  String? id;
  String? name;

  LanguageModel(this.id, this.name);

  @override
  String toString() {
    return name ?? '';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LanguageModel &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}

List<LanguageModel> languageList = [
  LanguageModel("ar", "العربية"),
  LanguageModel("en", "English"),
  LanguageModel("ur", "اردو"),
];


