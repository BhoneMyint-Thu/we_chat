import 'package:flutter/material.dart';
import 'package:we_chat/data/apply/we_chat_apply_impl.dart';
import 'package:we_chat/data/vos/user_vo/user_vo.dart';

import '../data/apply/we_chat_apply.dart';

class LoginPageBloc extends ChangeNotifier{
  ////////////////////////////////////////////
  /////////////////Instances//////////////////
  ////////////////////////////////////////////
  final WeChatApply _apply=WeChatApplyImpl();
  final TextEditingController _textControllerEmail=TextEditingController();
  final TextEditingController _textControllerPassword=TextEditingController();

  ////////////////////////////////////////////
  /////////////////Attributes/////////////////
  ////////////////////////////////////////////
  bool _isDispose=false;
  String _errorMessage='';
  bool _loading=false;
  List<UserVO> _usersFromBox=[];

  ////////////////////////////////////////////
  /////////////////Getters////////////////////
  ////////////////////////////////////////////
  TextEditingController get getEmailTextController=>_textControllerEmail;
  TextEditingController get getPasswordTextController=>_textControllerPassword;
  String get getErrorMessage=>_errorMessage;
  bool get getIsLoading=>_loading;
  List<UserVO> get getUsersFromBox=>_usersFromBox;



  ////////////////////////////////////////////
  /////////////////Methods////////////////////
  ////////////////////////////////////////////
  void clearBoxf()=>_apply.clearBox();

  void addUserToBox(UserVO userAcc)=>_apply.save(userAcc);

  void changeLoadingValue(){
    _loading=true;
  }

  Future<String> login(String email,String password) {
    changeLoadingValue();
    return _apply.login(email, password).then((value) => _errorMessage = value);
  }

  ////////////////////////////////////////////
  /////////////////constructor////////////////
  ////////////////////////////////////////////
  LoginPageBloc(){
    _apply.getUsersFromBoxAsStream().listen((event) {
      _usersFromBox=event??[];
      notifyListeners();
    });
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