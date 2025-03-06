import 'package:flutter/foundation.dart';

import '../Api/UserApi.dart';
import '../Models/User.dart';


class UserViewModel extends ChangeNotifier {
  final UserApi _api = UserApi();

  List<User> _names = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<User> get names => _names;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  UserViewModel() {
    fetchNames();
  }

  Future<void> fetchNames() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      var x = await _api.getNames();
      if(x != null && x.length>0)
        {
          _names=x;
        }
      else
        {
          _names=[];
          _errorMessage = 'No Data. Please try again.';
        }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to fetch names. Please try again.';
      notifyListeners();
    }
  }

  Future<void> edit(int index)
  async {
    if(_names != null && _names.length>0)
      {
        _names[index].email="edit"+_names[index].email;
        notifyListeners();
      }

  }
}