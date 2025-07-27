import 'package:flutter/material.dart';

import 'ForFirebaseNotifyApi.dart';
import 'NotificationModel.dart';

class NotifactionViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<NotificationModel> _Items = <NotificationModel>[];
  List<NotificationModel> get Items => _Items;

  int get totalCartCount {
    return Items.length;
  }
  Future<void> GetData(BuildContext context) async
  {
    _isLoading= true;
    var x= await GetNotifications(context);
    if( x!= null && x.isNotEmpty)
      {
        _Items= x;
      }
    _isLoading= false;
  }

  Future<void> Refresh(BuildContext context) async {
    _isLoading= true;
    notifyListeners();
    await GetData(context);
    _isLoading= false;
    notifyListeners();
  }

}