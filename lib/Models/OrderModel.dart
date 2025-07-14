
import 'package:intl/intl.dart';

import '../Shared_Data/formatDateTime.dart';

class OrderModel {
  int? id;
  int? order_type_id;//0 current , 1 later, 2 end
  String? name;
  double? value;
  String?hex;
  double? precentage;
  String? date;
  String? time;
  double? mapLatitude_load;
  double? mapLongitude_load;
  double? mapLatitude_delivery;
  double? mapLongitude_delivery;
  String? img_load;


  OrderModel({this.id, this.name, this.value,this.hex,this.precentage,
  this.date,this.time,this.mapLatitude_delivery,this.mapLongitude_delivery,
    this.mapLatitude_load,this.mapLongitude_load,this.img_load,this.order_type_id});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    try {
      value = json['value'] != null ? double.tryParse( json['value'].toString() ): 0;
    }
    catch (e) {}
    hex= json['value'];
  }

}

class RequestsData {
  List<Requests>? scheduledRequests;
  List<Requests>? pastRequests;
  List<Requests>? currentRequests;

  RequestsData({this.scheduledRequests, this.pastRequests, this.currentRequests});

  RequestsData.fromJson(Map<String, dynamic> json) {
    if (json['scheduled_requests'] != null) {
      scheduledRequests = <Requests>[];
      json['scheduled_requests'].forEach((v) { scheduledRequests!.add(new Requests.fromJson(v)); });
    }
    if (json['past_requests'] != null) {
      pastRequests = <Requests>[];
      json['past_requests'].forEach((v) { pastRequests!.add(new Requests.fromJson(v)); });
    }
    if (json['current_requests'] != null) {
      currentRequests = <Requests>[];
      json['current_requests'].forEach((v) { currentRequests!.add(new Requests.fromJson(v)); });
    }
  }

}

class Requests {
  int? id;
  String? requestNumber;
  String? requestDateTime;
  String? deliveryDateTime;
  String? fuelType;
  LoadingSite? loadingSite;
  ClientStation? clientStation;
  int? isClosed;
  List<String>? loadingRequestAttachments;// اذن التحميل
  List<String>? supplierLoadingRequestAttachments;// ارامكو
  List<String>? loadingPermissionAttachments;//اذن التسليم
  String? formattedDate;
  String? formattedTime;
  int? order_type_id;//0 current , 1 later, 2 end
  Requests({this.id, this.requestNumber, this.requestDateTime, this.deliveryDateTime, this.fuelType, this.loadingSite, this.clientStation, this.isClosed, this.loadingRequestAttachments, this.supplierLoadingRequestAttachments, this.loadingPermissionAttachments});

  Requests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestNumber = json['request_number'];
    requestDateTime = json['request_dateTime']??"";
    try {
      formattedDate =getFormatDate(DateTime.parse(requestDateTime!));
    }
    catch(e)
    {
      formattedDate="";
    } try {
      formattedTime = getFormatTimeDateTime(DateTime.parse(requestDateTime!));
    }
    catch(e)
    {
      formattedTime="";
    }
    deliveryDateTime = json['delivery_dateTime'];
    fuelType = json['fuel_type'];
    loadingSite = json['loadingSite'] != null ? new LoadingSite.fromJson(json['loadingSite']) : null;
    clientStation = json['clientStation'] != null ? new ClientStation.fromJson(json['clientStation']) : null;
    isClosed = json['is_closed'];
    if (json['loadingRequestAttachments'] != null) {
      loadingRequestAttachments = json['loadingRequestAttachments'].cast<String>();
    }
    if (json['supplierLoadingRequestAttachments'] != null) {
      supplierLoadingRequestAttachments  =json['supplierLoadingRequestAttachments'].cast<String>();}
    if (json['loadingPermissionAttachments'] != null) {
      loadingPermissionAttachments = json['loadingPermissionAttachments'].cast<String>();
    }
  }

}

class LoadingSite {
  int? id;
  String? name;
  String? websiteLink;
  String? longitude;
  String? latitude;
  int? regionId;
  int? cityId;
  int? branchId;
  int? supplierId;
  String? createdAt;
  String? updatedAt;

  LoadingSite({this.id, this.name, this.websiteLink, this.longitude, this.latitude, this.regionId, this.cityId, this.branchId, this.supplierId, this.createdAt, this.updatedAt});

  LoadingSite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    websiteLink = json['website_link'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    regionId = json['region_id'];
    cityId = json['city_id'];
    branchId = json['branch_id'];
    supplierId = json['supplier_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['website_link'] = this.websiteLink;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['region_id'] = this.regionId;
    data['city_id'] = this.cityId;
    data['branch_id'] = this.branchId;
    data['supplier_id'] = this.supplierId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ClientStation {
  int? id;
  String? name;
  String? websiteLink;
  String? longitude;
  String? latitude;
  int? regionId;
  int? cityId;
  int? branchId;
  int? clientId;
  String? createdAt;
  String? updatedAt;

  ClientStation({this.id, this.name, this.websiteLink, this.longitude, this.latitude, this.regionId, this.cityId, this.branchId, this.clientId, this.createdAt, this.updatedAt});

  ClientStation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    websiteLink = json['website_link'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    regionId = json['region_id'];
    cityId = json['city_id'];
    branchId = json['branch_id'];
    clientId = json['client_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['website_link'] = this.websiteLink;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['region_id'] = this.regionId;
    data['city_id'] = this.cityId;
    data['branch_id'] = this.branchId;
    data['client_id'] = this.clientId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Attachments {
  int? id;
  String? name;


  Attachments.fromJson(Map<String, dynamic> json) {
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}