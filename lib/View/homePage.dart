/*
الصفحه الرئيسيه
 */

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:transportation/Constants/Routes/route_constants.dart';
import 'package:transportation/Models/OrderModel.dart';
import '../Api/checkVersion.dart';
import '../Constants/Localization/LanguageData.dart';
import '../Constants/Localization/Translations.dart';
import '../Constants/Style.dart';
import '../Shared_View/AnimatedButton.dart';
import '../Shared_View/AnimatedGridIcon.dart';
import '../Shared_View/AppBarView.dart';
import '../Shared_View/BackgroundView.dart';
import '../Shared_View/DrawerView.dart';
import '../Shared_View/NoDataView.dart';
import '../Shared_View/ProgressIndicatorButton.dart';
import '../Shared_View/_buildLoadingScaffold.dart';
import '../ViewModel/HomeViewModel.dart';

  class HomePage extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
  }

  class _HomeScreenState extends State<HomePage> {
  late Future<void> _dataFuture;
  final newVersion = NewVersionPlus();

  @override
  void initState() {
    super.initState();
    _dataFuture = Provider.of<HomeViewModel>(context, listen: false).GetData(context);
    advancedStatusCheck(context,newVersion);
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildLoadingScaffold(
                context, Translations.of(context)!.Home);
          } else if (snapshot.hasError) {
            return Consumer<HomeViewModel>(
              builder: (context, viewModel, child)
            {
              return NoDataView(onTapped:()=> viewModel.GetData(context));
            });
          } else {
           return MainScaffold(context);
          }
        },
          );
  }

  Widget MainScaffold(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return  LoadingOverlay(
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
    return Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Column(
              children: [

                SizedBox(height: 2.0.h,),
                AnimatedToggleSwitch<int>.size(
                  current: viewModel.value,
                  style: ToggleStyle(

                    backgroundColor: Colors.white,
                    indicatorColor: Style.SecondryColor,
                    indicatorGradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [Style.hColor2, Style.hColor1]),
                    borderColor: Style.SecondryColor,
                    borderRadius: BorderRadius.circular(20.0),
                    indicatorBorderRadius: BorderRadius.zero,
                  ),
                  values: viewModel.slider,
                  iconOpacity: 1.0,
                  selectedIconScale: 1.0,
                  indicatorSize: Size.fromWidth(30.0.w),
                  height: 5.0.h,
                  iconAnimationType: AnimationType.onHover,
                  styleAnimationType: AnimationType.onHover,
                  spacing: 1.0.w,
                  customSeparatorBuilder: (context, local, global) {
                    final opacity =
                    ((global.position - local.position).abs() - 0.5)
                        .clamp(0.0, 1.0);
                    return VerticalDivider(
                        indent: 0,
                        endIndent: 0,
                        width: 0.1.w,
                        thickness: 0.1.w,
                        color: Style.SecondryColor.withOpacity(opacity));
                  },
                  customIconBuilder: (context, local, global) {
                    final text = [Translations.of(context)!.Orders_now,
                      Translations.of(context)!.Orders_later,
                      Translations.of(context)!.Orders_end][local.index];
                    return Center(
                        child: Text(text,
                            style: TextStyle(
                                color: Color.lerp(Style.MainTextColor, Colors.white,
                                    local.animationValue), fontSize: 18.0.sp)));
                  },
                  borderWidth: 0.5,
                  onChanged: (i) {
                    viewModel.onChangeSlider(context,i);
                  },
                ),
                SizedBox(height: 1.0.h,),
                Expanded(child: CarouselSlider(
                  carouselController: viewModel.controller,
                  options: CarouselOptions(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      onPageChanged: (index, reason) {
                       viewModel.onPageChanged(context,index);
                      }
                    // autoPlay: false,
                  ),
                  items: viewModel.slider.map((item) =>
                  viewModel.value == 0 ?
                  ListData(viewModel.CurrentItems) :
                  viewModel.value == 1 ?
                  ListData(viewModel.LaterItems)
                  :
                  ListData(viewModel.EndItems)
                  ).toList()
                  ,
                ),)
              ]
          );
        });
  }

Widget ListData(List<Requests> lst) {
  if (lst != null && lst.length > 0) {
    return Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return RefreshIndicator(child: _ListView(lst), onRefresh:()=> viewModel.Refresh(context));}) ;
  } else {
    return Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return NoDataView(onTapped: () async {
          await viewModel.Refresh(context);
          });
        });
  }
}

  _ListView(List<Requests>  data) {
    return AnimationLimiter(
        child:ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  duration:  Duration(milliseconds: Style.milliseconds),
                  child: SlideAnimation(
                      horizontalOffset: MediaQuery.of(context).size.width / 2,
                      child: FadeInAnimation(
                          child:_tile( data[index],index))));
            }));
  }

  _tile(Requests data,int index) {
    return Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return  Container(
      margin: EdgeInsets.symmetric(vertical: 0.5.h,horizontal: 2.0.w),
      padding: EdgeInsets.symmetric(vertical: 1.0.h,horizontal: 2.0.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: Style.SecondryColor,width: 0.1.w),
      ),
      child: Column(children: [
       Row(
         children: [
           title(Translations.of(context)!.Order_num),
           des(data.requestNumber.toString()),
         ],
       ),
        Divider(height: 1.0.h,color: Style.SecondryColor,thickness: 0.5,),
        Row(
          children: [
            title(Translations.of(context)!.date),
            des(data.formattedDate.toString()),
            title(Translations.of(context)!.time),
            Text(data.formattedTime.toString(),style:  Style.MainText16,),
          ],
        ),
      SizedBox(height: 1.0.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
          AnimatedButton(text: Translations.of(context)!.show,
              onTapped: () =>viewModel.show(data,context) ),
        ],)

      ],));});
  }
  title(String text)
  {
    return  Text(text+"   ",style:  Style.MainText16Bold,);
  }
  des(String text)
  {
    return Expanded(child: Text(text,style:  Style.MainText16,));
  }


}