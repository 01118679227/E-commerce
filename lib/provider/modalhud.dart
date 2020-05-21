import 'package:flutter/material.dart';
class ModelHud extends ChangeNotifier{
  bool isLoading = false;
  ChangeIsLoading(bool value){
    isLoading = value;
    notifyListeners();
  }
}