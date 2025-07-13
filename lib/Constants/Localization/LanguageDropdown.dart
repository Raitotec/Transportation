import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sizer/sizer.dart';
import 'package:transportation/Constants/Localization/LanguageData.dart';
import 'package:transportation/Constants/Style.dart';
import '../../Shared_View/dropdown.dart';
import 'ScopeModelWrapper.dart';
import 'Translations.dart';

class LanguageDropdown extends StatefulWidget {
  LanguageDropdown({Key? key}) : super(key: key);
  @override
  _LanguageDropdownState createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  LanguageModel? selected ;

  @override
  Widget build(BuildContext context) {

    final model = ScopedModel.of<AppModel>(context, rebuildOnChange: true);
    return CustomDropdownButton2<LanguageModel>(
      onChanged: (LanguageModel? value) {
        setState(() {
          Navigator.pop(context);
          print(value);
          selected = value;
          model.changeLanguage(value!.id!);
        });
      },
      value: selected, hint: Translations.of(context)!.language,
      textStyle: TextStyle(color: Style.MainTextColor, fontSize: 18.0.sp, fontWeight: FontWeight.bold),
      dropdownItems: [
      LanguageModel("ar", "العربية"),
      LanguageModel("en", "English"),
      LanguageModel("ur", "اردو"),
    ],
    );
  }
}
