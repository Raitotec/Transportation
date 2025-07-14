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
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';
import 'package:transportation/Models/OrderModel.dart';
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

class ShowOrderPage extends StatefulWidget {
  final Requests data;

  ShowOrderPage({required this.data,Key? key}) : super(key: key);

  @override
  _ShowOrderPageState createState() => _ShowOrderPageState();
}

class _ShowOrderPageState extends State<ShowOrderPage> {
//  late Future<void> _dataFuture;


  @override
  void initState() {
    super.initState();
 //   _dataFuture = Provider.of<HomeViewModel>(context, listen: false).GetData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWithBack(context, Translations.of(context)!.send_request),
    drawer: DrawerList(context),
    body:  MainScaffold(context)
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
                _tile(widget.data, viewModel),
              ]
          );
        });
  }


  _tile(Requests data, HomeViewModel viewModel) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.0.w),
        padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.w),
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
              des(data.requestNumber.toString()),
            ],
          ),
          Divider(height: 1.0.h, color: Style.SecondryColor, thickness: 0.5,),
          SpaceRow(),
          Row(
            children: [
              Icon_Title(Icons.calendar_month),
              title(Translations.of(context)!.date),
              des(data.formattedDate.toString()),
              Icon_Title(Icons.timer_outlined),
              title(Translations.of(context)!.time),
              Text(data.formattedTime.toString(),style:  Style.MainText16,),
            ],
          ),
          SpaceRow(),
          InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon_Title(Icons.image_outlined),
                  title(Translations.of(context)!.load_attachment),
                  Container(
                      height: 8.0.h,
                      child: smallImage("data.img_load!"))
                ],
              )),
          if(data.order_type_id != 2 )
          SpaceRow(),
          if(data.order_type_id != 2 )
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
                        title(Translations.of(context)!.aramco_attachment),

                      ],
                    )),
                ShowImages(viewModel.images_load, viewModel.images_path_load),
              ]),
          if(data.order_type_id != 2 )
          SpaceRow(),
          if(data.order_type_id != 2 )
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () async {
                      await viewModel.pickImages(false);
                    },
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon_Title(Icons.add_a_photo_outlined),
                        title(Translations.of(context)!.delivery_attachment),

                      ],
                    )),
                ShowImages(
                    viewModel.images_delivery, viewModel.images_path_delivery)
              ]),
          SpaceRow(),
          if(data.order_type_id == 2 )
          InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon_Title(Icons.image_outlined),
                  title(Translations.of(context)!.aramco_attachment),
                  Container(
                      height: 8.0.h,
                      child: smallImage("data.img_load!"))
                ],
              )),
          if(data.order_type_id == 2 )
          SpaceRow(),
          if(data.order_type_id == 2 )
          InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon_Title(Icons.image_outlined),
                  title(Translations.of(context)!.delivery_attachment),
                  Container(
                      height: 8.0.h,
                      child: smallImage("data.img_load!"))
                ],
              )),
          if(data.order_type_id == 2 )
          SpaceRow(),
          Row(
              children: [
                Expanded(child: InkWell(onTap: () async {
                  await viewModel.getLocation(
                      data.loadingSite!.latitude!, data.loadingSite!.longitude!,
                      Translations.of(context)!.load_location);
                },
                    child: Row(
                      children: [
                        Icon_Title(Icons.location_on_outlined),
                        title(Translations.of(context)!.load_location),
                      ],
                    ))),
              ]),
          SpaceRow(),
          Row(children: [
            Expanded(child: InkWell(onTap: () async {
              await viewModel.getLocation(
                  data.clientStation!.latitude!, data.clientStation!.longitude!,
                  Translations.of(context)!.delivery_location);
            },
                child: Row(
                  children: [
                    Icon_Title(Icons.location_on_outlined),
                    title(Translations.of(context)!.delivery_location),
                  ],
                )))
          ],
          ),
          SpaceRow(),
          if(data.order_type_id == 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AnimatedButton(text: Translations.of(context)!.send_request,
                    onTapped: () async {
                      await sureDialog(data, viewModel);
                    }),
              ],),
          if(data.order_type_id != 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.3.h, horizontal: 3.0.w),
                  decoration: BoxDecoration(
                      color: Style.GreyColor,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(15.0),
                        topRight: const Radius.circular(15.0),
                        bottomRight: const Radius.circular(15.0),
                        bottomLeft: const Radius.circular(15.0),
                      ),
                      boxShadow: [
                        BoxShadow(color: Style.GreyColor.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(1, 2))
                      ]
                  ),
                  child: Text(Translations.of(context)!.send_request,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Style.WhiteColor,
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.bold),),
                )
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

  Widget smallImage(String? img) {
    return FullScreenWidget(
        disposeLevel: DisposeLevel.High,
        child: Center(child: Hero(tag: "tag", child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
            "https://www.dropoff.com/wp-content/uploads/2022/04/Ultimate-Guide-to-Last-Mile-Delivery-Tracking-01-scaled.jpg"
            ,fit: BoxFit.cover,
            )),

        ),
        ));
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

  sureDialog(Requests data, HomeViewModel viewModel) {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: Translations.of(context)!.send_request,
      desc: Translations.of(context)!.sure,
      buttons: [
        DialogButton(
          child: Text(
            Translations.of(context)!.okey,
            style: Style.MainText16Bold
          ),
          onPressed: () async {
            Navigator.pop(context);
            await viewModel.sendRequest(data,context);},
          color: Colors.black12,
        ),
        DialogButton(
          child: Text(
            Translations.of(context)!.no,
            style: Style.MainText16Bold,
          ),
          onPressed: () => Navigator.pop(context),
         color: Style.SecondryColor,
        )
      ],
        style: AlertStyle(overlayColor:  Colors.black54,
          titleStyle:  Style.MainText16Bold,
          descStyle:  Style.MainText16Bold,
        )
    ).show();
  }





}