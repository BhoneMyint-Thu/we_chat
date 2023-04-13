import 'package:flutter/material.dart';
import 'package:we_chat/constant/dimens.dart';
import 'package:we_chat/easy_widgets/easy_text_widget.dart';
import 'package:we_chat/pages/login_page.dart';
import 'package:we_chat/pages/sign_up_page.dart';
import 'package:we_chat/utils/assets_images_utils.dart';
import 'package:we_chat/utils/extension.dart';

import '../constant/strings.dart';

class WeChatNewUserPage extends StatelessWidget {
  const WeChatNewUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(AssetsImagesUtil.kWeChatBlueMarbleImage),
          fit: BoxFit.cover,
        )),
        child: Stack(
          children: [
            Positioned(
                top: kSP40x,
                right: kSP10x,
                child: TextButton(
                  onPressed: () {},
                  child: const EasyTextWidget(text: kLanguageText),
                )),

            ////////////////////////////////////////////
            /////////////////login button///////////////
            ////////////////////////////////////////////
            Positioned(
              left: kSP15x,
              right: kSP15x,
              bottom: kSP20x,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: () {
                      context.navigateToNextScreen(context,const LoginPage());
                    },
                    color: Colors.green,
                    child: const EasyTextWidget(
                      text: kLogInText,
                    ),
                  ),

                  ////////////////////////////////////////////
                  /////////////////Sign up button/////////////
                  ////////////////////////////////////////////
                  MaterialButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kSP20x)),
                          builder: (context) => SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * newUserPageBottomSheetHeight,
                                child: Column(
                                  children: [
                                    ListTile(
                                      shape:const Border(bottom: BorderSide(width: kSP1x,color: Colors.grey)),
                                      title: const Center(
                                          child: EasyTextWidget(
                                        text: kSignUpViaMobileText,
                                      )),
                                      onTap: () {
                                        context.navigateBack(context);
                                        context.navigateToNextScreen(context, const SignUpPage());
                                      },
                                    ),
                                    const ListTile(
                                      shape:Border(bottom: BorderSide(width: kSP5x,color: Colors.black)),
                                      title: Center(
                                          child: EasyTextWidget(
                                        text: kSignUpViaFacebookText,
                                      )),
                                    ),
                                    const ListTile(
                                      title: Center(
                                          child: EasyTextWidget(
                                        text: kCancelText,
                                      )),
                                    )
                                  ],
                                ),
                              ));
                    },
                    color: Colors.black12,
                    child: const EasyTextWidget(
                      text: kSIgnUpText,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
