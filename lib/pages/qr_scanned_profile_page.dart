import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/constant/dimens.dart';
import 'package:we_chat/easy_widgets/easy_network_image.dart';
import 'package:we_chat/easy_widgets/easy_text_widget.dart';
import 'package:we_chat/utils/extension.dart';

import '../bloc/qr_scanned_profile_page_bloc.dart';
import '../constant/strings.dart';

class QrScannedProfilePage extends StatelessWidget {
  const QrScannedProfilePage({Key? key, required this.uId}) : super(key: key);

  final String? uId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QrScannedProfilePageBloc>(
      create: (context) => QrScannedProfilePageBloc(uId),
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ////////////////////////////////////////////
              /////////////////profile ///////////////////
              ////////////////////////////////////////////
              Selector<QrScannedProfilePageBloc, String>(
                selector: (_, obj) => obj.getProfilePic,
                builder: (context, profilePic, _) => ClipOval(
                  child: SizedBox(
                      height: kQrScannedProfileHeight,
                      width: kQrScannedProfileWidth,
                      child: EasyNetworkImage(
                        ifNullCondition: profilePic.isEmpty,
                        networkImage: profilePic,
                        boxFit: BoxFit.cover,
                      )),
                ),
              ),
              const SizedBox(
                height: kSP20x,
              ),

              ////////////////////////////////////////////
              /////////////////username///////////////////
              ////////////////////////////////////////////
              Selector<QrScannedProfilePageBloc, String>(
                selector: (_, obj) => obj.getUsername,
                builder: (context, username, _) {
                  return EasyTextWidget(
                    text: username,
                    fontSize: kFZ25x,
                  );
                },
              ),
              const SizedBox(
                height: kSP30x,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ////////////////////////////////////////////
                  /////////////////cancel button//////////////
                  ////////////////////////////////////////////
                  MaterialButton(
                    onPressed: () {
                      context.navigateBack(context);
                    },
                    color: Colors.red,
                    child: const EasyTextWidget(
                      text: kCancelText,
                    ),
                  ),

                  ////////////////////////////////////////////
                  /////////////////add button/////////////////
                  ////////////////////////////////////////////
                  MaterialButton(
                    onPressed: () {
                      context
                          .getQrScannedProfilePageBloc()
                          .checkIfAlreadyFriends(uId ?? '')
                          .whenComplete(() {
                        if (!context
                            .getQrScannedProfilePageBloc()
                            .getAlreadyFri) {
                          context.getQrScannedProfilePageBloc().addToContact();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            duration: Duration(seconds: 1),
                            content: EasyTextWidget(
                              text: kAddedToFriListText,
                            ),
                            backgroundColor: Colors.green,
                          ));
                        } else {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                backgroundColor: Colors.transparent,
                                content: EasyTextWidget(
                                  text:
                                      '${context.getQrScannedProfilePageBloc().getUsername} is already in your friend list!',
                                ),
                                actions: [
                                  MaterialButton(
                                    onPressed: () {
                                      context.navigateBack(context);
                                    },
                                    color: Colors.red,
                                    child: const EasyTextWidget(
                                      text: kGoBackText,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      });
                    },
                    color: Colors.green,
                    child: const EasyTextWidget(
                      text: kAddText,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
