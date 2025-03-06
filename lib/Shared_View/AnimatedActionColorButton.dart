
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Constants/Style.dart';

class AnimatedActionColorButton extends StatefulWidget {
  final String text;
  final Future<void> Function(BuildContext) onTapped;



  AnimatedActionColorButton({Key? key,required this.text,required this.onTapped});
  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedActionColorButton>
    with SingleTickerProviderStateMixin {
  Color color_text1=Style.WhiteColor;
  Color color1 = Style.MainColor;
  Color color2 = Style.SecondryColor;
  int duration=100;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Theme(data: ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent
    ), child:
    Container(
        margin: EdgeInsets.fromLTRB(12.0.w, 2.0.h, 12.0.w, 2.0.h),
        child: InkWell(
          child:
    AnimatedContainer(
      duration:  Duration(milliseconds: duration),
      curve: Curves.easeInOutCirc,

      padding: EdgeInsets.symmetric(vertical: 0.6.h, horizontal: 3.0.w),

      decoration: BoxDecoration(
         // color: color1,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [color1, color2]),
          //border: Border.all(color: color1),
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(5.0),
            topRight: const Radius.circular(5.0),
            bottomRight: const Radius.circular(5.0),
            bottomLeft: const Radius.circular(5.0),
          ),
          boxShadow: [
            BoxShadow(color: Style.GreyColor.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(2, 3))
          ]
      ),
      child: Text(widget.text, textAlign: TextAlign.center,
        style: TextStyle(color: color_text1,
            fontSize: 18.0.sp, fontWeight: FontWeight.bold),),
    ) ,
      onTap: () {
        setState(() {
          color_text1=Style.SecondryColor;
          color1=Style.WhiteColor;
          color2=Style.WhiteColor.withOpacity(0.6);
        });
        Future.delayed( Duration(milliseconds: duration+100), ()
        async {
        //  Navigator.pushNamedAndRemoveUntil(context, homeRoute,(Route<dynamic> r)=>false);


          await widget.onTapped(context);
           setState(() {
             color1=Style.MainColor;
             color_text1=Style.WhiteColor;
             color2=Style.SecondryColor;

           });
        });
      },
    )));
  }


}