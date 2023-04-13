import 'package:flutter/material.dart';
import '../data/apply/we_chat_apply.dart';
import '../data/apply/we_chat_apply_impl.dart';
import '../data/vos/user_vo/user_vo.dart';

class ChatPageBloc extends ChangeNotifier {
  ////////////////////////////////////////////
  /////////////////Instances//////////////////
  ////////////////////////////////////////////
  final WeChatApply _apply = WeChatApplyImpl();

  ////////////////////////////////////////////
  /////////////////Attributes/////////////////
  ////////////////////////////////////////////
  bool _isDispose = false;
  List<UserVO> _chattingFriends=[];
  String _loggedInUserId='';

  ////////////////////////////////////////////
  /////////////////Getters////////////////////
  ////////////////////////////////////////////
  List<UserVO> get getChattingFriends=>_chattingFriends;
  String get getLoggedInUserId=>_loggedInUserId;




  ////////////////////////////////////////////
  /////////////////Constructor////////////////
  ////////////////////////////////////////////
  ChatPageBloc(){
    _loggedInUserId=_apply.getLoggedInUserId()??'';
    _apply.getChattingFriends().listen((event) async {
      _chattingFriends.clear();
      final chattingFriList=event??[];
      for(var chattingFri in chattingFriList){
        await _apply.getUserVO(chattingFri).then((chatUserVO) async {
         await _apply.getLastMessage(chattingFri).then((lastMsg){
            chatUserVO?.lastSentMessage=lastMsg.message;
            chatUserVO?.lastMessageTime=lastMsg.dateTime;
            chatUserVO?.lastMessageSenderId=lastMsg.senderId;
            _chattingFriends.add(chatUserVO!);
          });
        });
      }
      _chattingFriends.sort((a,b)=>(b.lastMessageTime??DateTime.now()).compareTo(a.lastMessageTime??DateTime.now()));
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
