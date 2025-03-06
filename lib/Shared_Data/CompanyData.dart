

import 'package:shared_preferences/shared_preferences.dart';

import '../Models/CompanyModel.dart';

class CompanyData {
  static CompanyModel? companyData= null;
}

saveCompanyData(CompanyModel obj)async
{
  try {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("Company_id", obj.id!);
    prefs.setString("Company_name", obj.name!);
    prefs.setString("Company_name_en", obj.nameEn!);
    prefs.setString("Company_logo", obj.logo!);
    prefs.setString("Company_base_url", obj.baseUrl!);
    prefs.setString("Company_petroStation", obj.petroStation!);
    prefs.setString("Company_market", obj.market!);
    prefs.setInt("Company_pumbs_no", obj.pumbs_no!);
    prefs.setInt("Company_nozzles_no", obj.nozzles_no!);
    prefs.setInt("Company_bills_no", obj.bills_no!);
    prefs.setString("Company_taxNumber", obj.taxNumber!);
    prefs.setString("Company_address", obj.address!);
    prefs.setDouble("Company_tax", obj.tax!);
    CompanyData.companyData = obj;
    //print(CompanyData.companyData!.logo!);
  }
  catch(e)
  {
    print("****saveCompanyData"+e.toString());
  }
}

Future<CompanyModel?> getCompanyData()async
{
  try {
    final prefs = await SharedPreferences.getInstance();
    var Company_id = prefs.getInt('Company_id') ?? 0;
    var Company_name = prefs.getString('Company_name') ?? null;
    var Company_name_en = prefs.getString('Company_name_en') ?? null;
    var Company_logo = prefs.getString('Company_logo') ?? null;
    // var Company_logo = "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80";
    var Company_base_url = prefs.getString('Company_base_url') ?? null;
    var Company_petroStation = prefs.getString('Company_petroStation') ?? null;
    var Company_market = prefs.getString('Company_market') ?? null;
    // var Company_base_url = "http://raitotec.net/demo/delegates/api/";
    var Company_pumbs_no = prefs.getInt('Company_pumbs_no') ?? 0;
    var Company_nozzles_no = prefs.getInt('Company_nozzles_no') ?? 0;
    var Company_bills_no = prefs.getInt('Company_bills_no') ?? 0;
    var Company_taxNumber = prefs.getString('Company_taxNumber') ?? null;
    var Company_address = prefs.getString('Company_address') ?? null;
    var Company_tax = prefs.getDouble('Company_tax') ?? 0;

    CompanyModel obj = new CompanyModel(id: Company_id,
        name: Company_name,
        nameEn: Company_name_en,
        baseUrl: Company_base_url,
        logo: Company_logo,
        petroStation: Company_petroStation,
        market: Company_market,
        pumbs_no: Company_pumbs_no,
        nozzles_no: Company_nozzles_no,
        bills_no: Company_bills_no,
        tax: Company_tax,
        address: Company_address,
        taxNumber: Company_taxNumber);
    CompanyData.companyData = obj;
    return obj;
  }
  catch(e)
  {

      print("Exception"+"getCompanyDate");
    return null;
  }

}

removeCompanyDate()async
{
  try {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('Company_id');
    prefs.remove('Company_name');
    prefs.remove('Company_name_en');
    prefs.remove('Company_logo');
    prefs.remove('Company_base_url');
    prefs.remove('Company_petroStation');
    prefs.remove('Company_market');
    CompanyData.companyData = null;
  }
  catch(e)
  {
    print("Exception"+"removeCompanyDate");
  }
}
