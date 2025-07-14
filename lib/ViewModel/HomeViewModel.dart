
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:sizer/sizer.dart';
import 'package:transportation/Constants/Routes/route_constants.dart';
import 'package:transportation/Constants/assets/Images_Name.dart';
import '../Api/OrderApi.dart';
import '../Constants/Localization/LanguageData.dart';
import '../Constants/Localization/Translations.dart';
import '../Models/OrderModel.dart';
import '../Models/PaymentMethodsData.dart';
import '../Shared_Data/formatDateTime.dart';
import '../Shared_View/AlertView.dart';

class HomeViewModel extends ChangeNotifier {

  bool _isLoading = false;
  bool _checkVersion = false;
  List<Requests> _CurrentItems = <Requests>[];
  List<Requests> get CurrentItems => _CurrentItems;
  List<Requests> _LaterItems = <Requests>[];
  List<Requests> get LaterItems => _LaterItems;
  List<Requests> _EndItems = <Requests>[];
  List<Requests> get EndItems => _EndItems;
  int _value = 0;
  List<int> _slider = [0, 1,2];
  CarouselSliderController _controller = CarouselSliderController();
  bool get isLoading => _isLoading;
  bool get checkVersion => _checkVersion;
  int get value => _value;
  List<int> get slider => _slider;
  CarouselSliderController get controller => _controller;
  List<File> _images_load = <File>[];
  List<File> get images_load => _images_load;
  List <String> _images_path_load=<String>[];
  List<String> get images_path_load => _images_path_load;
  List<File> _images_delivery = <File>[];
  List<File> get images_delivery => _images_delivery;
  List <String> _images_path_delivery=<String>[];
  List<String> get images_path_delivery => _images_path_delivery;
  List<PaymentMethodsData> _MyPaymentMethodsList=  <PaymentMethodsData>[];
  List<PaymentMethodsData> get MyPaymentMethodsList => _MyPaymentMethodsList;
  PaymentMethodsData? _SelectedPaymentMethods ;
  PaymentMethodsData? get SelectedPaymentMethods => _SelectedPaymentMethods;
  TextEditingController _AmountController = TextEditingController();
  TextEditingController get AmountController => _AmountController;
  List<File> _images_invoice = <File>[];
  List<File> get images_invoice => _images_invoice;
  List <String> _images_path_invoice=<String>[];
  List<String> get images_path_invoice => _images_path_invoice;

  Future<void> GetData(BuildContext context) async {
    checkVersionFun(context);
    _isLoading=true;
     _images_load = <File>[];
    _images_path_load=<String>[];
    _images_delivery = <File>[];
     _images_path_delivery=<String>[];
   try
   {
    var x= await GetRequetFun(context);
    if(x!= null)
      {
        if(x.currentRequests != null && x.currentRequests!.isNotEmpty)
          {
            _CurrentItems= x.currentRequests!;
          }
        if(x.scheduledRequests != null && x.scheduledRequests!.isNotEmpty)
        {
          _LaterItems= x.scheduledRequests!;
        }
        if(x.pastRequests != null && x.pastRequests!.isNotEmpty)
        {
          _EndItems= x.pastRequests!;
        }
      }
    else
      {
        _CurrentItems=_LaterItems=_EndItems=[];
      }
   }
   catch(e)
    {
      _isLoading=false;
    }

    _isLoading=false;
  }

  Future<void> GetPaymentData(BuildContext context) async {

    checkVersionFun(context);
    _isLoading=true;
    _images_invoice = <File>[];
    _images_path_invoice=<String>[];
    try
    {
      _MyPaymentMethodsList=  [
        PaymentMethodsData(name: "payment1",id: 1),
        PaymentMethodsData(name: "payment2",id: 2),
        PaymentMethodsData(name: "payment3",id: 3),
      ];
      _SelectedPaymentMethods=null;
      _AmountController.clear();
    }
    catch(e)
    {
      _isLoading=false;
    }

    _isLoading=false;
  }


  Future<void> Refresh(BuildContext context) async {

    _isLoading=true;
    notifyListeners();
    try
    {
     GetData(context);
    }
    catch(e)
    {
      _isLoading=false;
      notifyListeners();

    }

    _isLoading=false;
    notifyListeners();
  }

  Future<void> updateUIAfterDataFetch() async {
    notifyListeners();
  }


  void onChangeSlider(BuildContext context, int i)
  {

      print("***********" + i.toString());
      _value = i;
      _controller.animateToPage(value);

    notifyListeners();
  }
  void onPageChanged(BuildContext context, int index) {
    _value = index;

    _isLoading = false;
    notifyListeners();
    print(" value = " + value.toString() + " index = " + index.toString());
  }

  Future<void> checkVersionFun(BuildContext context)
  async {
    try {
      /*
      _isLoading=true;
      final _checker = AppVersionChecker();
      var value= await _checker.checkUpdate();
      print(value.canUpdate); //return true if update is available
      print(value.currentVersion); //return current app version
      print(value.newVersion); //return the new app version
      print(value.appURL); //return the app url
      print(value.errorMessage); //return error message if found else it will return null
      if(value.canUpdate)
      {
        await AlertView(
            context, "error", Translations.of(context)!.Please,
            Translations.of(context)!.LastVersion + "(" + value.currentVersion +
                " - " + value!.newVersion!+ ")",id: 1);
        _isLoading=false;
        _checkVersion=true;
      }
      else
      {
        _isLoading=false;
        _checkVersion=false;
      }*/
    }
    catch (e) {
      await AlertView(context, "error", Translations.of(context)!.ErrorTitle,
          "Exception : ${e.toString()}");
      _isLoading=false;
      _checkVersion=false;
    }
  }

  Future<void> getLocation(String? mapLatitude, String? mapLongitude,String text) async
  {
   var x= double.tryParse(mapLatitude!);
   var y= double.tryParse(mapLongitude!);
   if(x != null && y != null) {
     await MapsLauncher.launchCoordinates(x, y, text);
   }
  }


  Future<void> pickImages(bool load) async {
    try {

      _isLoading=true;
      notifyListeners();
      ImagePicker _picker = ImagePicker();
      //  images_path = <String>[];
      //  images= <File>[];
      // Pick multiple images
      XFile? resultList = await _picker.pickImage(source: ImageSource.camera);
      print(resultList!.path);
      //  for (var item in resultList) {
      var compress_File = await compressFile(File(resultList!.path));
      if(load==true) {
        print("&&&&");
        print(compress_File!.path);
        images_load.add(File(compress_File!.path));
        images_path_load.add(compress_File.path);
        images_invoice.add(File(compress_File!.path));
        images_path_invoice.add(compress_File.path);
      }
      else
        {
          images_delivery.add(File(compress_File!.path));
          images_path_delivery.add(compress_File.path);
        }
      _isLoading=false;
      notifyListeners();
    }
    catch (e) {
      _isLoading=false;
      notifyListeners();
      print("************* "+e.toString());
    }
  }
  Future<XFile?> compressFile(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf('.');
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out_${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${filePath.substring(lastIndex)}";
    print("***** "+outPath);
    print(filePath.substring(lastIndex).toString());
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, outPath,
        quality: 25,
        format: filePath.substring(lastIndex).toString().contains("png")?CompressFormat.png:CompressFormat.jpeg
    );
    print('before');
    print(file.lengthSync());
    print(file.path);
    print(file.absolute.path);
    print('after');
    print(result!.length().toString());
    print(result.path);
    return result;
  }

  sendRequest(Requests data, BuildContext context) async {
    _isLoading=true;
    notifyListeners();
    await AlertView(context,ImagesName.success,
        Translations.of(context)!.Ok,
        Translations.of(context)!.success);
    _isLoading=false;
    notifyListeners();
  }

  Future<void> addMoney(Requests data, BuildContext context) async {
    _isLoading=true;
    notifyListeners();
    await AlertView(context,ImagesName.success,
    Translations.of(context)!.Ok,
    Translations.of(context)!.success);
    _isLoading=false;
    notifyListeners();
  }

  void setSelectedPaymentMethods(PaymentMethodsData? value) {
_SelectedPaymentMethods=value!;
    notifyListeners();
  }

  ChangeAmount(String value, BuildContext context) async {
    if (value != null && value.isNotEmpty) {
      var res = double.tryParse(value);
      if (res != null && res >0) {
      }
      else {

          _AmountController.text = "";
        FocusScope.of(context).unfocus();
        await AlertView(context,  "warning",
        Translations.of(context)!.please,
        Translations.of(context)!.vaildNum);
      }
    }
    else {

        _AmountController.text = "";
    }
    notifyListeners();
  }

  show(Requests data,BuildContext context) {
    data.order_type_id= value;
    notifyListeners();
    Navigator.pushNamed(context, Show_Order_Route,arguments: data);
  }

}