import 'package:we_chat/data/vos/message_vo/message_vo.dart';
import 'package:we_chat/data/vos/post_vo/post_vo.dart';

abstract class RealTimeDataBase{
  Future sendMessage(String friendId,MessageVO messageVO);

  Stream<List<MessageVO>?> getMessages(String friendId);

  Stream<List<String>?> getChattingFriends();

  Future<MessageVO> getLastMessage(String friendId);

  Future<void> deleteMessage(String friendId,String messageId);

  Future<void> createPost(PostVO post);
}
