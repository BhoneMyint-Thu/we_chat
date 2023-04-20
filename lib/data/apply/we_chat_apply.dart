import '../vos/message_vo/message_vo.dart';
import '../vos/user_vo/user_vo.dart';

abstract class WeChatApply{
  Future<String> registerNewUser(UserVO user);

  Future<String> login(String email,String password);

  bool isLoggedIn();

  Future<UserVO?> getLoggedInUserVO();

  Future logOut();

  Future<UserVO?> getUserVO(String? id);

  Future<void> addContact(UserVO friendVO);

  Future<bool> checkIfAlreadyFriend(String friendId);

  Stream<List<UserVO>?> getFriendListAsStream();

  Future sendMessage(String friendId,MessageVO messageVO);

  Stream<List<MessageVO>?> getMessages(String friendId);

  String ? getLoggedInUserId();

  Stream<List<String>?> getChattingFriends();

  Future<MessageVO> getLastMessage(String friendId);

  void save(UserVO userAcc);

  void clearBox();

  Stream<List<UserVO>?> getUsersFromBoxAsStream();

  Future<void> deleteMessage(String friendId,String messageId);

  Future<String> updateProfilePic(String ? profilePic);

  Future<void> deleteProfilePic();


}