/*
الصفحه الرئيسيه
 */

import 'dart:io';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:full_screen_image/full_screen_image.dart';
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
import '../Shared_View/TextFieldNumber.dart';
import '../Shared_View/_buildLoadingScaffold.dart';
import '../Shared_View/dropdown.dart';
import '../ViewModel/HomeViewModel.dart';

  class ShowExpensesPage extends StatefulWidget {
    final OrderModel data;
    ShowExpensesPage({required this.data,Key? key}) : super(key: key);
  @override
  _ExpensesPageState createState() => _ExpensesPageState();
  }

  class _ExpensesPageState extends State<ShowExpensesPage> {
  late Future<void> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = Provider.of<HomeViewModel>(context, listen: false).GetPaymentData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWithBack(context, Translations.of(context)!.ExpensesAdd),
        drawer: DrawerList(context),
        body:  FutureBuilder(
          future: _dataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildLoadingScaffold(
                  context, Translations.of(context)!.send_request);
            }
            else if (snapshot.hasError) {
              return Consumer<HomeViewModel>(
                  builder: (context, viewModel, child)
                  {
                    return NoDataView(onTapped:()=> viewModel.GetPaymentData(context));
                  });
            }
            else {
              return MainScaffold(context);
            }
          },
        ));
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
                _tile(widget.data,viewModel),
                SizedBox(height: 2.0.h,),
              ]
          );
        });
  }

  _tile(OrderModel data, HomeViewModel viewModel) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.0.w),
        padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 2.0.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: Style.SecondryColor, width: 0.1.w),
        ),
        child: Column(children: [
          Row(
            children: [
              Icon_Title(Icons.local_shipping_outlined),
              title(Translations.of(context)!.Order_num),
              des(data.id.toString()),
            ],
          ),
          Divider(height: 1.0.h, color: Style.SecondryColor, thickness: 0.5,),
          SpaceRow(),
          Row(
            children: [
              Icon_Title(Icons.calendar_month),
              title(Translations.of(context)!.date),
              des(data.date.toString()),
              Icon_Title(Icons.timer_outlined),
              title(Translations.of(context)!.time),
              Text(data.time.toString(),style:  Style.MainText16,),
            ],
          ),
          SpaceRow(),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon_Title(Icons.account_balance_wallet_outlined),
                title(Translations.of(context)!.ExpensesKind),
              Expanded(child:   Container(
                    decoration:BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(color: Style.SecondryColor, width: 1.0),
                      borderRadius: const BorderRadius.only(
                        topLeft: const Radius.circular(5.0),
                        topRight: const Radius.circular(5.0),
                        bottomRight: const Radius.circular(5.0),
                        bottomLeft: const Radius.circular(5.0),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 1.0.h, horizontal: 1.0.w),
                    margin: EdgeInsets.symmetric(
                        vertical: 1.0.h, horizontal: 1.0.w),
                    child: showPaymentMethodsData(viewModel)))
              ]
          ),
          SpaceRow(),
        Row(children: [
          Icon_Title(Icons.wallet),
          title(Translations.of(context)!.amount),
          Expanded(child: TextFieldNumber(controller:viewModel.AmountController,
           // label:Translations.of(context)!.amount,
            onChanged:  (String value) async {
              await viewModel.ChangeAmount(value,context);
            }
            ,textAlign: TextAlign.start,
            vertical: 1.0.h,
          ),)
        ],) ,
            //padding: EdgeInsets.symmetric(horizontal: 3.0.w),
          SpaceRow(),
          Row(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () async {
                      await viewModel.pickImages(true);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon_Title(Icons.add_a_photo_outlined),
                        title(Translations.of(context)!.invoice_attachment),

                      ],
                    )),
                ShowImages(viewModel.images_invoice, viewModel.images_path_invoice),
              ]),
          SizedBox(height: 2.0.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedButton(text: Translations.of(context)!.ExpensesAdd,
                  onTapped: () async {
                    await viewModel.addMoney(data, context);
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
  Icon_Title(IconData icon)
  {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 1.0.w),
        child: Icon(icon,size: 3.0.h,color: Style.SecondryColor,));
  }
  SpaceRow()
  {
    return SizedBox(height: 1.2.h,);
  }


  ShowImages(  List<File> images,List<String> path)
  {
    return   Expanded(
        child: Container(
            height: (images != null && images.length > 0) ? 8.0.h : 2.0.h,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  if(images != null && images.length > 0)
                    Expanded(
                      child: Container(
                          height:10.0.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: images.length,
                            itemBuilder: (ctx, i) =>
                                MainCategoryShape(images[i],images),
                          )

                      ),
                    ),
                  Container(),
                ])));
  }


  MainCategoryShape(File _imageFileList, List<File> images) {
    return Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Stack(
              children: [
                /*  AssetThumb(
              width: (10.0.w).toInt(),
              height: (10.0.h).toInt(),
              asset: asset,
            ),*/
                FullScreenWidget(
                    disposeLevel: DisposeLevel.High,
                    child: Center(child: Hero(tag: "tag", child:  Image.file(File(_imageFileList.path),),))),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    child: Icon(Icons.highlight_remove_outlined, color: Colors.red,),
                    onTap: () {
                      setState(() {
                        images.remove(_imageFileList);
                      });
                    },
                  ),
                ),
              ],
            )
        ));
  }
}