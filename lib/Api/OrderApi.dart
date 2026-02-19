
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:transportation/Constants/Localization/LanguageData.dart';
import 'package:transportation/Constants/Localization/Translations.dart';
import '../Constants/NetworkCheckData.dart';
import '../Models/OrderModel.dart';
import '../Shared_Data/CompanyData.dart';
import '../Shared_Data/DelegateData.dart';
import '../Shared_View/AlertView.dart';
import 'Api_Services.dart';
import 'Base_Url.dart';
import 'package:http/http.dart'as http;

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

Future< RequestsData?> GetRequet_Fun() async {
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
          return null;
        }
        return null;
      }
      catch (e) {
        return null;
      }
    }
    else {
      return null;
    }
  }
  catch (e) {
    return null;
  }
}


Future<Requests?> addRequetFun(BuildContext context,String id , List<String>? supplierLoadingRequestAttachments, List<String>? loadingPermission_attachments) async {
  try {
    bool InternetConntected = await hasNetwork();
    if (InternetConntected) {
      try {
        var base_url_data = CompanyData.companyData!.baseUrl;
        var UriData = Uri.parse(base_url_data! + saveRequest);
        var token = DelegateData.delegateData!.authorisation!.token!;
        Map<String, String> headers = {
          "Accept": "application/json",
          "Authorization": "Bearer " + token!
        };
        http.MultipartRequest request = new http.MultipartRequest(
            "POST", UriData);
        request.headers.addAll(headers);
        request.fields['id'] = id;
        if (supplierLoadingRequestAttachments != null &&
            supplierLoadingRequestAttachments.isNotEmpty) {
          for (int i = 0; i < supplierLoadingRequestAttachments.length; i++) {
            request.files.add(
                await http.MultipartFile.fromPath(
                    'supplier_loadingRequest_attachments[$i]',
                    supplierLoadingRequestAttachments[i]));
          }
        }
        if (loadingPermission_attachments != null &&
            loadingPermission_attachments.isNotEmpty) {
          for (int i = 0; i < loadingPermission_attachments.length; i++) {
            request.files.add(
                await http.MultipartFile.fromPath(
                    'loadingPermission_attachments[$i]',
                    loadingPermission_attachments[i]));
          }
        }
        var response = await request.send();
        final res = await http.Response.fromStream(response);
        if (response.statusCode == 200) {
          Map valueMap = jsonDecode(res.body);
          if (valueMap['code'] == 200) {
            print(
                " fn_addRequet200 ::: ${valueMap['message']} ${valueMap['data']}");
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

Future<Requests?> endRequetFun(BuildContext context,String id ,
    List<String>? supplierLoadingRequestAttachments,
    List<String>? loadingPermission_attachments,
    String actual_quantity) async {
  try {
    bool InternetConntected = await hasNetwork();
    if (InternetConntected) {
      try {
        var base_url_data = CompanyData.companyData!.baseUrl;
        var UriData = Uri.parse(base_url_data! + endRequest);
        print(UriData);
        var token = DelegateData.delegateData!.authorisation!.token!;
        Map<String, String> headers = {
          "Accept": "application/json",
          "Authorization": "Bearer " + token!
        };
        http.MultipartRequest request = new http.MultipartRequest(
            "POST", UriData);
        request.headers.addAll(headers);
        request.fields['id'] = id;
        request.fields['actual_quantity'] = actual_quantity;
        if (supplierLoadingRequestAttachments != null &&
            supplierLoadingRequestAttachments.isNotEmpty) {
          for (int i = 0; i < supplierLoadingRequestAttachments.length; i++) {
            request.files.add(
                await http.MultipartFile.fromPath(
                    'supplier_loadingRequest_attachments[$i]',
                    supplierLoadingRequestAttachments[i]));
          }
        }
        if (loadingPermission_attachments != null &&
            loadingPermission_attachments.isNotEmpty) {
          for (int i = 0; i < loadingPermission_attachments.length; i++) {
            request.files.add(
                await http.MultipartFile.fromPath(
                    'loadingPermission_attachments[$i]',
                    loadingPermission_attachments[i]));
          }
        }
        var response = await request.send();
        final res = await http.Response.fromStream(response);
        if (response.statusCode == 200) {
          Map valueMap = jsonDecode(res.body);
          if (valueMap['code'] == 200) {
            print(
                " fn_enRequet200 ::: ${valueMap['message']} ${valueMap['data']}");
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
