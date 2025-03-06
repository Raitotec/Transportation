class PaymentMethodsData {
  int? id;
  String? name;

  @override
  String toString() {
    if(name != null && name!.isNotEmpty)
      return name!;
    else
      return"";// Return the property you want to display
  }

  PaymentMethodsData({this.id, this.name});

  PaymentMethodsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}