
import 'package:flutter/material.dart';
import 'package:transportation/Models/OrderModel.dart';
import 'package:transportation/View/MainHomePage.dart';
import 'package:transportation/View/ShowExpensesPage.dart';
import 'package:transportation/View/showOrderPage.dart';
import '../../Shared_Data/CompanyData.dart';
import '../../Shared_Data/DelegateData.dart';
import '../../View/NotFoundPage.dart';
import '../../View/Splash_page.dart';
import '../../View/homePage.dart';
import '../../View/loginPage.dart';
import '../../View/startPage.dart';
import 'route_constants.dart';


class CustomRouter {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case Login_Route:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case Show_Order_Route:
        {
          final args= settings.arguments as OrderModel;
          return MaterialPageRoute(builder: (_) => ShowOrderPage(data: args));
        }
      case Show_Expenses_Route:
        {
          final args= settings.arguments as OrderModel;
          return MaterialPageRoute(builder: (_) => ShowExpensesPage(data: args));
        }
      case Splash_Route:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case MainRoute:
        return MaterialPageRoute(builder: (_) => MainHomeScreen(currentIndex: 0,));
      case startRoute:
        {
          if (CompanyData.companyData != null&& CompanyData.companyData!.baseUrl != null &&
        DelegateData.delegateData !=null&& DelegateData.delegateData!.name !=null) {
              return MaterialPageRoute(builder: (_) => HomePage());
            }
            else {
              return  MaterialPageRoute(builder: (_) => startPage());
            }
        }
      default:
        return MaterialPageRoute(builder: (_) => NotFoundPage());
    }
  }
}
