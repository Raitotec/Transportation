
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:transportation/Constants/Localization/Translations.dart';

import '../Constants/Routes/route_constants.dart';
import '../Constants/Style.dart';
import '../Constants/assets/Images_Name.dart';
import '../Shared_Data/CompanyData.dart';
import '../Shared_Data/DelegateData.dart';


class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final newVersion = NewVersionPlus();
  @override
  void initState() {
    super.initState();
    GetData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0.w),
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: FormUI(context),
        ));
  }

  Widget FormUI(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
       Image.asset(ImagesName.logo,
            repeat: ImageRepeat.noRepeat,gaplessPlayback: false,),
        Text("النقليات",style: Style.MainText18Bold.copyWith(fontSize: 25.0.sp),)
    ]);
  }



  Future<void> advancedStatusCheck(NewVersionPlus newVersion) async {
    try {
      final status = await newVersion.getVersionStatus();
      if (status != null) {
        // debugPrint(status.releaseNotes);
        // debugPrint(status.appStoreLink);
        // debugPrint(status.localVersion);
        // debugPrint(status.storeVersion);
        // debugPrint(status.canUpdate.toString());
        if (status.canUpdate) {
          newVersion.showUpdateDialog(
            context: context,
            versionStatus: status,
            dialogTitle: Translations.of(context)!.please,
            dialogText: Translations.of(context)!.LastVersion + " (" +
                status.localVersion + " - " + status.storeVersion + " ) ",
            updateButtonText: Translations.of(context)!.okey,
            launchModeVersion: LaunchModeVersion.external,
            allowDismissal: false,
          );
        }
      }
    }
    catch(e)
    {
      print("advancedStatusCheck"+e.toString());
    }
  }

  Future<void> GetData() async {
    //5500
    try {

      var x = await getDelegateData();
      var xx = await getCompanyData();
      setState(() {
        CompanyData.companyData = xx;
        DelegateData.delegateData = x;
      });
      await advancedStatusCheck(newVersion);
      //4300
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushNamedAndRemoveUntil(context, startRoute,(Route<dynamic> r)=>false);
      });
    }
    catch(e)
    {
      print("Exception"+"GetDataSplash");
    }
  }

}