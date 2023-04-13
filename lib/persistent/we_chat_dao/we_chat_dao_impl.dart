import 'package:hive/hive.dart';
import 'package:we_chat/constant/hive_constant.dart';
import 'package:we_chat/data/vos/user_vo/user_vo.dart';
import 'package:we_chat/persistent/we_chat_dao/we_chat_dao.dart';

class WeChatDAOImpl extends WeChatDAO{
  WeChatDAOImpl._();
  static final _singleton=WeChatDAOImpl._();
  factory WeChatDAOImpl()=>_singleton;

  Box<UserVO>_getWeChatUserBox()=>Hive.box<UserVO>(kWeChatHiveBoxName);

  @override
  List<UserVO>? getUsersFromBox()=>_getWeChatUserBox().values.toList();

  @override
  Stream<List<UserVO>?> getUsersFromBoxAsStream()=>Stream.value(getUsersFromBox());

  @override
  void save(UserVO userAcc)=>_getWeChatUserBox()
      .put(userAcc.id, userAcc);

  @override
  Stream watchBox() =>_getWeChatUserBox().watch();

  @override
  void clearBox()=>_getWeChatUserBox().clear();
}