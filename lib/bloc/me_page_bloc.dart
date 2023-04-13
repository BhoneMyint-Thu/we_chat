import 'package:flutter/material.dart';
import '../data/apply/we_chat_apply.dart';
import '../data/apply/we_chat_apply_impl.dart';
import '../data/vos/user_vo/user_vo.dart';

class MePageBloc extends ChangeNotifier{
  ////////////////////////////////////////////
  /////////////////Instances//////////////////
  ////////////////////////////////////////////
  final WeChatApply _apply=WeChatApplyImpl();

  ////////////////////////////////////////////
  /////////////////Attributes/////////////////
  ////////////////////////////////////////////
  bool _isDispose=false;
  UserVO ? _userAccToBox;
  String _username='';
  String _profilePic='';
  String _userQrCode='';

  ////////////////////////////////////////////
  /////////////////Getters////////////////////
  ////////////////////////////////////////////

  String get getProfilePic=>_profilePic;
  String get getUsername=>_username;
  String get getUserQrCode=>_userQrCode;
  UserVO ? get getUserAccToBox=>_userAccToBox;


  ////////////////////////////////////////////
  /////////////////Methods////////////////////
  ////////////////////////////////////////////
  void addUserToBox(UserVO userAcc)=>_apply.save(userAcc);
  Future logOut()=>_apply.logOut();

  ////////////////////////////////////////////
  /////////////////Constructor////////////////
  ////////////////////////////////////////////
  MePageBloc(){
      _apply.getLoggedInUserVO().then((value) {
        _userAccToBox=value;
        _profilePic = value?.profilePic ?? '';
        _username=value?.userName??'';
        _userQrCode=value?.id??'';
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