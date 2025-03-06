
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';
import '../Constants/Style.dart';


Widget IconedButtonLoading() {
  return LoadingAnimationWidget.discreteCircle(
    color: Style.MainColor,
    size: 5.0.h ,
    secondRingColor: Style.SecondryColor,
    thirdRingColor: Style.MainColor
  );
}

