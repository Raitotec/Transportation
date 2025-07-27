import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';
import 'package:transportation/PushNotificationService/NotifactionViewModel.dart';

import '../Constants/Routes/route_constants.dart';
import '../Constants/Style.dart';

import 'package:badges/badges.dart' as badges;



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
      Consumer<NotifactionViewModel>(
          builder: (context, viewModel, child) {
            return Container(
                margin: EdgeInsets.fromLTRB(3.0.w, 0, 3.0.w, 0),
                child:  badges.Badge(
                position: badges.BadgePosition.topEnd(top: 0, end: 0),
                showBadge: true,
                badgeContent: Text(
                  viewModel.totalCartCount.toString(),
                  style: Style.Header5,
                ),
                child: InkWell(
                  onTap: ()=>Navigator.pushNamed(context,Notifaction_Route),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(1.5.w, 1.5.h, 1.5.w, 0),
                    child: Icon(Icons.notifications, size: 4.0.h,
                      color: Colors.white,),
                  ),
                )
            ));
          }),
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