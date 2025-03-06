import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Constants/Style.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 8.0.w),
      padding: EdgeInsets.symmetric(vertical: 0.0.h, horizontal: 3.0.w),
      decoration:Style.Glass2BoxDecoration,
      child:  Theme(
        data: Theme.of(context).copyWith(primaryColor: Style.SecondryColor),
        child: TextFormField(
            autovalidateMode :AutovalidateMode.onUserInteraction,
            controller: widget.controller,
            cursorErrorColor: Style.SecondryColor,
            cursorColor: Style.SecondryColor,
            style: Style.MainText16Bold,
            decoration: InputDecoration(
              // icon: Icon(Icons.home_work_outlined, size: 3.0.h),
                border: InputBorder.none,
                labelText: widget.hintText,
                labelStyle:Style.MainText16Bold,
                hintStyle: Style.MainText16Bold
              // errorStyle: TextStyle(color: Style.MainTextColor,fontSize: 12.0.sp,).copyWith(color: Colors.red)
            ),
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
            }
        ),),

    );
  }
}