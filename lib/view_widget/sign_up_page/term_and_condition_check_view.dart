import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/bloc/sign_up_page_bloc.dart';
import 'package:we_chat/constant/dimens.dart';
import 'package:we_chat/utils/extension.dart';
import '../../constant/strings.dart';

class TermAndConditionCheckView extends StatelessWidget {
  const TermAndConditionCheckView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Selector<SignUpPageBloc, bool>(
          selector: (_, obj) => obj.getIsEligible,
          builder: (context, eligible, _) {
            return Checkbox(
              value: eligible,
              onChanged: (value) {
                context
                    .getSignUpPageBLocInstance()
                    .checkEligibility(value ?? false);
              },
              shape: const CircleBorder(),
            );
          },
        ),
        RichText(
          text: TextSpan(
              text: kAgreementText,
              style: const TextStyle(fontSize: kFZ13, color: Colors.grey),
              children: [
                TextSpan(
                    text: kTermText,
                    style: const TextStyle(
                      fontSize: kFZ15,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {})
              ]),
        )
      ],
    );
  }
}
