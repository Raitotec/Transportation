

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
    prefs.setInt("delegateId", obj.user!.id!);
    prefs.setString("delegate_name", obj.user!.name!);
    prefs.setString("delegate_token", obj.authorisation!.token!);
    prefs.setString("delegate_imageUrl", obj.user!.image!);
    DelegateData.delegateData = obj;
    print("saveDelegateData");
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
    var delegate_token = prefs.getString('delegate_token') ?? null;
    var delegate_imageUrl = prefs.getString('delegate_imageUrl') ?? "";
    DelegateDataModel obj = new DelegateDataModel(
      user: User(id: delegateId,name: delegate_name,image: delegate_imageUrl,),
    authorisation: Authorisation(token: delegate_token));
    DelegateData.delegateData = obj;
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
    prefs.remove('delegate_token');
    prefs.remove('delegate_imageUrl');
    DelegateData.delegateData = null;
  }
  catch(e)
  {
    print("Exception"+"removeDelgateDate");
    return null;
  }
}
