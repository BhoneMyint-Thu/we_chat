
import 'package:flutter/cupertino.dart';

import '../data/apply/we_chat_apply.dart';
import '../data/apply/we_chat_apply_impl.dart';
import '../data/vos/user_vo/user_vo.dart';

class RegisterEmailPageBloc extends ChangeNotifier{
  ////////////////////////////////////////////
  /////////////////Instances/////////////////
  ////////////////////////////////////////////
  final WeChatApply _apply=WeChatApplyImpl();
  final TextEditingController _emailTextController=TextEditingController();
  final FocusNode _emailFocusNode=FocusNode();


  ////////////////////////////////////////////
  /////////////////Attributes/////////////////
  ////////////////////////////////////////////
  bool _isDispose=false;
  String _errorMessage='';
  bool _isLoading=false;

  ////////////////////////////////////////////
  /////////////////getters////////////////////
  ////////////////////////////////////////////
  TextEditingController get getEmailTextController=>_emailTextController;

  String get getErrorMessage=>_errorMessage;

  bool get getIsLoading=>_isLoading;

  FocusNode get getEmailFocusNode=>_emailFocusNode;

  ////////////////////////////////////////////
  /////////////////Methods////////////////////
  ////////////////////////////////////////////
  Future<String> registerNewUser(UserVO newUser) {
    changeLoadingValue();
    return _apply.registerNewUser(newUser).then((value) => _errorMessage = value);
  }

  void changeLoadingValue(){
    _isLoading=true;
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