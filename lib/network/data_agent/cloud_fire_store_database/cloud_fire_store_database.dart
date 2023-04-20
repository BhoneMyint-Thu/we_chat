import 'package:we_chat/data/vos/user_vo/user_vo.dart';

abstract class CloudFireStoreDatabase{
  Future<void> createNewUser(UserVO user);

  Future<UserVO?> getUserVO(String? id);

  String ? getLoggedInUserId();

  Future<void> addContact(UserVO friendVO);

  Future<bool> checkIfAlreadyFriend(String friendId);

  Stream<List<UserVO>?> getFriendListAsStream();

  Future<String> updateProfilePic(String id,String ? profilePic);

  Future<String?> deleteProfilePic(String id);

}