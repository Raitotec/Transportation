/*
الصفحه الرئيسيه
 */

import 'dart:io';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';
import 'package:transportation/Models/OrderModel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Constants/Localization/Translations.dart';
import '../Constants/Style.dart';
import '../Shared_View/AnimatedButton.dart';
import '../Shared_View/AppBarView.dart';
import '../Shared_View/BackgroundView.dart';
import '../Shared_View/DrawerView.dart';
import '../Shared_View/NoDataView.dart';
import '../Shared_View/ProgressIndicatorButton.dart';
import '../Shared_View/_buildLoadingScaffold.dart';
import '../ViewModel/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart'; // لو كنتي بتستخدمي sizer في المشروع


class ShowOrderPage extends StatefulWidget {


  ShowOrderPage({Key? key}) : super(key: key);

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
        builder: (context, viewModel, child)
    {
      return SingleChildScrollView(child:  Column(children: [ Container(
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
                des(viewModel.currentRequest!.requestNumber.toString()),
              ],
            ),
            Divider(height: 1.0.h, color: Style.SecondryColor, thickness: 0.5,),
            SpaceRow(),
            Row(
              children: [
                Icon_Title(Icons.calendar_month),
                title(Translations.of(context)!.date1),
                des(viewModel.currentRequest!.formattedDate.toString()),
                Icon_Title(Icons.timer_outlined),
                title(Translations.of(context)!.time),
                Text(viewModel.currentRequest!.formattedTime.toString(), style: Style.MainText16,),
              ],
            ),
            if(viewModel.value != 2 )
            SpaceRow(),
            if(viewModel.value != 2 )
            Row(
              children: [
                Icon_Title(Icons.calendar_month),
                title(Translations.of(context)!.date2),
                des(viewModel.currentRequest!.formatted_deliveryDate.toString()),
                Icon_Title(Icons.timer_outlined),
                title(Translations.of(context)!.time),
                Text(viewModel.currentRequest!.formatted_deliveryTime.toString(), style: Style.MainText16,),
              ],
            ),
            SpaceRow(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon_Title(Icons.image_outlined),
                title(Translations.of(context)!.load_attachment),
                if(viewModel.currentRequest!.loadingRequestAttachments != null &&
                    viewModel.currentRequest!.loadingRequestAttachments!.isNotEmpty)
                  Expanded(child: SizedBox(
                      height: 8.0.h,
                      child: ShowImagesNetwork(
                          viewModel.currentRequest!.loadingRequestAttachments!)))
              ],
            ),
            if(viewModel.currentRequest!.supplierLoadingRequestAttachments != null &&
                viewModel.currentRequest!.supplierLoadingRequestAttachments!.isNotEmpty)
              SpaceRow(),
            if(viewModel.currentRequest!.supplierLoadingRequestAttachments != null &&
                viewModel.currentRequest!.supplierLoadingRequestAttachments!.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon_Title(Icons.image_outlined),
                  title(Translations.of(context)!.aramco_attachment),
                  Expanded(child: SizedBox(
                      height: 8.0.h,
                      child: ShowImagesNetwork(
                          viewModel.currentRequest!.supplierLoadingRequestAttachments!)))
                ],
              ),
            if(viewModel.currentRequest!.loadingPermissionAttachments != null &&
                viewModel.currentRequest!.loadingPermissionAttachments!.isNotEmpty)
              SpaceRow(),
            if(viewModel.currentRequest!.loadingPermissionAttachments != null &&
                viewModel.currentRequest!.loadingPermissionAttachments!.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon_Title(Icons.image_outlined),
                  title(Translations.of(context)!.delivery_attachment),
                  Expanded(child: SizedBox(
                      height: 8.0.h,
                      child: ShowImagesNetwork(
                          viewModel.currentRequest!.loadingPermissionAttachments!)))
                ],
              ),
            if(viewModel.value == 0 )
              SpaceRow(),
            if(viewModel.value == 0 )
              Row(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Expanded(child:   Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon_Title(Icons.add_a_photo_outlined),
                        title(Translations.of(context)!
                            .aramco_add_attachment),

                      ],
                    )),
                  ElevatedButton(
                      onPressed: () async {
                        await viewModel.pickImages(true);
                      },
                      child:Text( Translations.of(context)!.load_pic,style: Style.MainText14Bold,), // حجم تأثير الضغط
                    ),
                  ]),
            if(viewModel.value == 0 )
              Row(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShowImages(
                        viewModel.images_load, viewModel.images_path_load),
                  ]),
            if(viewModel.value == 0 )
              SpaceRow(),
            if(viewModel.value == 0 )
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
                                .delivery_add_attachment),
                          ],
                        )),
                    ElevatedButton(
                      onPressed: () async {
                        await viewModel.pickImages(false);
                      },
                      child:Text( Translations.of(context)!.load_pic,style: Style.MainText14Bold,), // حجم تأثير الضغط
                    ),

                  ]),
            if(viewModel.value == 0 )
            Row(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShowImages(
                      viewModel.images_delivery, viewModel.images_path_delivery),
                ]),
            if(viewModel.value == 0 )
            SpaceRow(),
            Row(
                children: [
                  Expanded(child: InkWell(onTap: () async {
                    await viewModel.getLocation(
                        viewModel.currentRequest!.loadingSite!.latitude!,
                        viewModel.currentRequest!.loadingSite!.longitude!,
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
                    viewModel.currentRequest!.clientStation!.latitude!,
                    viewModel.currentRequest!.clientStation!.longitude!,
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
            if(viewModel.value == 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AnimatedButton(text: Translations.of(context)!.save_request,
                      onTapped: () async {
                        await viewModel.saveRequest( context);
                      }),
                  SizedBox(width: 2.0.w,),
                  AnimatedButton(text: Translations.of(context)!.end_request,
                      onTapped: () async {
                        await sureDialog(viewModel.currentRequest!, viewModel);
                      }),
                ],),
            if(viewModel.value != 0)
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
          ],))]));
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



  ShowImagesNetwork(List<String> attachments) {
    return Container(
      height: (attachments != null && attachments.isNotEmpty) ? 8.0.h : 2.0.h,
      decoration: Style.Glass7BoxDecoration,
      child: Column(
        children: [
          if (attachments != null && attachments.isNotEmpty)
            Expanded(
              child: Container(
                height: 10.0.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: attachments.length,
                  itemBuilder: (ctx, i) {
                    final item = attachments[i];
                    if ( _isImage(item)) {
                      // 🔸 لو صورة
                      return smallImage(item);
                    } else {
                      // 🔸 لو مرفق PDF أو أي نوع آخر
                      return _buildFileAttachment(item);
                    }
                  },
                ),
              ),
            ),
          Container(),
        ],
      ),
    );
  }
  bool _isImage(String url) {
    final lower = url.toLowerCase();
    return lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.gif') ||
        lower.endsWith('.bmp') ||
        lower.endsWith('.webp');
  }
  Widget _buildFileAttachment(String item) {
    String fileName = '';
    fileName = Uri.decodeFull(item.split('/').last);

    return GestureDetector(
      onTap: () async {
        // هنا تقدر تفتحي الملف مثلا
        print('Open file: $item');
        final Uri url = Uri.parse(item);

        if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication, // يفتح في المتصفح
        )) {
        throw 'Could not open $item';
        }
      },
      child: Container(
        width: 20.0.w,
        margin: EdgeInsets.symmetric(horizontal: 1.0.w),
        padding: EdgeInsets.all(2.0.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade400),
          color: Colors.grey.shade100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.attach_file, size:3.0.h, color: Colors.redAccent),
            SizedBox(height: 0.5.h,),
            Text("مرفق",style: Style.MainText14,)
          ],
        ),
      ),
    );
  }



  Widget smallImage( String? img) {
    if (img == null || img.isEmpty) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 2.0.w),
        width: 20.0.w,
        height: 10.0.h,
        color: Colors.grey.shade300,
        child: Icon(Icons.broken_image, color: Colors.grey, size: 24.sp),
      );
    }

    return GestureDetector(
      onTap: () {
        // لما تضغطي على الصورة، تفتح fullscreen بزوم
        showDialog(
          context: context,
          builder: (_) => Dialog(
            backgroundColor: Colors.black,
            insetPadding: EdgeInsets.zero,
            child: Stack(
              children: [
                PhotoView(
                  imageProvider: NetworkImage(img),
                  backgroundDecoration:
                  const BoxDecoration(color: Colors.black),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 3,
                ),
                Positioned(
                  top: 30,
                  right: 20,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 28),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        width: 20.0.w,
        margin: EdgeInsets.symmetric(horizontal: 1.0.w),
    //    padding: EdgeInsets.all(2.0.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade400),
          color: Colors.grey.shade100,
        ),
        child: Hero(
        tag: img,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            img,
            fit: BoxFit.cover,
            width: 25.0.w,
            height: 10.0.h,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.error, color: Colors.redAccent),
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Center(
                child: SizedBox(
                  width: 16.sp,
                  height: 16.sp,
                  child: const CircularProgressIndicator(strokeWidth: 1.5),
                ),
              );
            },
          ),
        ),
      )),
    );
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
            await viewModel.sendRequest(context);},
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