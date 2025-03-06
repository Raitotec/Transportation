import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../Constants/Localization/Translations.dart';
import '../Constants/Style.dart';
import 'AppBarView.dart';
import 'BackgroundView.dart';
import 'DrawerView.dart';
import 'ProgressIndicatorButton.dart';

Widget buildLoadingScaffold(BuildContext context,String title) {
  return //Scaffold(
    //appBar: AppBarWithlanguage(context, title),
   // drawer: DrawerList(context),
   // body:
    LoadingOverlay(
      child: SafeArea(child: BackgroundView(dataWidget: Container())),
      isLoading: true,
      opacity: 0.2,
      color: Style.MainColor,
      progressIndicator: IconedButtonLoading(),
   // ),
  );
}