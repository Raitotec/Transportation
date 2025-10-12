/*
الصفحه الرئيسيه
 */

import 'dart:io';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:transportation/Constants/Routes/route_constants.dart';
import 'package:transportation/Models/OrderModel.dart';
import 'package:transportation/ViewModel/ExpensesViewModel.dart';
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

  class ShowExpensesPage extends StatefulWidget {

    ShowExpensesPage({Key? key}) : super(key: key);
  @override
  _ExpensesPageState createState() => _ExpensesPageState();
  }

  class _ExpensesPageState extends State<ShowExpensesPage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWithBack(context, Translations.of(context)!.ExpensesAdd),
        drawer: DrawerList(context),
        body: Consumer<ExpensesViewModel>(
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
    ));
  }

  Widget FormUI() {
    return Consumer<ExpensesViewModel>(
        builder: (context, viewModel, child) {
          return Column(
              children: [
                SizedBox(height: 2.0.h,),
                Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 0.5.h, horizontal: 2.0.w),
                    padding: EdgeInsets.symmetric(
                        vertical: 1.0.h, horizontal: 2.0.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(
                          color: Style.SecondryColor, width: 0.1.w),
                    ),
                    child: Column(children: [
                      Row(
                        children: [
                          Icon_Title(Icons.local_shipping_outlined),
                          title(Translations.of(context)!.Order_num),
                          des(viewModel.currentRequest!.requestNumber.toString()),
                        ],
                      ),
                      Divider(height: 1.0.h,
                        color: Style.SecondryColor,
                        thickness: 0.5,),
                      SpaceRow(),
                      Row(
                        children: [
                          Icon_Title(Icons.calendar_month),
                          title(Translations.of(context)!.date),
                          des(viewModel.currentRequest!.formattedDate.toString()),
                          Icon_Title(Icons.timer_outlined),
                          title(Translations.of(context)!.time),
                          Text(viewModel.currentRequest!.formattedTime.toString(),
                            style: Style.MainText16,),
                        ],
                      ),
                      SpaceRow(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon_Title(Icons.account_balance_wallet_outlined),
                            title(Translations.of(context)!.ExpensesKind),
                            Expanded(child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  border: Border.all(
                                      color: Style.SecondryColor, width: 1.0),
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
                        Expanded(child: TextFieldNumber(
                          controller: viewModel.AmountController,
                          // label:Translations.of(context)!.amount,
                          onChanged: (String value) async {
                            await viewModel.ChangeAmount(value, context);
                          }
                          , textAlign: TextAlign.start,
                          vertical: 1.0.h,
                        ),)
                      ],),
                      //padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                      SpaceRow(),

                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child:  Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon_Title(Icons.add_a_photo_outlined),
                                  title(Translations.of(context)!
                                      .invoice_attachment),
                                ],
                              )),
                              ElevatedButton(
                                onPressed: () async {
                                  await viewModel.pickImages(true);
                                },
                                child:Text( Translations.of(context)!.load_pic,style: Style.MainText14Bold,), // حجم تأثير الضغط
                              ),

                            ]),

                        Row(mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShowImages(viewModel.images_invoice,
                                  viewModel.images_path_invoice),
                            ]),
                      SizedBox(height: 2.0.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AnimatedButton(
                              text: Translations.of(context)!.ExpensesAdd,
                              onTapped: () async {
                                await viewModel.addMoney(viewModel.currentRequest!, context);
                              }),
                        ],)

                    ],))
              ]);
        });
  }
  title(String text)
  {
    return  Text(text+"   ",style:  Style.MainText16Bold,);
  }
  des(String text)
  {
    return Expanded(child: Text(text,style:  Style.MainText16,));
  }

  showPaymentMethodsData(ExpensesViewModel viewModel) {
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


  Widget ShowImages(List<File> files, List<String> filePaths) {
    if (files.isEmpty) return const SizedBox(); // لو مفيش صور

    return Flexible(
      child: Container(
        height: 8.0.h,
        decoration: Style.Glass7BoxDecoration,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: files.length,
          itemBuilder: (ctx, i) {
            final file = files[i];

            return Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: ctx,
                      builder: (_) => Dialog(
                        backgroundColor: Colors.black,
                        insetPadding: EdgeInsets.zero,
                        child: Stack(
                          children: [
                            PhotoView(
                              imageProvider: FileImage(file),
                              backgroundDecoration:
                              const BoxDecoration(color: Colors.black),
                              minScale: PhotoViewComputedScale.contained,
                              maxScale: PhotoViewComputedScale.covered * 3,
                            ),
                            Positioned(
                              top: 40,
                              right: 20,
                              child: IconButton(
                                icon: const Icon(Icons.close,
                                    color: Colors.white, size: 30),
                                onPressed: () => Navigator.of(ctx).pop(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child:  Container(
                    width: 20.0.w,
                    margin: EdgeInsets.symmetric(horizontal: 1.0.w),
                    //    padding: EdgeInsets.all(2.0.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade400),
                      color: Colors.grey.shade100,
                    ),
                    child: Image.file(
                      file,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 0,
                  right: 5,
                  child: InkWell(
                    onTap: () {

                      setState(() {
                        if (i >= 0 && i < files.length) {
                          files.removeAt(i);
                        }
                        if (i >= 0 && i < filePaths.length) {
                          filePaths.removeAt(i);
                        }
                      });
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white30,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(2),
                      child: const Icon(
                        Icons.highlight_remove_outlined,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

}