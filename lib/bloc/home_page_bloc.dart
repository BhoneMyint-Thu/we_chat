import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/utils/enums.dart';

class HomePageBloc extends ChangeNotifier{
  ////////////////////////////////////////////
  /////////////////Attributes/////////////////
  ////////////////////////////////////////////
  bool _isDispose=false;
  int _currentIndex=WeChatPages.values.first.index;

  ////////////////////////////////////////////
  /////////////////Getters////////////////////
  ////////////////////////////////////////////
  int get getCurrentIndex=>_currentIndex;

  ////////////////////////////////////////////
  /////////////////Methods////////////////////
  ////////////////////////////////////////////

  void changePage(int index){
    _currentIndex=index;
    notifyListeners();
  }





  @override
  void notifyListeners() {
    if (!_isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }
}