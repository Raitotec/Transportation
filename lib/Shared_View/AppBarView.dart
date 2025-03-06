import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:sizer/sizer.dart';

import '../Constants/Localization/ScopeModelWrapper.dart';
import '../Constants/Routes/route_constants.dart';
import '../Constants/Style.dart';
import '../Constants/assets/Images_Name.dart';




AppBarWithlanguage(BuildContext context, String header) {
  return AppBar(
    title: Text(header, style: TextStyle(
        color: Colors.white, fontSize: 22.0.sp, fontWeight: FontWeight.bold)),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: Style.BoxDecoration1,
    ),
    toolbarHeight: 8.0.h,
    elevation: 0,
    leading: Builder(
      builder: (context) =>
          IconButton(
            alignment: Alignment.center,
            icon: Padding(
                padding: EdgeInsets.fromLTRB(1.5.w, 1.5.h, 1.5.w, 0),
                child: Icon(Icons.menu,size: 4.0.h,   color: Colors.white,)),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
    ),
    actions: <Widget>[
      ScopedModelDescendant<AppModel>(
          builder: (context, child, model) =>
              InkWell(child: Padding(
                padding: EdgeInsets.fromLTRB(1.5.w, 1.5.h, 1.5.w, 0),
                child: Icon(Icons.language, size: 4.0.h,color: Colors.white,),
              ),
                onTap: () {
                  model.changeDirection();
                  Navigator.pushNamedAndRemoveUntil(context, MainRoute,(Route<dynamic> r)=>false);
                },
              )),
    ],
  );
}

AppBarWithBack(BuildContext context, String header) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: Text(header,style: TextStyle(
        color: Colors.white, fontSize: 20.0.sp, fontWeight: FontWeight.bold)),
    flexibleSpace: Container(
      decoration: Style.BoxDecoration1,
    ),
    toolbarHeight: 8.0.h,

    leading: Builder(
      builder: (context) =>
          IconButton(
            icon: Padding(
                padding: EdgeInsets.fromLTRB(1.5.w, 0.5.h, 1.5.w, 0),
                child:Icon(Icons.menu,size: 4.0.h,   color: Colors.white,)),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
    ),
    actions: <Widget>[
      Padding(
          padding: EdgeInsets.all(1.5.w),
          child: GestureDetector(
            child: Icon(Icons.arrow_forward, color: Colors.white,
                size: 4.0.h),
            onTap: () => Navigator.pop(context, false),
          )
      ),
    ],
  );

}