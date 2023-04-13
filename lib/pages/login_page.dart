import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/bloc/login_page_bloc.dart';
import 'package:we_chat/data/vos/user_vo/user_vo.dart';
import 'package:we_chat/easy_widgets/easy_list_tile_widget.dart';
import 'package:we_chat/easy_widgets/easy_network_image.dart';
import 'package:we_chat/easy_widgets/easy_text_field_widget.dart';
import 'package:we_chat/easy_widgets/easy_text_widget.dart';
import 'package:we_chat/pages/home_page.dart';
import 'package:we_chat/utils/extension.dart';

import '../constant/dimens.dart';
import '../constant/strings.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginPageBloc>(
      create: (context) => LoginPageBloc(),
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: appBarElevation,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              context.navigateBack(context);
            },
            icon: const Icon(Icons.close),
          ),
        ),
        body: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height - 200,
          child: Column(
            children: [
              const SizedBox(
                height: kSP50x,
              ),

              const EasyTextWidget(text: kLogInViaEmailAddressText),

              const SizedBox(
                height: kSP25x,
              ),

              ////////////////////////////////////////////
              /////////////////email text field //////////
              ////////////////////////////////////////////
              EasyListTIleWidget(
                leadingText: kEmailText,
                title: EasyTextFieldWidget(
                    controller:
                        context.getLoginPageBloc().getEmailTextController,
                    hintText: kEnterYourEmailAddressText,
                    textInputType: TextInputType.emailAddress),
              ),

              ////////////////////////////////////////////
              /////////////////password text field////////
              ////////////////////////////////////////////
              EasyListTIleWidget(
                leadingText: kPasswordText,
                title: EasyTextFieldWidget(
                  hintText: kEnterPasswordText,
                  controller:
                      context.getLoginPageBloc().getPasswordTextController,
                ),
              ),
              const SizedBox(
                height: kSP10x,
              ),

              ////////////////////////////////////////////
              ///////one tap login previous accounts//////
              ////////////////////////////////////////////
              Expanded(
                child: Selector<LoginPageBloc, List<UserVO>>(
                  selector: (_, obj) => obj.getUsersFromBox,
                  builder: (_, userFromBox, child) {
                    return ListView.separated(
                      itemCount: userFromBox.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: kSP20x,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(kSP20x),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: kSP10x, horizontal: kSP10x),
                            title: EasyTextWidget(
                              text: userFromBox[index].userName ?? '',
                              fontSize: kFZ20,
                            ),
                            leading: ClipOval(
                                child: EasyNetworkImage(
                              ifNullCondition:
                                  (userFromBox[index].profilePic == null),
                              networkImage: userFromBox[index].profilePic ?? '',
                              imgWidth: kSP50x,
                              imgHeight: kSP50x,
                              boxFit: BoxFit.cover,
                            )),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    content: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                },
                              );
                              context
                                  .getLoginPageBloc()
                                  .login(userFromBox[index].userEmail??'',userFromBox[index].userPassword??'')
                                  .whenComplete(() {
                                if (context.getLoginPageBloc().getIsLoading) {
                                  context.navigateBack(context);
                                }
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  duration: const Duration(seconds: 2),
                                  content: EasyTextWidget(
                                    text: context
                                        .getLoginPageBloc()
                                        .getErrorMessage,
                                  ),
                                  backgroundColor: Colors.green,
                                  margin: const EdgeInsets.only(bottom: kSP40x),
                                  behavior: SnackBarBehavior.floating,
                                ));
                                if (context
                                        .getLoginPageBloc()
                                        .getErrorMessage ==
                                    kLoginSuccessText) {
                                  context.navigateRemoveUntil(
                                      context, const HomePage());
                                }
                              });
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 200,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const EasyTextWidget(
                text: kVerificationText,
                fontSize: kFZ13,
                color: Colors.grey,
              ),

              ////////////////////////////////////////////
              ///////////accept and continue button///////
              ////////////////////////////////////////////
              MaterialButton(
                color: Colors.green,
                height: kAcceptAndContinueButtonHeight,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kSP10x)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        content: Center(child: CircularProgressIndicator()),
                      );
                    },
                  );
                  context
                      .getLoginPageBloc()
                      .login(
                          context
                              .getLoginPageBloc()
                              .getEmailTextController
                              .text,
                          context
                              .getLoginPageBloc()
                              .getPasswordTextController
                              .text)
                      .whenComplete(() {
                    if (context.getLoginPageBloc().getIsLoading) {
                      context.navigateBack(context);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: const Duration(seconds: 2),
                      content: EasyTextWidget(
                        text: context.getLoginPageBloc().getErrorMessage,
                      ),
                      backgroundColor: Colors.green,
                      margin: const EdgeInsets.only(bottom: kSP40x),
                      behavior: SnackBarBehavior.floating,
                    ));
                    if (context.getLoginPageBloc().getErrorMessage ==
                        kLoginSuccessText) {
                      context.navigateRemoveUntil(context, const HomePage());
                    }
                  });
                },
                child: const EasyTextWidget(
                  text: kAcceptAndContinueText,
                ),
              ),

              ////////////////////////////////////////////
              /////////////////more options text//////////
              ////////////////////////////////////////////
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: kUnableToLoginText,
                    style: const TextStyle(
                      fontSize: kFZ15,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  const TextSpan(text: '     '),
                  TextSpan(
                    text: kMoreOptionsText,
                    style: const TextStyle(
                      fontSize: kFZ15,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
