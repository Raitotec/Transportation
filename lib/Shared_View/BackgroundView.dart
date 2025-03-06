
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Constants/assets/Images_Name.dart';
import 'package:sizer/sizer.dart';

import '../Constants/Style.dart';

class BackgroundView extends StatefulWidget {
  final Widget dataWidget;

  BackgroundView({Key? key,required this.dataWidget});
  @override
  _BackgroundViewState createState() => _BackgroundViewState();
}

class _BackgroundViewState extends State<BackgroundView>
    with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {

    return  Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Style.bgColor1,  Style.bgColor2,]),
        ),
        child: Stack(
            children: [
             /* Positioned(
                 bottom: -150,
               //   left: 50.0,
                 // right: 10.0,
                  top: 30.0,
                  child: Container(
                    height: 50.0.h,
                    width: 100.0.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImagesName.bg3),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),*/
              Column(
                children: [
                  Expanded(child:
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                      child: widget.dataWidget,
                    ),
                  ),
                  )
                ],
              )
            ]));
  }


}