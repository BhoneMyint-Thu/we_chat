import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:we_chat/bloc/me_page_bloc.dart';
import 'package:we_chat/constant/dimens.dart';
import 'package:we_chat/easy_widgets/easy_network_image.dart';
import 'package:we_chat/easy_widgets/easy_text_widget.dart';
import 'package:we_chat/pages/qr_scanner_page.dart';
import 'package:we_chat/pages/we_chat_new_user_page.dart';
import 'package:we_chat/utils/extension.dart';

import '../constant/strings.dart';

class MePage extends StatelessWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MePageBloc>(
      create: (context) => MePageBloc(),
      builder: (context, child) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: kSP50x,
            ),

            ////////////////////////////////////////////
            /////////////////profile img////////////////
            ////////////////////////////////////////////
            Selector<MePageBloc, String>(
              selector: (_, obj) => obj.getProfilePic,
              builder: (context, profilePic, _) {
                return ClipOval(
                  child: SizedBox(
                      height: kProfileHeight,
                      width: kProfileWidth,
                      child: EasyNetworkImage(
                          ifNullCondition: profilePic.isEmpty,
                          networkImage: profilePic)),
                );
              },
            ),

            ////////////////////////////////////////////
            /////////////////username///////////////////
            ////////////////////////////////////////////
            Selector<MePageBloc, String>(
              selector: (_, obj) => obj.getUsername,
              builder: (context, username, _) {
                return EasyTextWidget(
                  text: username,
                  fontSize: kFZ25x,
                );
              },
            ),

            ////////////////////////////////////////////
            //////////////for show tab bar//////////////
            ////////////////////////////////////////////
            SizedBox(
              height: kSP50x,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(
                    Icons.phone_enabled_rounded,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.video_call,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.post_add,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.contact_page,
                    color: Colors.white,
                  ),
                ],
              ),
            ),

            ////////////////////////////////////////////
            /////////////////qr image///////////////////
            ////////////////////////////////////////////
            Selector<MePageBloc, String>(
              selector: (_, obj) => obj.getUserQrCode,
              builder: (context, qrCode, _) => QrImage(
                data: qrCode,
                version: QrVersions.auto,
                size: kQrImageSize,
                gapless: true,
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(kSP20x),
              ),
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ////////////////////////////////////////////
                ////////////////log out ////////////////////
                ////////////////////////////////////////////
                MaterialButton(
                  onPressed: () {
                    context.getMePageBloc().logOut().then((value) {
                      if(context.getMePageBloc().getUserAccToBox!=null){
                        context.getMePageBloc().addUserToBox(context
                            .getMePageBloc()
                            .getUserAccToBox!);
                      }
                      context.navigateRemoveUntil(
                          context, const WeChatNewUserPage());
                    }
                    );
                  },
                  color: Colors.grey,
                  child: const EasyTextWidget(
                    text: kLogOutText,
                  ),
                ),

                ////////////////////////////////////////////
                /////////////////scan qr////////////////////
                ////////////////////////////////////////////
                MaterialButton(
                  onPressed: () {
                    context.navigateToNextScreen(
                        context, const QrScannerPage());
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kSP10x)),
                  color: Colors.grey,
                  child: const Icon(
                    Icons.qr_code,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
