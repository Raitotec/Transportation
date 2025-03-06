
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