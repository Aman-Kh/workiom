import 'package:flutter/material.dart';

class BaseProvider with ChangeNotifier{
  bool _isBusy = false;
  bool get isBusy => _isBusy;

  void setBusy(bool busy){
    _isBusy = busy;
    notifyListeners();
  }

  String _errorText = '';
  String get errorText => _errorText;
  void setErrorText(String newText) {
    _errorText = newText;
    notifyListeners();
  }
}