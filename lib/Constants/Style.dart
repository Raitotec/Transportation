
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Style {
  //colors
  static Color MainColor = Color(0xff420C12);
  static Color MainTextColor = Colors.black87;
  static Color WhiteColor = Color(0xffffffff);
  static Color SecondryColor = Color(0xffE0455F);
  static Color GreyColor = Colors.black12;
  static Color bgColor1 = Colors.white;
  static Color bgColor2 = Colors.white;
  static Color hColor1 = Color(0xff420C12);
  static Color hColor2 = Color(0xffE0455F);
  static Color BorderTextFieldColor = Color(0xffd8d3d3);
  static Color BorderTextFieldFocusedColor = Color(0xffE0455F);
  static Color MediumGreyColor = Colors.black38;


  //fontsize
  static double FontSize25 = 25.0.sp;
  static double FontSize20 = 20.0.sp;
  static double FontSize18 = 18.0.sp;
  static double FontSize16 = 16.0.sp;
  static double FontSize14 = 14.0.sp;
  static double FontSize12 = 12.0.sp;
  static double FontSize10 = 10.0.sp;

  //textStyle
  static TextStyle Header1 = TextStyle(
      color: WhiteColor, fontSize: 25.0.sp, fontWeight: FontWeight.bold);
  static TextStyle Header2 = TextStyle(
      color: WhiteColor, fontSize: 20.0.sp, fontWeight: FontWeight.bold);
  static TextStyle Header3 = TextStyle(
      color: WhiteColor, fontSize: 18.0.sp, fontWeight: FontWeight.bold);
  static TextStyle Header4 = TextStyle(
      color: WhiteColor, fontSize: 16.0.sp, fontWeight: FontWeight.bold);
  static TextStyle Header5 = TextStyle(
      color: WhiteColor, fontSize: 14.0.sp, fontWeight: FontWeight.bold);
  static TextStyle Header6 = TextStyle(
      color: WhiteColor, fontSize: 12.0.sp, fontWeight: FontWeight.bold);
  static TextStyle Header7 = TextStyle(
      color: WhiteColor, fontSize: 10.0.sp, fontWeight: FontWeight.bold);

  static TextStyle MainText25Bold = TextStyle(
      color: MainTextColor, fontSize: 25.0.sp, fontWeight: FontWeight.bold);
  static TextStyle MainText20Bold = TextStyle(
      color: MainTextColor, fontSize: 20.0.sp, fontWeight: FontWeight.bold);
  static TextStyle MainText18Bold = TextStyle(
      color: MainTextColor, fontSize: 18.0.sp, fontWeight: FontWeight.bold);
  static TextStyle MainText16Bold = TextStyle(
      color: MainTextColor, fontSize: 16.0.sp, fontWeight: FontWeight.bold);
  static TextStyle MainText14Bold = TextStyle(
      color: MainTextColor, fontSize: 15.0.sp, fontWeight: FontWeight.bold);
  static TextStyle MainText12Bold = TextStyle(
      color: MainTextColor, fontSize: 12.0.sp, fontWeight: FontWeight.bold);
  static TextStyle MainText10Bold = TextStyle(
      color: MainTextColor, fontSize: 10.0.sp, fontWeight: FontWeight.bold);
  static TextStyle MainText8Bold = TextStyle(
      color: MainTextColor, fontSize: 8.0.sp, fontWeight: FontWeight.bold);

  static TextStyle MainText25 = TextStyle(
      color: MainTextColor, fontSize: 25.0.sp);
  static TextStyle MainText20 = TextStyle(
      color: MainTextColor, fontSize: 20.0.sp);
  static TextStyle MainText18 = TextStyle(
      color: MainTextColor, fontSize: 18.0.sp);
  static TextStyle MainText16 = TextStyle(
      color: MainTextColor, fontSize: 16.0.sp);
  static TextStyle MainText14 = TextStyle(
      color: MainTextColor, fontSize: 14.0.sp);
  static TextStyle MainText12 = TextStyle(
      color: MainTextColor, fontSize: 12.0.sp);
  static TextStyle MainText10 = TextStyle(
      color: MainTextColor, fontSize: 10.0.sp);
  static TextStyle MainText9 = TextStyle(
      color: MainTextColor, fontSize: 9.0.sp);
  static TextStyle MainText8 = TextStyle(
      color: MainTextColor, fontSize: 8.0.sp);

  static double SizeIcon = 3.0.h;
  static double SizeIconAppBar = 4.0.h;

  //boxDecoraation
  //boxDecoraation
  static BoxDecoration BoxDecoration1 = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.topLeft,
          colors: [Style.hColor2, Style.hColor1])
  );
  static BoxDecoration BoxDecoration2 = BoxDecoration(
    color: Style.bgColor1.withOpacity(0.3),
    border: Border.all(color: Colors.white, width: 0.8.w),
    borderRadius: new BorderRadius.only(
      topLeft: const Radius.circular(8.0),
      topRight: const Radius.circular(8.0),
      bottomRight: const Radius.circular(8.0),
      bottomLeft: const Radius.circular(8.0),
    ),
  );

  static BoxDecoration Glass2BoxDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.2),
    border: Border.all(color: Style.SecondryColor, width: 1.0),
    borderRadius: new BorderRadius.only(
      topLeft: const Radius.circular(5.0),
      topRight: const Radius.circular(5.0),
      bottomRight: const Radius.circular(5.0),
      bottomLeft: const Radius.circular(5.0),
    ),
  );
  static BoxDecoration Glass0BoxDecoration = BoxDecoration(
    // color: Colors.white.withOpacity(0.3),
    border: Border.all(color: Colors.white, width: 1.0),
    borderRadius: new BorderRadius.only(
      topLeft: const Radius.circular(5.0),
      topRight: const Radius.circular(5.0),
      bottomRight: const Radius.circular(5.0),
      bottomLeft: const Radius.circular(5.0),
    ),
  );
  static BoxDecoration Glass4BoxDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.4),
    border: Border.all(color: Style.WhiteColor, width: 1.0),
    borderRadius: new BorderRadius.only(
      topLeft: const Radius.circular(5.0),
      topRight: const Radius.circular(5.0),
      bottomRight: const Radius.circular(5.0),
      bottomLeft: const Radius.circular(5.0),
    ),
  );
  static BoxDecoration Glass5BoxDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.5),
    border: Border.all(color: Colors.white, width: 1.0),
    borderRadius: new BorderRadius.only(
      topLeft: const Radius.circular(5.0),
      topRight: const Radius.circular(5.0),
      bottomRight: const Radius.circular(5.0),
      bottomLeft: const Radius.circular(5.0),
    ),
  );
  static BoxDecoration Glass7BoxDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.7),
    border: Border.all(color: Colors.white, width: 1.0),
    borderRadius: new BorderRadius.only(
      topLeft: const Radius.circular(5.0),
      topRight: const Radius.circular(5.0),
      bottomRight: const Radius.circular(5.0),
      bottomLeft: const Radius.circular(5.0),
    ),

  );

  static var milliseconds=800;

}