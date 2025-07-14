

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Constants/Style.dart';
import '../Shared_Data/DelegateData.dart';


Widget ProfileImage()
{
  return  (DelegateData.delegateData!.user!.image == null ||
      DelegateData.delegateData!.user!.image!.isEmpty) ?
  Image(image: AssetImage('lib/assets/profile.png'), height: 6.0.h,) :
  Container(
    //  margin: EdgeInsets.symmetric(horizontal: 10.0.w),
      padding: EdgeInsets.all(2), // Border width
      decoration: BoxDecoration(
        color: Colors.black12, shape: BoxShape.circle,
      ),
      child: Container(
          padding: EdgeInsets.all(3), // Border width
          decoration: BoxDecoration(
            color: Colors.white, shape: BoxShape.circle,
          ),
          child: ClipOval(
              child: SizedBox.fromSize(
                  size: Size.fromRadius(3.0.h),
                  // Image radius
                  child:
                  Image.network(DelegateData.delegateData!.user!.image!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, url, error) => Image(image: AssetImage(
                        'lib/assets/profile.png'), height: 7.0.h,),
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return CircularProgressIndicator(
                        color: Style.WhiteColor,
                      );
                    },)))));
}

Widget SelectedCustomer()
{
  return    Row(children: [
    SizedBox(width: 2.0.w,),
    ProfileImage(),
    SizedBox(width: 2.0.w,),
    Expanded(
      child: Text( "CustomereData.customereData!.name!",
        style: TextStyle(color: Style.MainTextColor, fontSize: 14.0.sp, fontWeight: FontWeight.bold),
      ),),
  ]);
}