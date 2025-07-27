import 'package:shared_preferences/shared_preferences.dart';
import 'package:transportation/Constants/Localization/LanguageData.dart';

class UserNotifactionData {
  static UserNotifaction? userNotifactionData= null;
}

class UserNotifaction{
  String? name;
  String? type;
  String? userId;
  String? app_id;
  String? channel_name;
  String? token;
  String? img;
  String? title;
  String? body;


  UserNotifaction({this.name, this.type,this.userId,this.app_id,this.channel_name,this.token
    ,this.img,
    this.title,
    this.body});

  UserNotifaction.fromJson(Map<String, dynamic> json) {
    try {

      if(LanguageData.languageData=="ar")
        {
          title=json['title_ar']!= null? json['title_ar']:"";
          body=json['body_ar']!= null? json['body_ar']:"";
        }
      else
        {
          title=json['title']!= null? json['title']:"";
          body=json['body']!= null? json['body']:"";
        }
    }
    catch(e)
    {
      print("**********"+e.toString());
    }
  }

}

saveUserNotifactionData(UserNotifaction obj)async
{
  try {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("UserNotifaction_name", obj.name!);
    prefs.setString("UserNotifaction_userId", obj.userId!);
    prefs.setString("UserNotifaction_type", obj.type!);
    prefs.setString("UserNotifaction_token", obj.token!);
    prefs.setString("UserNotifaction_channel_name", obj.channel_name!);
    prefs.setString("UserNotifaction_app_id", obj.app_id!);
    prefs.setString("UserNotifaction_img", obj.img!);
    UserNotifactionData.userNotifactionData = obj;
    print("*******saveUserNotifactionData");
    print("*******"+UserNotifactionData.userNotifactionData!.type!);
  }
  catch(e)
  {

  }
}

Future<UserNotifaction> getUserNotifactionData()async
{
  final prefs = await SharedPreferences.getInstance();
  var name = prefs.getString('UserNotifaction_name') ?? null;
  var userId = prefs.getString('UserNotifaction_userId') ?? null;
  var type = prefs.getString('UserNotifaction_type') ?? null;
  var token = prefs.getString('UserNotifaction_token') ?? null;
  var channel_name = prefs.getString('UserNotifaction_channel_name') ?? null;
  var app_id = prefs.getString('UserNotifaction_app_id') ?? null;
  var img = prefs.getString('UserNotifaction_img') ?? null;
  UserNotifaction obj = new UserNotifaction(name: name,type: type,userId: userId,
      token: token,channel_name: channel_name,app_id:app_id,img: img);
  UserNotifactionData.userNotifactionData= obj;
  return obj;
}

removeUserNotifactionDate()async
{
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('UserNotifaction_name');
  prefs.remove('UserNotifaction_userId');
  prefs.remove('UserNotifaction_type');
  prefs.remove('UserNotifaction_token');
  prefs.remove('UserNotifaction_channel_name');
  prefs.remove('UserNotifaction_app_id');
  prefs.remove('UserNotifaction_img');
  UserNotifactionData.userNotifactionData=null;
}