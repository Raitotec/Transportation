
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Constants/Localization/Translations.dart';
import '../Constants/Routes/route_constants.dart';

import '../Api/LoginApi.dart';
import '../Shared_View/AlertView.dart';

class LoginViewModel extends ChangeNotifier {
  LoginApi loginApi= LoginApi();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _checkVersion = false;

  bool get isLoading => _isLoading;
  bool get checkVersion => _checkVersion;
  TextEditingController get companyController => _companyController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  Future<void> Login(BuildContext context) async {
    try {
      if(_emailController.text == null || _emailController.text.isEmpty)
        {
          AlertView(context, "warning",  Translations.of(context)!.Please,
              Translations.of(context)!.Email_Validation);
          return;
        }
      if(_passwordController.text == null || _passwordController.text.isEmpty)
      {
        AlertView(context, "warning",  Translations.of(context)!.Please,
            Translations.of(context)!.Password_Validation);
        return;
      }
       /*_isLoading = true;
        notifyListeners();
        var res = await loginApi.Login(context, _emailController.text,_passwordController.text);
        _isLoading = false;
        notifyListeners();
        if (res != null) {*/
          Navigator.pushNamedAndRemoveUntil(context, MainRoute,(Route<dynamic> r)=>false);
        //}
    }
    catch(e)
    {
      AlertView(context, "error",  Translations.of(context)!.ErrorTitle,
          Translations.of(context)!.ErrorDes+"  "+e.toString());
    }
  }

  Future<void> startLogin(BuildContext context) async {
    try {
      if (_companyController.text != null && _companyController.text.isNotEmpty) {
       /* _isLoading = true;
        notifyListeners();
        var res = await loginApi.StartToLogin(context, _companyController.text);
        _isLoading = false;
        notifyListeners();
        if (res != null) {
          if (_checkVersion) {
            await AlertView(
                context, "error",
                Translations.of(context)!.Please,
                Translations.of(context)!.LastVersion,
                id: 1);
          }
          else {*/
              Navigator.pushNamed(context, Login_Route);
        //  }
       // }
      }
      else {

        AlertView(context, "warning",  Translations.of(context)!.Please,
          Translations.of(context)!.CompanyNumber_Validation);
      }
    }
    catch(e)
    {
      AlertView(context, "error",  Translations.of(context)!.ErrorTitle,
          Translations.of(context)!.ErrorDes+"  "+e.toString());
    }
  }

  Future<void> checkVersionFun(BuildContext context)
  async {
    try {
     // _isLoading=true;
     // notifyListeners();
      /*
      final _checker = AppVersionChecker();
      var value= await _checker.checkUpdate();
      print(value.canUpdate); //return true if update is available
      print(value.currentVersion); //return current app version
      print(value.newVersion); //return the new app version
      print(value.appURL); //return the app url
      print(value.errorMessage); //return error message if found else it will return null
      if(value.canUpdate)
      {
        await AlertView(
            context, "error", Translations.of(context)!.Please,
            Translations.of(context)!.LastVersion + "(" + value.currentVersion +
                " - " + value!.newVersion!+ ")",id: 1);
        _isLoading=false;
        _checkVersion=true;
        notifyListeners();
      }
      else
      {
        _isLoading=false;
        _checkVersion=false;
        notifyListeners();
      }*/
    }
    catch (e) {
      await AlertView(context, "error", Translations.of(context)!.ErrorTitle,
          "Exception : ${e.toString()}");
      _isLoading=false;
      _checkVersion=false;
      notifyListeners();
    }
  }
}