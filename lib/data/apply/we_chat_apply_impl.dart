import 'package:stream_transform/stream_transform.dart';
import 'package:we_chat/data/apply/we_chat_apply.dart';
import 'package:we_chat/data/vos/message_vo/message_vo.dart';
import 'package:we_chat/data/vos/user_vo/user_vo.dart';
import 'package:we_chat/network/data_agent/cloud_fire_store_database/cloud_fire_store_database_impl.dart';
import 'package:we_chat/network/data_agent/fire_base_auth/fire_base_authentication.dart';
import 'package:we_chat/network/data_agent/fire_base_auth/fire_base_authentication_impl.dart';
import 'package:we_chat/network/data_agent/cloud_fire_store_database/cloud_fire_store_database.dart';
import 'package:we_chat/network/data_agent/real_time_database/real_time_database.dart';
import 'package:we_chat/network/data_agent/real_time_database/real_time_database_impl.dart';
import 'package:we_chat/persistent/we_chat_dao/we_chat_dao.dart';
import 'package:we_chat/persistent/we_chat_dao/we_chat_dao_impl.dart';

class WeChatApplyImpl extends WeChatApply{
  final FirebaseAuthentication _authentication=FirebaseAuthenticationImpl();
  final CloudFireStoreDatabase _cloudFireStore=CloudFireStoreDatabaseImpl();
  final RealTimeDataBase _realTimeDataBase=RealTimeDatabaseImpl();
  final WeChatDAO _weChatDAO=WeChatDAOImpl();

  @override
  Future<String> registerNewUser(UserVO user) =>_authentication.registerNewUser(user);

  @override
  Future<String> login(String email,String password)=>_authentication.login(email, password);

  @override
  bool isLoggedIn()=>_authentication.isLoggedIn();

  @override
  Future<UserVO?> getLoggedInUserVO()=>_authentication.getLoggedInUserVO();

  @override
  Future logOut()=>_authentication.logOut();

  @override
  Future<UserVO?> getUserVO(String? id)=>_cloudFireStore.getUserVO(id);

  @override
  Future<void> addContact(UserVO friendVO)=>_cloudFireStore.addContact(friendVO);

  @override
  Future<bool> checkIfAlreadyFriend(String friendId)=>_cloudFireStore.checkIfAlreadyFriend(friendId);

  @override
  Stream<List<UserVO>?> getFriendListAsStream()=>_cloudFireStore.getFriendListAsStream();

  @override
  Stream<List<MessageVO>?> getMessages(String friendId)=>_realTimeDataBase.getMessages(friendId);

  @override
  Future sendMessage(String friendId, MessageVO messageVO)=>_realTimeDataBase.sendMessage(friendId, messageVO);

  @override
  String? getLoggedInUserId()=>_authentication.getLoggedInUserId();

  @override
  Stream<List<String>?> getChattingFriends()=>_realTimeDataBase.getChattingFriends();

  @override
  Future<MessageVO> getLastMessage(String friendId)=>_realTimeDataBase.getLastMessage(friendId);


  @override
  Stream<List<UserVO>?> getUsersFromBoxAsStream()=>_weChatDAO
      .watchBox()
      .startWith(_weChatDAO.getUsersFromBoxAsStream())
      .map((event) => _weChatDAO.getUsersFromBox());

  @override
  void save(UserVO userAcc)=>_weChatDAO.save(userAcc);

  @override
  void clearBox()=>_weChatDAO.clearBox();

  @override
  Future<void> deleteMessage(String friendId, String messageId)=>_realTimeDataBase.deleteMessage(friendId, messageId);




}