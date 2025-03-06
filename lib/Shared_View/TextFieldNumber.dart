
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart' as intl;

import '../Constants/Style.dart';

class TextFieldNumber extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String? label;
  final String? hint;
  final Function(String)? onTapOutside;
  final TextAlign? textAlign;
  final double? vertical;
  final Widget? helper;
  const TextFieldNumber({
    Key? key,
    required this.controller,
    this.label,
    required this.onChanged,
    this.hint,
    this.onTapOutside,
    this.textAlign,
    this.vertical,this.helper
  }) : super(key: key);

  @override
  _GlobalTextFieldState createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<TextFieldNumber> {
  @override
  void initState() {
    super.initState();

//    textDirection= (widget.controller!=null && widget.controller.text !=null && widget.controller.text.isNotEmpty)?
    //  intl.Bidi.detectRtlDirectionality(widget.controller.text)? TextDirection.rtl: TextDirection.ltr:LangeData.lang=="ar"?TextDirection.rtl:TextDirection.ltr;
  }

  TextDirection textDirection= TextDirection.ltr;
  @override
  Widget build(BuildContext context) {
    return  TextField(
      textDirection: textDirection,
      scrollPadding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
      controller: widget.controller,
      cursorErrorColor: Style.SecondryColor,
      cursorColor: Style.SecondryColor,
      style: TextStyle(color: Style.MainTextColor,fontSize: 16.0.sp,fontWeight: FontWeight.bold),
      textAlignVertical: TextAlignVertical.top,
      textAlign: widget.textAlign??TextAlign.center,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle:TextStyle(color: Style.MainTextColor,fontSize: 16.0.sp,fontWeight: FontWeight.bold),
        hintStyle: TextStyle(color: Style.MediumGreyColor,fontSize: 16.0.sp,),
        hintText: widget.hint??"0",
        errorStyle: TextStyle(color: Style.MainTextColor,fontSize: 14.0.sp,).copyWith(color: Colors.red),
        helper: widget.helper??Container(),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Style.BorderTextFieldFocusedColor, width: 1.0), // Border when focused
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Style.BorderTextFieldColor, width: 0.5), // Border when enabled
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0), // Border when there's an error
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0), // Border when there's an error
        ),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 3.0.w,vertical:widget.vertical?? 0.5.h),
        alignLabelWithHint:true,
      ),
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
      },
      onChanged: (value) {
        print("GlobalTextField  "+ value);
        if(value != null && value.isNotEmpty)
        {
          setState(() {
            if(intl.Bidi.detectRtlDirectionality(value))
            {
              textDirection=TextDirection.rtl;
            }
            else
            {
              textDirection= TextDirection.ltr;
            }
          });
        }
        // Call the onChanged function passed from the parent
        widget.onChanged(value);
      },
      onTapOutside: ( value)
      {
        try {
          widget.onTapOutside?.call(value.toString());
        }
        catch(e){
          print("****onTapOutside"+e.toString());
        }
      },
    );
  }
}