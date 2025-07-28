import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'ForFirebaseNotifyApi.dart';
import 'NotificationModel.dart';

class NotifactionViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<NotificationModel> _notifications = <NotificationModel>[];

  List<NotificationModel> get notifications => _notifications;
  int _totalCartCount = 0;
  int get totalCartCount => _totalCartCount;

  static NotifactionViewModel? _instance;

  static NotifactionViewModel get instance => _instance!;

  static void setInstance(NotifactionViewModel viewModel) {
    _instance = viewModel;
  }

  int currentPage = 1;
  int lastPage = 1;

  Future<void> fetchNotifications(BuildContext context,
      {bool loadMore = false}) async {


    if (isLoading || currentPage > lastPage) return;


    _isLoading = true;
    notifyListeners();

    var parsedResponse = await GetNotifications(context, currentPage.toString());
    if (parsedResponse != null) {
      if (!loadMore) {
        _notifications = parsedResponse!.notifications;
      } else {
        _notifications.addAll(parsedResponse!.notifications);
      }
      currentPage = parsedResponse.currentPage + 1;
      lastPage = parsedResponse.lastPage;
      _totalCartCount= parsedResponse.count;
    }

  _isLoading = false;
  notifyListeners();

}



  Future<void> Refresh(BuildContext context) async {
    _isLoading= true;
      currentPage = 1;
      lastPage = 1;
    notifyListeners();
    await fetchNotifications(context);
    _isLoading= false;
    notifyListeners();
  }


  Future<void> RefreshCount() async {
    _isLoading= true;
    notifyListeners();
    var x= await Get_count_unread_notifications();
    if( x!= null )
    {
      _totalCartCount= x;
    }
    _isLoading= false;
    notifyListeners();
  }

}