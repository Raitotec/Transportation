
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
import '../Api/ExpenseApi.dart';
import '../Api/OrderApi.dart';
import '../Constants/Localization/LanguageData.dart';
import '../Constants/Localization/Translations.dart';
import '../Models/OrderModel.dart';
import '../Models/PaymentMethodsData.dart';
import '../Shared_Data/formatDateTime.dart';
import '../Shared_View/AlertView.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ExpensesViewModel extends ChangeNotifier {

  static ExpensesViewModel? _instance;
  static ExpensesViewModel get instance => _instance!;

  static void setInstance(ExpensesViewModel viewModel) {
    _instance = viewModel;
  }

  bool _isLoading = false;
  bool _checkVersion = false;
  List<Requests> _CurrentItems = <Requests>[];
  List<Requests> get CurrentItems => _CurrentItems;
  bool get isLoading => _isLoading;
  bool get checkVersion => _checkVersion;
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
  Requests? _currentRequest;
  Requests? get currentRequest => _currentRequest;

  Future<void> GetData(BuildContext context) async {
    _isLoading = true;
    _SelectedPaymentMethods=null;
    _AmountController.clear();
    _images_invoice = <File>[];
    _images_path_invoice=<String>[];
    try {
      var x = await GetRequetFun(context);
      if (x != null) {
        if (x.currentRequests != null && x.currentRequests!.isNotEmpty) {
          _CurrentItems = x.currentRequests!;
        }
      }
      else {
        _CurrentItems =  [];
      }
    }
    catch (e) {
      _isLoading = false;
    }

    var y = await GetExpenseTypesFun(context);
    if (y != null && y.isNotEmpty) {
      _MyPaymentMethodsList = y;
    }

    _isLoading = false;
  }
  Future<void> Get_Data() async {
    _isLoading = true;
    _SelectedPaymentMethods=null;
    _AmountController.clear();
    _images_invoice = <File>[];
    _images_path_invoice=<String>[];
    notifyListeners();
    try {
      var x = await GetRequet_Fun();
      if (x != null) {
        if (x.currentRequests != null && x.currentRequests!.isNotEmpty) {
          _CurrentItems = x.currentRequests!;
        }
      }
      else {
        _CurrentItems =  [];
      }
    }
    catch (e) {
      _isLoading = false;
    }

    var y = await GetExpenseTypes_Fun();
    if (y != null && y.isNotEmpty) {
      _MyPaymentMethodsList = y;
    }

    _isLoading = false;
    notifyListeners();
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



  Future<void> pickImages(bool load) async {
    try {

      _isLoading=true;
      _images_invoice = <File>[];
      _images_path_invoice=<String>[];
      notifyListeners();
      ImagePicker _picker = ImagePicker();
      XFile? resultList = await _picker.pickImage(source: ImageSource.camera);
      print(resultList!.path);
      var compress_File = await compressFile(File(resultList!.path));
      if(load==true) {
        print("&&&&");
        print(compress_File!.path);
        _images_invoice.add(File(compress_File!.path));
        _images_path_invoice.add(compress_File.path);
      }
      else
        {
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

  Future<void> addMoney(Requests data, BuildContext context) async {
    _isLoading=true;
    notifyListeners();
    if(AmountController.text.isNotEmpty&&SelectedPaymentMethods!= null && images_path_invoice.isNotEmpty) {
      var x = await addExpensesFun(context,
          currentRequest!.id.toString(), AmountController.text,
          SelectedPaymentMethods!.id.toString(), images_path_invoice);
      if (x != null) {
        Navigator.pushNamedAndRemoveUntil(context, ExpensesRoute, (Route<dynamic> r) => false);
      }
    }
    else
      {
        AlertView(context, "error", Translations.of(context)!.Please,  Translations.of(context)!.enterData);
      }
    _isLoading=false;
    notifyListeners();
  }

  void setSelectedPaymentMethods(PaymentMethodsData? value) {
    _SelectedPaymentMethods=value!;
    notifyListeners();
  }

  ChangeAmount(String value, BuildContext context) async {
    if (value.isNotEmpty) {
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

  Future<void> showExpensee(Requests data,BuildContext context) async{
    _images_invoice = <File>[];
    _images_path_invoice=<String>[];
    _currentRequest=data;
    _SelectedPaymentMethods=null;
    _AmountController.clear();
    notifyListeners();
    Navigator.pushNamed(context, Show_Expenses_Route);
  }

}