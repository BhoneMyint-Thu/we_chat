import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/bloc/chat_page_bloc.dart';
import 'package:we_chat/bloc/chatting_page_bloc.dart';
import 'package:we_chat/bloc/home_page_bloc.dart';
import 'package:we_chat/bloc/login_page_bloc.dart';
import 'package:we_chat/bloc/me_page_bloc.dart';
import 'package:we_chat/bloc/qr_scanned_profile_page_bloc.dart';
import 'package:we_chat/bloc/qr_scanner_page_bloc.dart';
import 'package:we_chat/bloc/register_email_page_bloc.dart';
import 'package:we_chat/bloc/sign_up_page_bloc.dart';
import 'package:we_chat/utils/assets_images_utils.dart';

extension Navigate on BuildContext {
  Future navigateToNextScreen(BuildContext context, Widget nextScreen) =>
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => nextScreen,
      ));

  Future navigateToNextScreenReplace(BuildContext context, Widget nextScreen) =>
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => nextScreen,
      ));



  void navigateRemoveUntil(BuildContext context, Widget nextScreen) =>
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => nextScreen,
          ),
          (route) => false);

  void navigateBack(BuildContext context) => Navigator.of(context).pop();

  SignUpPageBloc getSignUpPageBLocInstance() => read<SignUpPageBloc>();

  RegisterEmailPageBloc getRegEmailPageBloc() => read<RegisterEmailPageBloc>();

  HomePageBloc getHomePageBloc()=>read<HomePageBloc>();

  LoginPageBloc getLoginPageBloc()=>read<LoginPageBloc>();

  MePageBloc getMePageBloc()=>read<MePageBloc>();

  QrScannerPageBloc getQrScannerPageBloc()=>read<QrScannerPageBloc>();

  QrScannedProfilePageBloc getQrScannedProfilePageBloc()=>read<QrScannedProfilePageBloc>();

  ChattingPageBloc getChattingPageBloc()=>read<ChattingPageBloc>();

  ChatPageBloc getChatPageBloc()=>read<ChatPageBloc>();
}

extension DefaultImageFiller on String{
  String ifEmptyDefaultImg(){
    if(isEmpty){
      return AssetsImagesUtil.kDefaultProfileImage;
    }
    return this;
  }
}