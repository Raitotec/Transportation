/*
الصفحه الرئيسيه
 */

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:transportation/Constants/Routes/route_constants.dart';
import 'package:transportation/Models/OrderModel.dart';
import '../Constants/Localization/LanguageData.dart';
import '../Constants/Localization/Translations.dart';
import '../Constants/Style.dart';
import '../Models/PaymentMethodsData.dart';
import '../Shared_View/AnimatedButton.dart';
import '../Shared_View/AnimatedGridIcon.dart';
import '../Shared_View/AppBarView.dart';
import '../Shared_View/BackgroundView.dart';
import '../Shared_View/DrawerView.dart';
import '../Shared_View/NoDataView.dart';
import '../Shared_View/ProgressIndicatorButton.dart';
import '../Shared_View/_buildLoadingScaffold.dart';
import '../Shared_View/dropdown.dart';
import '../ViewModel/HomeViewModel.dart';

  class ExpensesPage extends StatefulWidget {
  @override
  _ExpensesPageState createState() => _ExpensesPageState();
  }

  class _ExpensesPageState extends State<ExpensesPage> {
  late Future<void> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = Provider.of<HomeViewModel>(context, listen: false).GetData(context);
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildLoadingScaffold(
                context, Translations.of(context)!.Expenses);
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
              Expanded(child:   ListData(viewModel.CurrentItems,viewModel)),
                SizedBox(height: 2.0.h,),
              ]
          );
        });
  }

Widget ListData(List<Requests> lst,HomeViewModel viewModel) {
  if (lst != null && lst.length > 0) {
    return _ListView(lst,viewModel);
  } else {
    return Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return NoDataView(onTapped: () async {
          await viewModel.Refresh(context);
          });
        });
  }
}

  _ListView(List<Requests>  data, HomeViewModel viewModel) {
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
                          child:_tile( data[index],index,viewModel))));
            }));
  }

  _tile(Requests data,int index, HomeViewModel viewModel) {
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
              title(Translations.of(context)!.Order_num),
              des(data.requestNumber.toString()),
            ],
          ),
          Divider(height: 1.0.h, color: Style.SecondryColor, thickness: 0.5,),
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
                  onTapped: () async {
                    Navigator.pushNamed(context, Show_Expenses_Route,
                        arguments: data!);
                  }),
            ],)

        ],));
  }
  title(String text)
  {
    return  Text(text+"   ",style:  Style.MainText16Bold,);
  }
  des(String text)
  {
    return Expanded(child: Text(text,style:  Style.MainText16,));
  }

  showPaymentMethodsData(HomeViewModel viewModel) {
    if( viewModel.MyPaymentMethodsList !=null&& viewModel.MyPaymentMethodsList!.length>0) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 0.0.h, horizontal: 0.0.w),
        child: CustomDropdownButton2<PaymentMethodsData>(
          hint: '',
          value: viewModel.SelectedPaymentMethods,
          dropdownWidth: 45.0.w,
          dropdownItems: viewModel.MyPaymentMethodsList,
          onChanged: (PaymentMethodsData? value) {
            viewModel.setSelectedPaymentMethods(value);
          },
        ),
      );
    }
    else
    {
      return Container();
    }
  }




}