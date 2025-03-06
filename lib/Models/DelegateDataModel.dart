
import 'package:shared_preferences/shared_preferences.dart';

class DelegateDataModel {
  int? delegateId;
  String? name;
  String? password;
  String? email;
  String? imageUrl;
  String? phone;
  String? branchId;
  String? token;
  String? storeId;
  String? default_customer;
  String? cityName;

  DelegateDataModel.fromJson(Map<String, dynamic> json) {
    delegateId = json['delegateId'];
    name = json['name']!=null ?json['name']:"";
    password = json['password']!=null ?json['password']:"";
    email = json['email']!=null ?json['email']:"";
    imageUrl = json['imageUrl']!=null ?json['imageUrl']:"";
    phone = json['phone']!=null ?json['phone']:"";
    branchId = json['branchId']!=null ?json['branchId']:"";
    token = json['token']!=null ?json['token']:"";
    storeId = json['storeId']!=null ?json['storeId']:"";
    default_customer = json['default_customer']!=null ?json['default_customer']:"";
    cityName = json['cityName']!=null ?json['cityName']:"";
  }

  DelegateDataModel(this.delegateId, this.name, this.branchId, this.storeId, this.token,this.default_customer,this.cityName,this.imageUrl);
}


