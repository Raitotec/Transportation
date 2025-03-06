
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Constants/Style.dart';


class AnimatedButton extends StatefulWidget {
  final String text;
  final AsyncCallback onTapped;

  AnimatedButton({Key? key,required this.text,required this.onTapped});
  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
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
    ), child: InkWell(child:
    AnimatedContainer(
      duration:  Duration(milliseconds: duration),
      curve: Curves.easeInOutCirc,

      padding: EdgeInsets.symmetric(vertical: 0.3.h, horizontal: 3.0.w),

      decoration: BoxDecoration(
        color: color2,
          /*gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [color1,color2, color2,]),*/
          //border: Border.all(color: color1),
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(15.0),
            topRight: const Radius.circular(15.0),
            bottomRight: const Radius.circular(15.0),
            bottomLeft: const Radius.circular(15.0),
          ),
          boxShadow: [
            BoxShadow(color: Style.GreyColor.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(1, 2))
          ]
      ),
      child: Text(widget.text, textAlign: TextAlign.center,
        style: TextStyle(color: Style.WhiteColor, fontSize: 16.0.sp, fontWeight: FontWeight.bold).copyWith(color: color_text1),),
    ) ,
      onTap: () {
        setState(() {
          color1=Style.WhiteColor;
          color2=Style.GreyColor;
          color_text1=Style.SecondryColor;
        });
        Future.delayed( Duration(milliseconds: duration+100), ()
        async {
        //  Navigator.pushNamedAndRemoveUntil(context, homeRoute,(Route<dynamic> r)=>false);

          setState(() {
            color1=Style.MainColor;
            color2=Style.SecondryColor;
            color_text1=Style.WhiteColor;
           });
           widget.onTapped();
        });
      },
    ));
  }


}