import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'ScopeModelWrapper.dart';

class LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<AppModel>(context, rebuildOnChange: false);

    return Column(
      children: [
        ListTile(
          title: Text("English"),
          onTap: () => model.changeLanguage('en'),
        ),
        ListTile(
          title: Text("العربية"),
          onTap: () => model.changeLanguage('ar'),
        ),
        ListTile(
          title: Text("اردو"),
          onTap: () => model.changeLanguage('ur'),
        ),
      ],
    );
  }
}
