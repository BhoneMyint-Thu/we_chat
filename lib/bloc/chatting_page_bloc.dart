import 'package:flutter/material.dart';
import '../data/apply/we_chat_apply.dart';
import '../data/apply/we_chat_apply_impl.dart';
import '../data/vos/message_vo/message_vo.dart';

class ChattingPageBloc extends ChangeNotifier {
  ////////////////////////////////////////////
  /////////////////Instances//////////////////
  ////////////////////////////////////////////
  final WeChatApply _apply = WeChatApplyImpl();
  final TextEditingController _textEditingController=TextEditingController();
  final ScrollController _scrollController=ScrollController();

  ////////////////////////////////////////////
  /////////////////Attributes/////////////////
  ////////////////////////////////////////////
  bool _isDispose = false;
  List<MessageVO> _messages=[];

  ////////////////////////////////////////////
  /////////////////Getters////////////////////
  ////////////////////////////////////////////
  List<MessageVO> get getMessages=>_messages;

  TextEditingController get getTextController=>_textEditingController;

  ScrollController get getScrollController=>_scrollController;


  ////////////////////////////////////////////
  /////////////////Methods////////////////////
  ////////////////////////////////////////////
  MessageVO createMessage(){
   return  MessageVO(_textEditingController.text, DateTime.now(),_apply.getLoggedInUserId());
  }

  Future sendMessage(String friendId)=>_apply.sendMessage(friendId, createMessage()).whenComplete(() => _scrollToBottom());

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }



  ////////////////////////////////////////////
  /////////////////Constructor////////////////
  ////////////////////////////////////////////
  ChattingPageBloc(String friendId){
    _apply.getMessages(friendId).listen((event) {
      final temp=event??[];
      _messages=temp;
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
