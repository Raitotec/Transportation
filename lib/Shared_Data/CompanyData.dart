

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


    CompanyModel obj = new CompanyModel(id: Company_id,
        name: Company_name,
        nameEn: Company_name_en,
        baseUrl: Company_base_url,
        logo: Company_logo,);
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
