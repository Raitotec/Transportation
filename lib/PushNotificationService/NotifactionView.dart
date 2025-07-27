import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:transportation/PushNotificationService/NotificationModel.dart';

import '../Constants/Localization/Translations.dart';
import '../Constants/Style.dart';
import '../Shared_View/AppBarView.dart';
import '../Shared_View/BackgroundView.dart';
import '../Shared_View/DrawerView.dart';
import '../Shared_View/NoDataView.dart';
import '../Shared_View/ProgressIndicatorButton.dart';
import '../Shared_View/_buildLoadingScaffold.dart';
import 'NotifactionViewModel.dart';

class NotifactionView extends StatefulWidget {
  @override
  _NotifactionViewState createState() => _NotifactionViewState();
}

class _NotifactionViewState extends State<NotifactionView> {
  late Future<void> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture =
        Provider.of<NotifactionViewModel>(context, listen: false).GetData(
            context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWithBack(context, Translations.of(context)!.notification),
    drawer: DrawerList(context),
    body: FutureBuilder(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildLoadingScaffold(context, Translations.of(context)!.notification);
        } else if (snapshot.hasError) {
          return Consumer<NotifactionViewModel>(
              builder: (context, viewModel, child) {
                return NoDataView(onTapped: () => viewModel.GetData(context));
              });
        } else {
          return MainScaffold(context);
        }
      },
    ));
  }

  Widget MainScaffold(BuildContext context) {
    return Consumer<NotifactionViewModel>(
      builder: (context, viewModel, child) {
        return LoadingOverlay(
            isLoading: viewModel.isLoading,
            opacity: 0.2,
            color: Style.MainColor,
            progressIndicator: IconedButtonLoading(),
            child: SafeArea(
                child: BackgroundView(
                    dataWidget: FormUI()
                )
            ));
      },
    );
  }

  Widget FormUI() {
    return Consumer<NotifactionViewModel>(
        builder: (context, viewModel, child) {
          return Column(
              children: [
                SizedBox(height: 2.0.h,),
                Expanded(child: ListData(viewModel.Items, viewModel)),
                SizedBox(height: 2.0.h,),
              ]
          );
        });
  }

  Widget ListData(List<NotificationModel> lst, NotifactionViewModel viewModel) {
    if (lst != null && lst.length > 0) {
      return RefreshIndicator(child: _ListView(lst, viewModel),
          onRefresh: () => viewModel.Refresh(context));
    } else {
      return Consumer<NotifactionViewModel>(
          builder: (context, viewModel, child) {
            return NoDataView(onTapped: () async {
              await viewModel.Refresh(context);
            });
          });
    }
  }

  _ListView(List<NotificationModel> data, NotifactionViewModel viewModel) {
    return AnimationLimiter(
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(milliseconds: Style.milliseconds),
                  child: SlideAnimation(
                      horizontalOffset: MediaQuery
                          .of(context)
                          .size
                          .width / 2,
                      child: FadeInAnimation(
                          child: _tile(data[index], index, viewModel))));
            }));
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