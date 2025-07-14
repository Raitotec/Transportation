
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
    name = json['name']??"";
    nameEn = json['name_en']??"";
    logo=json['logo']??"";
    baseUrl = json['maintenance_base_url']??"";

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