import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPageBloc extends ChangeNotifier {
  ////////////////////////////////////////////
  /////////////////Instances/////////////////
  ////////////////////////////////////////////
  final ImagePicker _imagePicker = ImagePicker();
  final GlobalKey<FormState> _globalKey=GlobalKey();
  final TextEditingController _nameTextController=TextEditingController();
  final TextEditingController _passwordTextController=TextEditingController();



  ////////////////////////////////////////////
  /////////////////Attributes/////////////////
  ////////////////////////////////////////////
  bool _isDispose = false;
  String _selectedCountry = 'United States + (1)';
  File? _profileImage;
  bool _isEligible=false;
  bool _passwordHidden=true;
  String ? _profileImagePath;

  ////////////////////////////////////////////
  /////////////////getters////////////////////
  ////////////////////////////////////////////
  String get getSelectedCountry => _selectedCountry;

  File? get getProfileImage => _profileImage;

  GlobalKey get getGlobalKey=>_globalKey;

  bool get getIsEligible=>_isEligible;

  TextEditingController get getNameTextController=>_nameTextController;

  TextEditingController get getPasswordTextController=>_passwordTextController;

  bool get getPasswordHidden=>_passwordHidden;

  String ? get getProfileImagePath=>_profileImagePath;

  ////////////////////////////////////////////
  /////////////////Methods////////////////////
  ////////////////////////////////////////////
  void changeCountry(String country) {
    _selectedCountry = country;
    notifyListeners();
  }

  void changePasswordHidden(){
    _passwordHidden=!_passwordHidden;
    notifyListeners();
  }

  Future pickImage({bool gallery = false, bool camera = false,bool remove=false}) async {
    if (gallery) {
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _profileImage = File(image.path);
        _profileImagePath=image.path;
      } else {
        return;
      }
    } else if (camera) {
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.camera);
      if (image != null) {
        _profileImage = File(image.path);
        _profileImagePath=image.path;
      } else {
        return;
      }
    }else if(remove){
      _profileImage=null;
      _profileImagePath=null;

    }
    notifyListeners();
  }

  void checkEligibility(bool value){
    if(value){
      if(_globalKey.currentState?.validate()??false){
        _isEligible=value;
      }
    }else{
      _isEligible=value;
    }
    notifyListeners();
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
