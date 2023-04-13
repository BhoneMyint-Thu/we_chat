import 'package:we_chat/data/vos/user_vo/user_vo.dart';

abstract class WeChatDAO{
  void save(UserVO userAcc);

  Stream watchBox();

  List<UserVO>? getUsersFromBox();

  Stream<List<UserVO>?> getUsersFromBoxAsStream();

  void clearBox();
}