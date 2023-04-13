import 'package:flutter/material.dart';
import 'package:we_chat/data/vos/user_vo/user_vo.dart';
import '../data/apply/we_chat_apply.dart';
import '../data/apply/we_chat_apply_impl.dart';

class QrScannedProfilePageBloc extends ChangeNotifier{
  ////////////////////////////////////////////
  /////////////////Instances//////////////////
  ////////////////////////////////////////////
  final WeChatApply _apply=WeChatApplyImpl();


  ////////////////////////////////////////////
  /////////////////Attributes/////////////////
  ////////////////////////////////////////////
  bool _isDispose=false;
  String _username='';
  String _profilePic='';
  UserVO ? _friendVO;
  bool _alreadyFri=false;

  ////////////////////////////////////////////
  /////////////////Getters////////////////////
  ////////////////////////////////////////////
  String get getProfilePic=>_profilePic;
  String get getUsername=>_username;
  UserVO ? get getFriendVO=>_friendVO;
  bool get getAlreadyFri=>_alreadyFri;

  ////////////////////////////////////////////
  /////////////////Setters////////////////////
  ////////////////////////////////////////////



  ////////////////////////////////////////////
  /////////////////Methods////////////////////
  ////////////////////////////////////////////
  void addToContact()=>_apply.addContact(_friendVO!).whenComplete(() => _alreadyFri=false);

  Future<bool> checkIfAlreadyFriends(String friendId)=>_apply.checkIfAlreadyFriend(friendId).then((value) => _alreadyFri=value);

  ////////////////////////////////////////////
  /////////////////Constructor////////////////
  ////////////////////////////////////////////
  QrScannedProfilePageBloc(String ? id){
    _apply.getUserVO(id).then((value){
      _friendVO=value;
      _username=value?.userName??'';
      _profilePic=value?.profilePic??'';
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