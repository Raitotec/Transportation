import 'dart:convert';

import 'package:flutter/material.dart';

import '../Api/Api_Services.dart';
import '../Constants/NetworkCheckData.dart';

Future<bool> ForFirebaseNotifyFun(BuildContext context,String employee_id , String token) async {
  try {
    bool InternetConntected = await hasNetwork();
    if (InternetConntected) {
      try {

        var data = jsonEncode(<String, String>{
          'firebase_token': token,
          //"lang": lang.languageCode,
        });


        final response =await Post_Data("updateToken",data);

        print(response.body);
        if (response.statusCode == 200) {
          Map valueMap = jsonDecode(response.body);
          if (valueMap['code'] == 200) {
            print( "ForFirebaseNotifyFun200 ::: ${valueMap['message']} ${valueMap['data']}");
            return true;
          }
          else {
            print( "ForFirebaseNotifyFun400 ::: ${valueMap['message']} ${valueMap['data']}");
            return false;
          }
        }
        else {
          print( "ForFirebaseNotifyFun400 ::: ${response.statusCode} ");
          return false;
        }
      }
      catch(e)
      {
        print( "ForFirebaseNotifyFunException ::: ${e} ");
        return false;
      }
    }
    else {
      print("ForFirebaseNotifyFunException ::: checkInternet ");
      return false;
    }
  }
  catch (e) {
    print("ForFirebaseNotifyFunException ::: ${e} ");
    return false;
  }
}
