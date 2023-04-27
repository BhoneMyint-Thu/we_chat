import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/bloc/sign_up_page_bloc.dart';
import 'package:we_chat/constant/dimens.dart';
import 'package:we_chat/easy_widgets/easy_list_tile_widget.dart';
import 'package:we_chat/easy_widgets/easy_text_field_widget.dart';
import 'package:we_chat/easy_widgets/easy_text_form_field_widget.dart';
import 'package:we_chat/easy_widgets/easy_text_widget.dart';
import 'package:we_chat/pages/register_email_page.dart';
import 'package:we_chat/utils/extension.dart';
import '../constant/strings.dart';
import '../view_widget/sign_up_page/choose_profile_pic_view.dart';
import '../view_widget/sign_up_page/term_and_condition_check_view.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpPageBloc>(
      create: (context) => SignUpPageBloc(),
      builder: (context, child) => Form(
        key: context.getSignUpPageBLocInstance().getGlobalKey,
        child: Scaffold(
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: kSP25x,
                ),
                const EasyTextWidget(
                  text: kSignUpByPhoneNumberText,
                  fontSize: kFZ25x,
                ),
                const SizedBox(
                  height: kSP20x,
                ),

                const ChooseProfilePicView(),

                const SizedBox(height: kSP30x),

                ///////////////////////////////////////////
                /////////////////name field////////////////
                ///////////////////////////////////////////
                EasyListTIleWidget(
                  leadingText: kNameText,
                  title: EasyTextFormFieldWidget(
                    controller: context
                        .getSignUpPageBLocInstance()
                        .getNameTextController,
                    hintText: kUserNameHintText,
                    validatorText: kNameFieldEmptyText,
                  ),
                ),

                ////////////////////////////////////////////
                /////////////////Country and region/////////
                ////////////////////////////////////////////
                Selector<SignUpPageBloc, String>(
                  selector: (_, obj) => obj.getSelectedCountry,
                  builder: (context, country, _) {
                    return GestureDetector(
                      onTap: () {
                        countryPickerDialog(context);
                      },
                      child: EasyListTIleWidget(
                        leadingText: kCountryRegionText,
                        title: EasyTextWidget(
                          text: '  $country',
                        ),
                      ),
                    );
                  },
                ),
                ////////////////////////////////////////////
                /////////////////phone number field/////////
                ////////////////////////////////////////////
                const EasyListTIleWidget(
                  leadingText: kPhoneText,
                  title: EasyTextFieldWidget(hintText: kEnterMobileNumberText),
                ),

                ////////////////////////////////////////////
                /////////////////password field/////////////
                ////////////////////////////////////////////
                Selector<SignUpPageBloc, bool>(
                  selector: (_, obj) => obj.getPasswordHidden,
                  builder: (context, isHidden, _) {
                    return EasyListTIleWidget(
                      leadingText: kPasswordText,
                      title: EasyTextFormFieldWidget(
                        controller: context
                            .getSignUpPageBLocInstance()
                            .getPasswordTextController,
                        obscure: isHidden,
                        validatorText: kPasswordFieldEmptyText,
                        hintText: kEnterPasswordText,
                        suffixIcon: IconButton(
                          icon: (isHidden)
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          onPressed: () {
                            context
                                .getSignUpPageBLocInstance()
                                .changePasswordHidden();
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: kSP50x,
                ),

                const TermAndConditionCheckView(),

                const EasyTextWidget(
                  text: kOnlyForRegistrationFirstHalf,
                  color: Colors.grey,
                ),

                const EasyTextWidget(
                  text: kOnlyForRegistrationSecondHalf,
                  color: Colors.grey,
                ),

                const SizedBox(
                  height: kSP25x,
                ),

                ////////////////////////////////////////////
                /////////////////Material button////////////
                ////////////////////////////////////////////
                Selector<SignUpPageBloc, bool>(
                    selector: (_, obj) => obj.getIsEligible,
                    builder: (_, eligible, child) {
                      return MaterialButton(
                        height: acceptAndContinueButtonHeight,
                        disabledColor: Colors.grey.shade800,
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(kSP10x)),
                        onPressed: (eligible)
                            ? () {
                                context
                                    .getSignUpPageBLocInstance()
                                    .checkEligibility(eligible);
                                context.navigateToNextScreen(
                                    context,
                                    RegisterEmailPage(
                                      password: context
                                          .getSignUpPageBLocInstance()
                                          .getPasswordTextController
                                          .text,
                                      username: context
                                          .getSignUpPageBLocInstance()
                                          .getNameTextController
                                          .text,
                                      profileImagePath: context
                                          .getSignUpPageBLocInstance()
                                          .getProfileImagePath,
                                    ));
                              }
                            : null,
                        child: const EasyTextWidget(
                          text: kAcceptAndContinueText,
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void countryPickerDialog(BuildContext context) {
    return showCountryPicker(
      showPhoneCode: true,
      context: context,
      countryListTheme: CountryListThemeData(
        backgroundColor: Colors.black,
        flagSize: 25,
        textStyle: const TextStyle(fontSize: kFZ16, color: Colors.blueGrey),
        bottomSheetHeight:
            MediaQuery.of(context).size.height * countryPickerHeight,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(kSP20x),
          topRight: Radius.circular(kSP20x),
        ),
        inputDecoration: InputDecoration(
            labelText: kSearchText,
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF8C98A8)
                    .withOpacity(countryPickerBorderOpacity),
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: const Color(0xFF8C98A8)
                        .withOpacity(countryPickerBorderOpacity)))),
      ),
      onSelect: (Country country) => context
          .getSignUpPageBLocInstance()
          .changeCountry(country.name + (' + (${country.phoneCode})')),
    );
  }
}
