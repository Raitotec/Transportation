import 'package:flutter/material.dart';

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
    _isLoading= false;
  }

}