
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';
import 'package:store_redirect/store_redirect.dart';

import '../Constants/Style.dart';
import '../Constants/Localization/Translations.dart';



AlertView(BuildContext context, String image,  String Title, String Description, {int id=0})async {
 await Alert(
    context: context,
    title: Title,
    desc: Description,
    image: Image.asset("lib/Constants/assets/$image.png", width: 70.0.w, height: 10.0.h,),
    buttons: [
      DialogButton(
        child: Text(
          Translations.of(context)!.Ok,
          style: Style.MainText18Bold,
        ),
        onPressed: () {
          if(id==0) {
            Navigator.pop(context);
          }
          else {
            try {
              StoreRedirect.redirect(androidAppId: "com.raitotec.transportation",
                  iOSAppId: "6566010998");
            }
            catch (e) {
              print(e);
            }
          }

        },
        color: Colors.black12,
       // padding:  EdgeInsets.fromLTRB(30.0.w,0, 30.0.w, 0),
        height: 5.0.h,
       // width: 70.0.w,
      ),
    ],
   style: AlertStyle(overlayColor:  Colors.black54,
     titleStyle:  Style.MainText16Bold,
     descStyle:  Style.MainText16Bold,
   )
  ).show();
}





