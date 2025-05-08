
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Constants/Style.dart';

class CustomDropdownButton2<T> extends StatelessWidget {
  const CustomDropdownButton2({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    //this.buttonDecoration,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = Offset.zero,
    super.key,
  });
  final String hint;
  final T? value;
  final List<T> dropdownItems;
  final ValueChanged<T?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  //final BoxDecoration buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isDense: true,
        //To avoid long text overflowing.
        isExpanded: true,
        hint: Container(
          alignment: hintAlignment,
          child: Text(
            hint,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 16.0.sp,
              color: Style.GreyColor,
            ),
          ),
        ),
        value: value,
        items: dropdownItems
            .map((T item) => DropdownMenuItem<T>(
          value: item,
          child: Container(
            alignment: valueAlignment,
            padding: EdgeInsets.symmetric(horizontal: 1.5.w),
            child: Text(
              item.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style:  TextStyle(
                fontSize: 16.0.sp,
                fontWeight: FontWeight.bold,
                color: Style.MainTextColor
              ),
            ),
          ),
        ))
            .toList(),
        onChanged: onChanged,
        selectedItemBuilder: selectedItemBuilder,
        buttonStyleData: ButtonStyleData(
          //height: buttonHeight ?? 40,
         // width: buttonWidth ?? 140,
          padding: EdgeInsets.zero,
          decoration:
              BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                 ),
          elevation: buttonElevation,
        ),
        iconStyleData: IconStyleData(
          icon: Icon(Icons.arrow_drop_down,size: 3.5.h,color: Style.MainColor,),
          openMenuIcon: Icon(Icons.arrow_drop_up,size: 3.5.h,color: Style.SecondryColor),
        ),
        dropdownStyleData: DropdownStyleData(
          //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
          maxHeight: dropdownHeight ?? 25.0.h,
          width: dropdownWidth ?? 30.0.w,

          padding: dropdownPadding,
          decoration: dropdownDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
          elevation: dropdownElevation ?? 8,
          //Null or Offset(0, 0) will open just under the button. You can edit as you want.
          offset: offset,
          scrollbarTheme: ScrollbarThemeData(
            radius: scrollbarRadius ?? const Radius.circular(40),
            thickness: scrollbarThickness != null
                ? MaterialStateProperty.all<double>(scrollbarThickness!)
                : null,
            thumbVisibility: scrollbarAlwaysShow != null
                ? MaterialStateProperty.all<bool>(scrollbarAlwaysShow!)
                : null,
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: itemHeight ?? 5.0.h,
          padding: itemPadding ??  EdgeInsets.only(left: 3.0.w, right: 3.0.w),
        ),
      ),
    );
  }
}