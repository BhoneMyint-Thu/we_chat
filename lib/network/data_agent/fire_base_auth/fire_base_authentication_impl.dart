import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_chat/data/vos/user_vo/user_vo.dart';
import 'package:we_chat/network/data_agent/cloud_fire_store_database/cloud_fire_store_database_impl.dart';
import 'package:we_chat/network/data_agent/fire_base_auth/fire_base_authentication.dart';
import 'package:we_chat/network/data_agent/fire_base_storage/fire_storage.dart';
import 'package:we_chat/network/data_agent/fire_base_storage/fire_storage_impl.dart';
import 'package:we_chat/network/data_agent/cloud_fire_store_database/cloud_fire_store_database.dart';
import '../../../constant/strings.dart';

class FirebaseAuthenticationImpl extends FirebaseAuthentication {
  FirebaseAuthenticationImpl._();

  static final _singleton = FirebaseAuthenticationImpl._();

  factory FirebaseAuthenticationImpl() => _singleton;

  var auth = FirebaseAuth.instance;
  final CloudFireStoreDatabase _cloudFireStoreDatabase =
      CloudFireStoreDatabaseImpl();
  final FireStorage _fireStorage = FireStorageImpl();

  @override
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  @override
  Future logOut() => auth.signOut();

  @override
  Future<String> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return kLoginSuccessText;
    } on FirebaseAuthException catch (error) {
      return error.code;
    } catch (e) {
      return kSomeThingWentWrongText;
    }
  }

  @override
  Future<String> registerNewUser(UserVO user) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: user.userEmail ?? '', password: user.userPassword ?? '')
          .then((credential) async {
        final User? newUser = credential.user;
        if (newUser != null) {
          await newUser.updateDisplayName(user.userName).then((value) {
            final User? updatedUser = auth.currentUser;
            user.id = updatedUser?.uid;
          });
          if (user.profilePic != null && user.id != null) {
            await _fireStorage
                .upLoadFileToFirebaseStorage(File(user.profilePic??''), user.id??'')
                .then((value) => user.profilePic = value);
          }
          _cloudFireStoreDatabase.createNewUser(user);
        }
      });
      return kRegistrationSuccessfulText;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return kSomeThingWentWrongText;
    }
  }

  @override
  String? getLoggedInUserId() => auth.currentUser?.uid;

  @override
  Future<UserVO?> getLoggedInUserVO() =>
      _cloudFireStoreDatabase.getUserVO(getLoggedInUserId());
}
