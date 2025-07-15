

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:transportation/Constants/Localization/LanguageData.dart';
import 'package:transportation/Shared_View/AppBarView.dart';
import 'package:transportation/View/homePage.dart';

import '../Constants/Style.dart';
import '../Shared_View/DrawerView.dart';
import 'ExpensesPage.dart';

class MainHomeScreen extends StatefulWidget {
  MainHomeScreen({Key? key,  required this.currentIndex}) : super(key: key);
  int currentIndex =0;


  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
   var navigation = <NavigationDestination>[
    NavigationDestination(
      selectedIcon: Icon(
        Icons.home,
        color: Style.SecondryColor,
      ),
      icon:  Icon(
        Icons.home_outlined,
        color: Colors.white,
      ),
      label:LanguageData.languageData=="ar"?"الطلبات" :LanguageData.languageData=="en"?'Orders':"آرڈرز",
    ),
    NavigationDestination(
      selectedIcon: Icon(
        Icons.account_balance_wallet,
        color: Style.SecondryColor,
      ),
      icon: Icon(
        Icons.account_balance_wallet_outlined,
        color: Colors.white,
      ),
      label: LanguageData.languageData=="ar"?"المصروفات" :LanguageData.languageData=="en"?'Expenses':"اخراجات"
    ),
  ];

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final page = [
     HomePage(),
    ExpensesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBarWithlanguage(context, navigation[widget.currentIndex].label),
      drawer: DrawerList(context),
      body:  IndexedStack(
      index: widget.currentIndex,
      children: page,
    ),
      bottomNavigationBar:
    CurvedNavigationBar(
        height:7.0.h,
        key: _bottomNavigationKey,
        index: widget.currentIndex,
        items: <Widget>[ Icon(
         widget.currentIndex==0? Icons.home: Icons.home_outlined,
          color: widget.currentIndex==0?Style.WhiteColor: Style.SecondryColor,
        ),
          Icon(
            widget.currentIndex==1? Icons.account_balance_wallet: Icons.account_balance_wallet_outlined,
            color: widget.currentIndex==1?Style.WhiteColor: Style.SecondryColor,
          ),
        ],
        color: Style.WhiteColor,
        buttonBackgroundColor:Style.SecondryColor ,
        backgroundColor: Style.SecondryColor.withOpacity(0.1),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            widget.currentIndex = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}