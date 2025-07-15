
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
          return MaterialPageRoute(builder: (_) => ShowOrderPage());
        }
      case Show_Expenses_Route:
        {
          return MaterialPageRoute(builder: (_) => ShowExpensesPage());
        }
      case Splash_Route:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case ExpensesRoute:
        return MaterialPageRoute(builder: (_) => MainHomeScreen(currentIndex: 1,));
      case MainRoute:
        return MaterialPageRoute(builder: (_) => MainHomeScreen(currentIndex: 0,));
      case startRoute:
        {
          if (CompanyData.companyData != null&& CompanyData.companyData!.baseUrl != null &&
        DelegateData.delegateData !=null&& DelegateData.delegateData!.user !=null
              && DelegateData.delegateData!.user!.name !=null) {
              return MaterialPageRoute(builder: (_) => MainHomeScreen(currentIndex: 0,));
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
