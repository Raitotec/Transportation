
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:transportation/Constants/Routes/route_constants.dart';
import 'package:transportation/Constants/assets/Images_Name.dart';
import '../Api/ExpenseApi.dart';
import '../Api/OrderApi.dart';
import '../Constants/Localization/LanguageData.dart';
import '../Constants/Localization/Translations.dart';
import '../Models/OrderModel.dart';
import '../Models/PaymentMethodsData.dart';
import '../PushNotificationService/ForFirebaseNotifyApi.dart';
import '../PushNotificationService/NotifactionViewModel.dart';
import '../Shared_Data/DelegateData.dart';
import '../Shared_Data/formatDateTime.dart';
import '../Shared_View/AlertView.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

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
  Requests? _currentRequest;
  Requests? get currentRequest => _currentRequest;

  Future<void> GetData(BuildContext context) async {

    checkVersionFun(context);
    _isLoading = true;
    _images_load = <File>[];
    _images_path_load = <String>[];
    _images_delivery = <File>[];
    _images_path_delivery = <String>[];
    _CurrentItems = _LaterItems = _EndItems = [];
    Provider.of<NotifactionViewModel>(context, listen: false).Refresh();
    try
    {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      await ForFirebaseNotifyFun(context, DelegateData.delegateData!.user!.id.toString(), fcmToken!);
    }
    catch(e){

    }
    try {
      var x = await GetRequetFun(context);
      if (x != null) {
        if (x.currentRequests != null && x.currentRequests!.isNotEmpty) {
          _CurrentItems = x.currentRequests!;
        }
        if (x.scheduledRequests != null && x.scheduledRequests!.isNotEmpty) {
          _LaterItems = x.scheduledRequests!;
        }
        if (x.pastRequests != null && x.pastRequests!.isNotEmpty) {
          _EndItems = x.pastRequests!;
        }
      }
      else {
        _CurrentItems = _LaterItems = _EndItems = [];
      }
    }
    catch (e) {
      _isLoading = false;
    }
    _isLoading = false;
  }


  Future<void> Refresh(BuildContext context) async {
    print("*************Refresh");
   _isLoading=true;
    notifyListeners();
    try
    {
     await GetData(context);
    }
    catch(e)
    {
      _isLoading=false;
      notifyListeners();
    }

    _isLoading=false;
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
      XFile? resultList = await _picker.pickImage(source: ImageSource.camera);
      print(resultList!.path);
      var compress_File = await compressFile(File(resultList!.path));
      if(load==true) {
        print("&&&&");
        print(compress_File!.path);
        _images_load.add(File(compress_File!.path));
        _images_path_load.add(compress_File.path);
      }
      else
        {
          _images_delivery.add(File(compress_File!.path));
          _images_path_delivery.add(compress_File.path);
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


  Future<File?> compressFile(File file) async {
    try {
      final filePath = file.absolute.path;
      final lastIndex = filePath.lastIndexOf('.');
      final extension = filePath.substring(lastIndex + 1);
      final outPath = "${filePath.substring(0, lastIndex)}_out_${DateTime.now().millisecondsSinceEpoch}.$extension";

      final compressed = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        outPath,
        quality: 25,
        format: extension.toLowerCase().contains("png") ? CompressFormat.png : CompressFormat.jpeg,
      );

      if (compressed == null) return null;

      // ✅ Move to permanent directory
      final appDir = await getApplicationDocumentsDirectory();
      final savedPath = join(appDir.path, basename(compressed.path));
      File compressedFile = File(compressed.path);
      File savedFile = await compressedFile.copy(savedPath);


      return savedFile;
    } catch (e) {
      print("Error compressing file: $e");
      return null;
    }
  }



  Future<void> show(Requests data,BuildContext context) async{
    print('*************'+value.toString());
    _images_load = <File>[];
    _images_path_load=<String>[];
    _images_delivery = <File>[];
    _images_path_delivery=<String>[];
    _currentRequest=data;
    notifyListeners();
    Navigator.pushNamed(context, Show_Order_Route);
  }

  Future<void> saveRequest( BuildContext context) async {
    _isLoading=true;
    notifyListeners();
    var x= await addRequetFun(context, currentRequest!.id.toString(),images_path_load,images_path_delivery);
    if(x != null) {
      _currentRequest = x;
      _images_load = <File>[];
      _images_path_load = <String>[];
      _images_delivery = <File>[];
      _images_path_delivery = <String>[];
      notifyListeners();
      if (value == 0) {
      var i= CurrentItems.indexWhere((e)=>e.id==x.id);
      if(i != -1)
        {
          CurrentItems[i]= x;
          notifyListeners();
        }
      }
    }
    _isLoading=false;
    notifyListeners();
  }
 Future<void> sendRequest( BuildContext context) async {
    _isLoading=true;
    notifyListeners();

    var x= await endRequetFun(context, currentRequest!.id.toString(), images_path_load,images_path_delivery);
    if(x != null)
    {
      /*_currentRequest= x;
      _images_load = <File>[];
      _images_path_load=<String>[];
      _images_delivery = <File>[];
      _images_path_delivery=<String>[];
      notifyListeners();*/
      Navigator.pushNamedAndRemoveUntil(context, MainRoute,(Route<dynamic> r)=>false);
    }
    _isLoading=false;
    notifyListeners();
  }



}