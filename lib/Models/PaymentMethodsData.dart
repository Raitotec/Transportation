import 'package:transportation/Constants/Localization/LanguageData.dart';

class PaymentMethodsData {
  int? id;
  Name? name;

  @override
  String toString() {
    if(name != null && LanguageData.languageData=="ar")
      return name!.ar!;
    else if(name != null && LanguageData.languageData=="en")
      return name!.en!;
    else if(name != null && LanguageData.languageData=="ur")
      return name!.en!;
    else
      return"";// Return the property you want to display
  }

  PaymentMethodsData({this.id, this.name});

  PaymentMethodsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Name {
  String? en;
  String? ar;

  Name({this.en, this.ar});

  Name.fromJson(Map<String, dynamic> json) {
    en = json['en']??"";
    ar = json['ar']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['ar'] = this.ar;
    return data;
  }
}