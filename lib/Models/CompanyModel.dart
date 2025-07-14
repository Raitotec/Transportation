
class CompanyModel {
  int? id;
  String? name;
  String? nameEn;
  String? logo;
  String? baseUrl;
  String? petroStation;
  String? market;
  int? pumbs_no;
  int? nozzles_no;
  int? bills_no;
  double? tax;
  String? address;
  String? taxNumber;



  CompanyModel({this.id, this.name, this.nameEn, this.logo, this.baseUrl, this.petroStation,this.market,this.pumbs_no,this.nozzles_no,
  this.bills_no, this.tax, this.address,this.taxNumber});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    logo=json['logo'];
    baseUrl = json['maintenance_base_url'];


    try {
      tax = json['tax'] != null ? json['tax'] : 0;
      taxNumber = json['taxNumber'] != null ? json['taxNumber'] : "";
      address = json['address'] != null ? json['address'] : "";
    }
    catch (e) {}
    //   market="0";
  //  petroStation="1";
    //logo = "https://thumbs.dreamstime.com/b/environment-earth-day-hands-trees-growing-seedlings-bokeh-green-background-female-hand-holding-tree-nature-field-gra-130247647.jpg";

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    data['logo'] = this.logo;
    data['base_url'] = this.baseUrl;
    return data;
  }
}