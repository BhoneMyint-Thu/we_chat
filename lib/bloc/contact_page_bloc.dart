import 'package:flutter/material.dart';
import '../data/apply/we_chat_apply.dart';
import '../data/apply/we_chat_apply_impl.dart';
import '../data/vos/user_vo/user_vo.dart';

class ContactPageBloc extends ChangeNotifier {
  ////////////////////////////////////////////
  /////////////////Instances//////////////////
  ////////////////////////////////////////////
  final WeChatApply _apply = WeChatApplyImpl();

  ////////////////////////////////////////////
  /////////////////Attributes/////////////////
  ////////////////////////////////////////////
  bool _isDispose = false;
  List<UserVO> _friendList = [];

  ////////////////////////////////////////////
  /////////////////Getters////////////////////
  ////////////////////////////////////////////
  List<UserVO> get getFriendList => _friendList;


  ////////////////////////////////////////////
  /////////////////Constructor////////////////
  ////////////////////////////////////////////
  ContactPageBloc() {
    _apply.getFriendListAsStream().listen((event) {
      final temp=event??[];
      temp.sort((a,b)=>a.userName!.compareTo(b.userName!));
      _friendList=temp;
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
