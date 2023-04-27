import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/bloc/register_email_page_bloc.dart';
import 'package:we_chat/easy_widgets/easy_list_tile_widget.dart';
import 'package:we_chat/easy_widgets/easy_text_field_widget.dart';
import 'package:we_chat/easy_widgets/easy_text_widget.dart';
import 'package:we_chat/pages/home_page.dart';
import 'package:we_chat/utils/extension.dart';
import '../constant/dimens.dart';
import '../constant/strings.dart';
import '../data/vos/user_vo/user_vo.dart';

class RegisterEmailPage extends StatelessWidget {
  const RegisterEmailPage(
      {Key? key,
      required this.username,
      required this.password,
      required this.profileImagePath})
      : super(key: key);

  final String username;
  final String password;
  final String? profileImagePath;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterEmailPageBloc>(
      create: (context) => RegisterEmailPageBloc(),
      builder: (context, child) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ////////////////////////////////////////////
        /////////////////Sign up button/////////////
        ////////////////////////////////////////////
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.getRegEmailPageBloc().getEmailFocusNode.unfocus();
            showDialog(context: context, builder: (context) {
              return  const AlertDialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                content: Center(child: CircularProgressIndicator()),
              );
            },);
            final UserVO newUser = UserVO(
                id: '',
                userName: username,
                userPassword: password,
                userEmail:
                    context.getRegEmailPageBloc().getEmailTextController.text,
                profilePic: profileImagePath);
            context
                .getRegEmailPageBloc()
                .registerNewUser(newUser)
                .whenComplete(() {
              if(context.getRegEmailPageBloc().getIsLoading){
                context.navigateBack(context);
              }
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: EasyTextWidget(
                  text: context.getRegEmailPageBloc().getErrorMessage,
                ),
                backgroundColor: Colors.green,
              ));
              if(context.getRegEmailPageBloc().getErrorMessage==kRegistrationSuccessfulText) {
                context.navigateRemoveUntil(context, const HomePage());
              }
            });
          },
          label: const EasyTextWidget(
            text: kSignUpText,
          ),
          backgroundColor: Colors.green,
        ),

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

        ////////////////////////////////////////////
        /////////////////Text field/////////////////
        ////////////////////////////////////////////
        body:  Center(
          child: SizedBox(
            width: double.infinity,
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    SizedBox(
                      width: kSP50x,
                    ),
                    EasyTextWidget(
                      text: kEnterYourEmailAddressText,
                      fontSize: kFZ20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: kSP20x,
                ),
                EasyListTIleWidget(
                    leadingText: kEmailText,
                    title: EasyTextFieldWidget(focusNode: context.getRegEmailPageBloc().getEmailFocusNode,controller:  context.getRegEmailPageBloc().getEmailTextController, hintText: kEnterEmailText,
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
