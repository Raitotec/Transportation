

import 'package:shared_preferences/shared_preferences.dart';
import '../Models/DelegateDataModel.dart';

class DelegateData {
  static DelegateDataModel? delegateData= null;
}
class DelegateStatusData {
  static bool? delegateStatusData= null;
}
saveDelegateData(DelegateDataModel obj)async
{
  try {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("delegateId", obj.delegateId!);
    prefs.setString("delegate_name", obj.name!);
    prefs.setString("delegate_branchId", obj.branchId!);
    prefs.setString("delegate_storeId", obj.storeId!);
    prefs.setString("delegate_token", obj.token!);
    prefs.setString("delegate_cityName", obj.cityName!);
    prefs.setString("delegate_imageUrl", obj.imageUrl!);
    prefs.setString("default_customer",
        obj.default_customer == null ? "" : obj.default_customer!);
    DelegateData.delegateData = obj;
    print(DelegateData.delegateData!.name!);
    print(DelegateData.delegateData!.delegateId!);
    print("saveDelegateData");
    print(DelegateData.delegateData!.default_customer!);
  }
  catch(e)

  {

  }
}

Future<DelegateDataModel?> getDelegateData()async
{
  try {
    final prefs = await SharedPreferences.getInstance();
    var delegateId = prefs.getInt('delegateId') ?? 0;
    var delegate_name = prefs.getString('delegate_name') ?? null;
    var delegate_branchId = prefs.getString('delegate_branchId') ?? null;
    var delegate_storeId = prefs.getString('delegate_storeId') ?? null;
    var delegate_token = prefs.getString('delegate_token') ?? null;
    var default_customer = prefs.getString('default_customer') ?? null;
    var delegate_cityName = prefs.getString('delegate_cityName') ?? "";
    var delegate_imageUrl = prefs.getString('delegate_imageUrl') ?? "";
    DelegateDataModel obj = new DelegateDataModel(
        delegateId, delegate_name, delegate_branchId, delegate_storeId,
        delegate_token, default_customer,delegate_cityName,delegate_imageUrl);
    DelegateData.delegateData = obj;
    print(DelegateData.delegateData!.name);
    print(DelegateData.delegateData!.delegateId);
    return obj;
  }
  catch(e)
  {
    print("Exception"+"getDelgateDate");
    return null;
  }
}

removeDelgateDate()async
{
  try {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('delegateId');
    prefs.remove('delegate_name');
    prefs.remove('delegate_branchId');
    prefs.remove('delegate_storeId');
    prefs.remove('delegate_token');
    prefs.remove('default_customer');
    prefs.remove('delegate_cityName');
    prefs.remove('delegate_imageUrl');
    DelegateData.delegateData = null;
  }
  catch(e)
  {
    print("Exception"+"removeDelgateDate");
    return null;
  }
}
