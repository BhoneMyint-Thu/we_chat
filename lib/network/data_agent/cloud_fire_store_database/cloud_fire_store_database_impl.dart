import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_chat/data/vos/user_vo/user_vo.dart';
import 'package:we_chat/network/data_agent/cloud_fire_store_database/cloud_fire_store_database.dart';
import 'package:we_chat/network/data_agent/fire_base_storage/fire_storage.dart';
import 'package:we_chat/network/data_agent/fire_base_storage/fire_storage_impl.dart';

import '../../../constant/strings.dart';

class CloudFireStoreDatabaseImpl extends CloudFireStoreDatabase {
  CloudFireStoreDatabaseImpl._();

  static final _singleton = CloudFireStoreDatabaseImpl._();

  factory CloudFireStoreDatabaseImpl() => _singleton;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;
  final FireStorage _fireStorage=FireStorageImpl();

  @override
  Future<void> createNewUser(UserVO user) => _firebaseFirestore
      .collection(kRootNodeForUsers)
      .doc(user.id)
      .set(user.toJson());

  @override
  Future<UserVO?> getUserVO(String? id) => _firebaseFirestore
      .collection(kRootNodeForUsers)
      .doc(id)
      .get()
      .asStream()
      .map((event) => UserVO.fromJson(event.data() ?? {}))
      .first;

  @override
  String? getLoggedInUserId() => auth.currentUser?.uid;

  @override
  Future<void> addContact(UserVO friendVO) async {
    getUserVO(getLoggedInUserId()).then((value) {
      _firebaseFirestore
          .collection(kRootNodeForUsers)
          .doc(getLoggedInUserId())
          .collection(kContactNode)
          .doc(friendVO.id)
          .set(friendVO.toJson());

      _firebaseFirestore
          .collection(kRootNodeForUsers)
          .doc(friendVO.id)
          .collection(kContactNode)
          .doc(getLoggedInUserId())
          .set(value?.toJson() ?? {});
    });
  }

  @override
  Future<bool> checkIfAlreadyFriend(String friendId) => _firebaseFirestore
      .collection(kRootNodeForUsers)
      .doc(getLoggedInUserId())
      .collection(kContactNode)
      .doc(friendId)
      .get()
      .then((value) => value.exists);

  @override
  Stream<List<UserVO>?> getFriendListAsStream() => _firebaseFirestore
          .collection(kRootNodeForUsers)
          .doc(getLoggedInUserId())
          .collection(kContactNode)
          .snapshots()
          .map((event) {
        return event.docs.map((e) {
          return UserVO.fromJson(e.data());
        }).toList();
      });

  @override
  Future<String> updateProfilePic(String id,String ? profilePic) async {
    String ? newProfilePic;
    await _fireStorage.upLoadFileToFirebaseStorage(File(profilePic??''), id).then((value) => newProfilePic=value);
    return _firebaseFirestore
        .collection(kRootNodeForUsers)
        .doc(id)
        .get()
        .asStream()
        .map((event) {
      return UserVO.fromJson(event.data() ?? {}).profilePic = newProfilePic ?? '';
    }).first;
  }

  @override
  Future<String?> deleteProfilePic(String id) async {
    await _fireStorage.deleteFileFromFireBaseStorage(id);
    await _firebaseFirestore
        .collection(kRootNodeForUsers)
        .doc(id)
        .update({'profile_pic':null});
    return null;
  }
}
