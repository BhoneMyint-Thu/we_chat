import 'package:we_chat/data/vos/message_vo/message_vo.dart';

abstract class RealTimeDataBase{
  Future sendMessage(String friendId,MessageVO messageVO);

  Stream<List<MessageVO>?> getMessages(String friendId);

  Stream<List<String>?> getChattingFriends();

  Future<MessageVO> getLastMessage(String friendId);
}
