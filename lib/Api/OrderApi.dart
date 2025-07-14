
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:transportation/Constants/Localization/LanguageData.dart';
import 'package:transportation/Constants/Localization/Translations.dart';
import '../Constants/NetworkCheckData.dart';
import '../Models/OrderModel.dart';
import '../Shared_View/AlertView.dart';
import 'Api_Services.dart';
import 'Base_Url.dart';

Future< RequestsData?> GetRequetFun(BuildContext context) async {
  try {
    bool InternetConntected = await hasNetwork();
    if (InternetConntected) {
      try {
        final dataa = {
          "lang": LanguageData.languageData,
        };
        Map<String, String> data = new Map<String, String>.from(dataa);
        print(dataa);
        print(data);


        final response = await Get_Data(schedule, data);
        print(response.body);
        if (response.statusCode == 200) {
          Map valueMap = jsonDecode(response.body);
          if (valueMap['code'] == 200) {
            print(
                " fn_GetOptionsFun200 ::: ${valueMap['message']} ${valueMap['data']}");
            RequestsData obj = new RequestsData();

            obj = new RequestsData.fromJson(valueMap['data']);
            // await saveOptionData(obj);
            return obj;
          }
          else {
            if (valueMap['error'] != null) {
              await AlertView(
                  context, "error", Translations.of(context)!.ErrorTitle,
                  valueMap['error'].toString());
            }

            else {
              await AlertView(
                  context, "error", Translations.of(context)!.ErrorTitle,
                  valueMap['message'].toString());
            }
            print(
                "fn_GetOptionsFun400 ::: ${valueMap['message']} ${valueMap['data']}");
            return null;
          }
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
