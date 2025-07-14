

import 'package:http/http.dart' as http;
import 'package:transportation/Models/CompanyModel.dart';
import 'package:transportation/Shared_Data/CompanyData.dart';
import 'package:transportation/Shared_Data/DelegateData.dart';
import 'Base_Url.dart';

Future<http.Response> Post_Data(String api_url, data) {
  var UriData= Uri.parse(CompanyData.companyData!.baseUrl! + api_url);
  var token = DelegateData.delegateData!.authorisation!.token!;
  print(UriData);
  print(token);
  print(data);
    return http.post(
        UriData,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: data
    );
}

Future<http.Response> Get_Data(String api_url, data) {

  var UriData= Uri.parse(CompanyData.companyData!.baseUrl! + api_url);
  var token = DelegateData.delegateData!.authorisation!.token!;
  final newURI = UriData.replace(queryParameters: data);
  print(newURI);
  print(token);
  print(data);
    return http.get(
      newURI,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
}


Future<http.Response> Get_Data_No_Token(String api_url, data) {
  var UriData= Uri.parse(CompanyData.companyData!.baseUrl! + api_url);

  final newURI = UriData.replace(queryParameters: data);
  print(newURI);
  return http.get(
    newURI,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}