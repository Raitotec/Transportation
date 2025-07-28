import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:transportation/Constants/Localization/LanguageData.dart';

import 'ForFirebaseNotifyApi.dart';
import 'NotificationModel.dart';

class NotifactionViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _totalCartCount = 0;
  int get totalCartCount => _totalCartCount;

  static NotifactionViewModel? _instance;
  static NotifactionViewModel get instance => _instance!;

  static void setInstance(NotifactionViewModel viewModel) {
    _instance = viewModel;
  }

  static const int _pageSize = 10;
  final PagingController<int, NotificationModel> pagingController =
  PagingController(firstPageKey: 1);

  NotifactionViewModel() {
    pagingController.addPageRequestListener((pageKey) {
      fetchNotifications(pageKey);
    });
  }

  Future<void> fetchNotifications(int pageKey) async {
    _isLoading = true;
    notifyListeners();

    var parsedResponse = await GetNotifications(pageKey.toString());

    if (parsedResponse != null) {
      _totalCartCount = parsedResponse.count;

      final isLastPage = pageKey >= parsedResponse.lastPage;
      final newItems = parsedResponse.notifications;

      final existingIds = pagingController.itemList?.map((e) => e.id).toSet() ?? {};
      final uniqueItems = newItems.where((item) => !existingIds.contains(item.id)).toList();


      if (isLastPage || uniqueItems.isEmpty) {
        pagingController.appendLastPage(uniqueItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(uniqueItems, nextPageKey);
      }
    } else {
      pagingController.error = LanguageData.languageData=="ar"?'فشل في تحميل البيانات':"error to load data";
    }

    _isLoading = false;
    notifyListeners();
  }

  void refresh() {
    pagingController.refresh();
  }

  Future<void> Refresh() async {
    print("*******************Refresh");
    fetchNotifications(1);
    pagingController.refresh();
  }

 Future<void> Read(NotificationModel item)async {
    try {
      _isLoading=true;
      notifyListeners();
      final currentList = pagingController.itemList;
      var index = currentList!.indexWhere((e) => e.id == item.id);
      currentList.removeAt(index);
      pagingController.itemList = List.from(currentList);
       await NotificationRead(item.id.toString());
      _isLoading=false;
      notifyListeners();
    }
    catch(e){
      _isLoading=false;
      notifyListeners();
    }
  }
}
