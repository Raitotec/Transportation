import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:transportation/Shared_Data/formatDateTime.dart';

import '../Constants/Localization/LanguageData.dart';
import '../Constants/Localization/Translations.dart';
import '../Constants/NetworkCheckData.dart';
import '../Models/OrderModel.dart';
import '../Models/PaymentMethodsData.dart';
import '../Shared_Data/CompanyData.dart';
import '../Shared_Data/DelegateData.dart';
import '../Shared_View/AlertView.dart';
import 'Api_Services.dart';
import 'Base_Url.dart';
import 'package:http/http.dart'as http;

Future<Requests?> addExpensesFun(BuildContext context,String request_id , String amount,
    String expense_type_id,List<String> images) async {
  try {
    bool InternetConntected = await hasNetwork();
    if (InternetConntected) {
      try {
        var base_url_data = CompanyData.companyData!.baseUrl;
        var UriData = Uri.parse(base_url_data! + transportationExpenses);
        var token = DelegateData.delegateData!.authorisation!.token!;
        print(UriData);
        Map<String, String> headers = {
          "Accept": "application/json",
          "Authorization": "Bearer " + token!
        };
        http.MultipartRequest request = new http.MultipartRequest(
            "POST", UriData);
        request.headers.addAll(headers);
        request.fields['request_id'] = request_id;
        request.fields['date'] = getFormatDate(DateTime.now());
        request.fields['time'] = getFormatTimeDateTime(DateTime.now());
        request.fields['amount'] = amount;
        request.fields['expense_type_id'] = expense_type_id;
        if (images != null && images.isNotEmpty) {
          for (int i = 0; i < images.length; i++) {
            request.files.add(
                await http.MultipartFile.fromPath(
                    'attachment',
                    images[i]));
          }
        }
        print("******************");
        var response = await request.send();
        print(response.statusCode.toString());
        final res = await http.Response.fromStream(response);
        if (response.statusCode == 200) {
          Map valueMap = jsonDecode(res.body);
          print(res.body);
          if (valueMap['code'] == 200) {
            print(" fn_addRequet200 ::: ${valueMap['message']} ${valueMap['data']}");
            await AlertView(context, "success", Translations.of(context)!.Ok,
                Translations.of(context)!.success);
            Requests obj = new Requests();

            obj = new Requests.fromJson(valueMap['data']);
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
        else if (response.statusCode == 422) {
          Map valueMap = jsonDecode(res.body);
          print(res.body);
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

Future< List<PaymentMethodsData>?> GetExpenseTypesFun(BuildContext context) async {
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


        final response = await Get_Data(getExpenseTypes, data);
        print(response.body);
        if (response.statusCode == 200) {
          Map valueMap = jsonDecode(response.body);
          if (valueMap['code'] == 200) {
            print(
                " fn_GetOptionsFun200 ::: ${valueMap['message']} ${valueMap['data']}");
            List<PaymentMethodsData> obj=<PaymentMethodsData>[];
            if (valueMap['data'] != null) {
              valueMap['data'].forEach((v) {
                obj.add(new PaymentMethodsData.fromJson(v));
              });
            }
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
Future< List<PaymentMethodsData>?> GetExpenseTypes_Fun() async {
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


        final response = await Get_Data(getExpenseTypes, data);
        print(response.body);
        if (response.statusCode == 200) {
          Map valueMap = jsonDecode(response.body);
          if (valueMap['code'] == 200) {
            print(
                " fn_GetOptionsFun200 ::: ${valueMap['message']} ${valueMap['data']}");
            List<PaymentMethodsData> obj=<PaymentMethodsData>[];
            if (valueMap['data'] != null) {
              valueMap['data'].forEach((v) {
                obj.add(new PaymentMethodsData.fromJson(v));
              });
            }
            return obj;
          }
          else {
            print(
                "fn_GetOptionsFun400 ::: ${valueMap['message']} ${valueMap['data']}");
            return null;
          }
        }
        else if (response.statusCode == 422) {
          Map valueMap = jsonDecode(response.body);

          return null;
        }
        else {

          print("fn_GetOptionsFun_statusCode400 ::: ${response.statusCode} ");
          return null;
        }
      }
      catch (e) {

        print("fn_GetOptionsFun_Exception ::: ${e} ");
        return null;
      }
    }
    else {
      print("fn_GetOptionsFun_Exception ::: checkInternet ");
      return null;
    }
  }
  catch (e) {
    print("fn_GetOptionsFun_Exception ::: ${e} ");
    return null;
  }
}