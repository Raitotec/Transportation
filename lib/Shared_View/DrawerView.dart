
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sizer/sizer.dart';
import '../Constants/Localization/ScopeModelWrapper.dart';
import '../Constants/Localization/Translations.dart';
import '../Constants/Routes/route_constants.dart';
import '../Constants/Style.dart';
import '../Constants/assets/Images_Name.dart';
import '../Shared_Data/CompanyData.dart';
import '../Shared_Data/DelegateData.dart';

DrawerList(BuildContext context,{int id=0})
{
  return Container(
      width: 80.0.w,

      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Style.bgColor1,
              Style.bgColor2]),
        border: Border.all(color: Style.SecondryColor, width: 1.0),
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(5.0),
          topRight: const Radius.circular(5.0),
          bottomRight: const Radius.circular(5.0),
          bottomLeft: const Radius.circular(5.0),
        ),
      ),
      child: _drawerList(context, id));

}

Container _drawerList(BuildContext context, int id) {
  return Container(
    //decoration: Style.Glass2BoxDecoration,
    color: Colors.transparent,
    child: Column(

      // padding: EdgeInsets.zero,
      children: <Widget>[

          Container(
            height: 25.0.h,
            //rerdecoration: Style.BoxDecoration1,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 3.0.h,),
                  (DelegateData.delegateData!.imageUrl == null ||
                      DelegateData.delegateData!.imageUrl!.isEmpty) ?
                  Image(image: AssetImage(ImagesName.logo), width: 100.0.w, height: 12.0.h,) :
                  Center(child:
                  Container(
                    //  margin: EdgeInsets.symmetric(horizontal: 10.0.w),
                      padding: EdgeInsets.all(2), // Border width
                      decoration: BoxDecoration(
                        color: Colors.black12, shape: BoxShape.circle,
                      ),
                      child: Container(
                          padding: EdgeInsets.all(3), // Border width
                          decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                              child: SizedBox.fromSize(
                                  size: Size.fromRadius(6.0.h),
                                  // Image radius
                                  child:
                                  Image.network(DelegateData.delegateData!.imageUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, url, error) => Image(image: AssetImage(
                                        ImagesName.logo), width: 100.0.w, height: 12.0.h,),
                                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return CircularProgressIndicator(
                                        color: Style.WhiteColor,
                                      );
                                    },)))))),
                  SizedBox(height: 1.0.h,),
                  Center(
                    child: Text(
                      DelegateData.delegateData != null?  DelegateData.delegateData!.name != null ? DelegateData.delegateData!.name! : " النقليات" : "النقليات ",
                      style: TextStyle(color: Style.MainTextColor, fontSize: 18.0.sp, fontWeight: FontWeight.bold),
                    ),
                  ),

                ]
            ),
          ),
          Container(
            height: 0.5.h,
          decoration: BoxDecoration(  gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Style.SecondryColor,
                Style.MainColor]),
          )),
          Expanded(child:
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(1.0.h)),

                Drawer_Items(Icons.home_filled, Translations.of(context)!.Home,
                    context, MainRoute),
/*
                ScopedModelDescendant<AppModel>(
                  builder: (context, child, model) =>
                      ListTile(
                          leading: Icon(Icons.language,size: 3.0.h,color: Style.SecondryColor,),
                          title: Text(
                              Translations.of(context)!.Lang,
                              style: TextStyle(
                                  color: Style.MainTextColor, fontSize: 18.0.sp, fontWeight: FontWeight.bold)
                          ),
                          onTap: () async {
                            // Navigator.pop(context);
                            // Navigator.of(context,rootNavigator: true).pop();
                            await Future.delayed(Duration(milliseconds: 300));
                            model.changeDirection();
                            Navigator.pushNamedAndRemoveUntil(context, MainRoute, (Route<dynamic> route) => false);
                            //   Drawer_itemTab(context,"homeRoute");
                          }

                      ),
                ),
*/
                Drawer_Items(Icons.logout, Translations.of(context)!.logout,
                    context, "loginRoute"),
                Padding(padding: EdgeInsets.all(1.5.h)),
                //  Drawer_Items(Icons.add_chart, getTranslated(context, 'Statistics'), context, "StatisticsRoute"),
              ],
            ),
          ),),




      ],
    ),
  );
}

Drawer_Items(IconData icon,String name, BuildContext context, String route)
{
  return   ListTile(
      leading:  Icon(icon,size: 3.0.h,color: Style.SecondryColor,),
      title: Text(
          name,
          style: TextStyle(color: Style.MainTextColor, fontSize: 18.0.sp, fontWeight: FontWeight.bold)
      ),
      onTap: ()=>Drawer_itemTab(context,route)

  );

}



Drawer_itemTab( BuildContext context, String route)async
{
  // Navigator.pop(context);

  if (route == "loginRoute") {
    await removeDelgateDate();
    await removeCompanyDate();
    Navigator.pushNamedAndRemoveUntil(context, Splash_Route,(Route<dynamic> r)=>false);
  }
  else  {
    Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(
        context, route, (Route<dynamic> r) => false);
  }



}

