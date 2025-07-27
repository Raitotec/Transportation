import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:transportation/PushNotificationService/NotifactionViewModel.dart';

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

class _NotificationsScreenState extends State<NotificationsScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    final vm = Provider.of<NotifactionViewModel>(context, listen: false);
    vm.fetchNotifications(context);

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final vm = Provider.of<NotifactionViewModel>(context, listen: false);
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        if (!vm.isLoading && vm.currentPage <= vm.lastPage) {
          vm.fetchNotifications(context,loadMore: true);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(context, Translations.of(context)!.notification),
      drawer: DrawerList(context),
      backgroundColor: Colors.white,
      body:Consumer<NotifactionViewModel>(
        builder: (context, vm, child) {
          return ListView.builder(

            controller: _scrollController,
            itemCount: vm.notifications.length + 1,
            itemBuilder: (context, index) {
              if (index == vm.notifications.length) {
                return vm.isLoading
                    ?  Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: IconedButtonLoading()),
                )
                    : SizedBox();
              }

              final notification = vm.notifications[index];
              return _tile(notification, index, vm);
            },
          );
        },
      ),
    );
  }

  _tile(NotificationModel data, int index, NotifactionViewModel viewModel) {
    return Container(
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
          //  Divider(height: 1.0.h, color: Style.SecondryColor, thickness: 0.5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              des(data.created_at.toString()),
            ],
          ),

        ],));
  }

  title(String text) {
    return Expanded(child: Text(text + "   ", style: Style.MainText16Bold,));
  }

  des(String text) {
    return  Text(text, style: Style.MainText16.copyWith(color: Style.hColor2),);
  }
}
