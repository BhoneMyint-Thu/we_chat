import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data/apply/we_chat_apply.dart';
import '../data/apply/we_chat_apply_impl.dart';
import '../data/vos/user_vo/user_vo.dart';

class MePageBloc extends ChangeNotifier {
  ////////////////////////////////////////////
  /////////////////Instances//////////////////
  ////////////////////////////////////////////
  final WeChatApply _apply = WeChatApplyImpl();
  final ImagePicker _imagePicker = ImagePicker();

  ////////////////////////////////////////////
  /////////////////Attributes/////////////////
  ////////////////////////////////////////////
  bool _isDispose = false;
  UserVO? _userAccToBox;
  String _username = '';
  String _profilePic = '';
  String _userQrCode = '';
  String? _profileImagePath;
  File? _profileImage;

  ////////////////////////////////////////////
  /////////////////Getters////////////////////
  ////////////////////////////////////////////
  File? get getProfileImage => _profileImage;
  String? get getProfileImagePath => _profileImagePath;
  String get getProfilePic => _profilePic;
  String get getUsername => _username;
  String get getUserQrCode => _userQrCode;
  UserVO? get getUserAccToBox => _userAccToBox;

  ////////////////////////////////////////////
  /////////////////Methods////////////////////
  ////////////////////////////////////////////
  void changeProfilePic() {
    _apply.updateProfilePic(_profileImagePath).then((value) {
      _profilePic = value;
      notifyListeners();
    });
  }

  void addUserToBox(UserVO userAcc) => _apply.save(userAcc);

  Future logOut() => _apply.logOut();

  Future pickImage(
      {bool gallery = false, bool camera = false, bool remove = false}) async {
    if (gallery) {
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _profileImagePath = image.path;
      } else {
        return;
      }
    } else if (camera) {
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.camera);
      if (image != null) {
        _profileImagePath = image.path;
      } else {
        return;
      }
    } else if (remove) {
      if (_profilePic.isNotEmpty) {
        _apply.deleteProfilePic();
        _profilePic = '';
        notifyListeners();
      }
    }
  }

  ////////////////////////////////////////////
  /////////////////Constructor////////////////
  ////////////////////////////////////////////
  MePageBloc() {
    _apply.getLoggedInUserVO().then((value) {
      _userAccToBox = value;
      _profilePic = value?.profilePic ?? '';
      _username = value?.userName ?? '';
      _userQrCode = value?.id ?? '';
      notifyListeners();
    });
  }

  @override
  void notifyListeners() {
    if (!_isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }
}
