import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:transportation/PushNotificationService/NotifactionViewModel.dart';
import 'package:transportation/Shared_View/NoDataView.dart';

import '../Constants/Localization/Translations.dart';
import '../Constants/Style.dart';
import '../Shared_View/AppBarView.dart';
import '../Shared_View/DrawerView.dart';
import '../Shared_View/ProgressIndicatorButton.dart';
import 'NotificationModel.dart';


class NotificationsScreen extends StatefulWidget {
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>  with WidgetsBindingObserver{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NotifactionViewModel>(context, listen: false).refresh();
    });
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // التطبيق رجع من الخلفية
      print("🔄 App Resumed - Refreshing notifications");
      NotifactionViewModel.instance.refresh();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NotifactionViewModel>(context);
    return Scaffold(
      appBar: AppBarWithBack(context, Translations.of(context)!.notification),
      drawer: DrawerList(context),
      backgroundColor: Colors.white,
      body: PagedListView<int, NotificationModel>(
        pagingController: viewModel.pagingController,
        builderDelegate: PagedChildBuilderDelegate<NotificationModel>(
          itemBuilder: (context, item, index) => _tile(item, index, viewModel),
          firstPageProgressIndicatorBuilder: (_) => Center(child:IconedButtonLoading()),
          newPageProgressIndicatorBuilder: (_) => Center(child:IconedButtonLoading()),
          firstPageErrorIndicatorBuilder: (_) => NoDataView(onTapped:()=> viewModel.Refresh()),
          newPageErrorIndicatorBuilder: (_) => Center(child: Text(Translations.of(context)!.ErrorDes,style: Style.MainText14Bold,)),
          noItemsFoundIndicatorBuilder: (_) => Center(
            child: NoDataView(onTapped:()=> viewModel.Refresh()),
          ),
        ),

      ),
    );
  }

  _tile(NotificationModel data, int index, NotifactionViewModel viewModel) {
    return  InkWell(child:  Container(
        margin: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 2.0.w),
        padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 2.0.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: Style.SecondryColor, width: 0.1.w),
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              des((index+1).toString() +"- ",),
              title(data.message.toString()),
            ],
          ),
         /* Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title(data.id.toString()),
            ],
          ),*/
          //  Divider(height: 1.0.h, color: Style.SecondryColor, thickness: 0.5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              des(data.created_at.toString()),
            ],
          ),

        ],)),onTap: ()=> viewModel.Read(data),);
  }

  title(String text) {
    return Expanded(child: Text(text + "   ", style: Style.MainText16Bold,));
  }

  des(String text) {
    return  Text(text, style: Style.MainText16.copyWith(color: Style.hColor2),);
  }
}
