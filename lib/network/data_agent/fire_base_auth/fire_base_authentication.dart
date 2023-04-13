import 'package:we_chat/data/vos/user_vo/user_vo.dart';

abstract class FirebaseAuthentication{
  Future<String> registerNewUser(UserVO user);

  Future<String> login(String email,String password);

  Future logOut();

  bool isLoggedIn();

  String ? getLoggedInUserId();

  Future<UserVO?> getLoggedInUserVO();
}