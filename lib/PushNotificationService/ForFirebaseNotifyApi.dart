import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:transportation/Constants/Localization/Translations.dart';
import 'package:transportation/PushNotificationService/NotificationModel.dart';

import '../Api/Api_Services.dart';
import '../Constants/Localization/LanguageData.dart';
import '../Constants/NetworkCheckData.dart';
import '../Shared_View/AlertView.dart';

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

Future<List<NotificationModel>?> GetNotifications(BuildContext context) async {
  try {
    bool InternetConntected = await hasNetwork();
    if (InternetConntected) {
      try {

        final dataa = {
          "lang": LanguageData.languageData,
        };
        Map<String, String> data = new Map<String, String>.from(dataa);


        final response = await Get_Data("getNotification", data);
        print(response.body);
        if (response.statusCode == 200) {
          Map valueMap = jsonDecode(response.body);
          if (valueMap['code'] == 200) {
            print(" fn_NotificationModel200 ::: ${valueMap['message']} ${valueMap['data']}");
            if (valueMap['data'] != null) {
              List<NotificationModel> obj = <NotificationModel>[];
              valueMap['data']['unread_notifications'].forEach((v) {
                obj.add(new NotificationModel.fromJson(v));
              });
              return obj;
            }
            else
              return null;
          }
          else {
            if (valueMap['error'] != null)
              await AlertView(
                  context, "error", Translations.of(context)!.ErrorTitle,
                  valueMap['error'].toString());
            else
              await AlertView(
                  context, "error", Translations.of(context)!.ErrorTitle,
                  valueMap['message'].toString());
            print(
                "fn_getNotificationModel400 ::: ${valueMap['message']} ${valueMap['data']}");
            return null;
          }
        }
        else if (response.statusCode == 422) {
          Map valueMap = jsonDecode(response.body);
          await AlertView(
              context, "error", Translations.of(context)!.ErrorTitle,
              valueMap['message'].toString());
          return null;
        }
        else {
          await AlertView(
              context, "error", Translations.of(context)!.ErrorTitle,
              "error_statusCode ${response.statusCode} ${response
                  .reasonPhrase} ");
          print("fn_GetOptionsFun_statusCode400 ::: ${response.statusCode} ");
          return null;
        }
      }
      catch (e) {
        await AlertView(context, "error", Translations.of(context)!.ErrorTitle,
            "Exception : ${e.toString()}");
        print("fn_GetOptionsFun_Exception ::: ${e} ");
        return null;
      }
    }
    else {
      await AlertView(context, "error", Translations.of(context)!.ErrorTitle,
          Translations.of(context)!.CheckInternet);
      print("fn_GetOptionsFun_Exception ::: checkInternet ");
      return null;
    }
  }
  catch (e) {
    await AlertView(context, "error", Translations.of(context)!.ErrorTitle,
        "Exception : ${e.toString()}");
    print("fn_GetOptionsFun_Exception ::: ${e} ");
    return null;
  }
}
