import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sizer/sizer.dart';
import '../Style.dart';
import 'LanguageData.dart';
import 'ScopeModelWrapper.dart';

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:scoped_model/scoped_model.dart';
import 'ScopeModelWrapper.dart'; // AppModel
import 'package:transportation/Constants/Localization/LanguageData.dart'; // LanguageModel + list

class LanguageIconDropdownButton extends StatefulWidget {
  final Color? color;
  const LanguageIconDropdownButton({ this.color,super.key});

  @override
  State<LanguageIconDropdownButton> createState() => _LanguageIconDropdownButtonState();
}

class _LanguageIconDropdownButtonState extends State<LanguageIconDropdownButton> {
  LanguageModel? selectedLang;

  @override
  void initState() {
    super.initState();
    selectedLang = languageList.firstWhere((lang) => lang.id == 'ar'); // default
  }

  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<AppModel>(context, rebuildOnChange: true);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
     Container(
       margin: EdgeInsets.symmetric(vertical: 2.0.h,horizontal: 3.0.w),
         child:  DropdownButtonHideUnderline(
      child: DropdownButton2<LanguageModel>(
        customButton:  Icon(Icons.language, color:widget.color??Style.SecondryColor, size: 4.0.h), // 🌐 أيقونة فقط
        items: languageList.map((lang) {
          return DropdownMenuItem<LanguageModel>(
            value: lang,
            child: Text(lang.name!),
          );
        }).toList(),
        value: selectedLang,
        onChanged: (LanguageModel? newLang) {
          if (newLang != null) {
            setState(() {
              selectedLang = newLang;
            });
            model.changeLanguage(newLang.id!);
          }
        },
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 8),
          height: 40,
          width: 45,
        ),
        dropdownStyleData: DropdownStyleData(
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
        ),
        iconStyleData: const IconStyleData(
          icon: SizedBox.shrink(),
        ),
      ),
    ))]);
  }
}
