import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/bloc/sign_up_page_bloc.dart';
import 'package:we_chat/constant/dimens.dart';
import 'package:we_chat/easy_widgets/easy_text_widget.dart';
import 'package:we_chat/utils/assets_images_utils.dart';
import 'package:we_chat/utils/extension.dart';

import '../../constant/strings.dart';

class ChooseProfilePicView extends StatelessWidget {
  const ChooseProfilePicView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<SignUpPageBloc, File?>(
      selector: (context, obj) => obj.getProfileImage,
      builder: (context, image, _) {
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kSP20x)),
              builder: (_) => SizedBox(
                height: MediaQuery.of(context).size.height *
                    signUpPageBottomSheetHeight,
                child: Column(
                  children: [
                    ListTile(
                      shape: const Border(
                          bottom: BorderSide(
                              width: kSP1x, color: Colors.grey)),
                      onTap: () {
                        context
                            .getSignUpPageBLocInstance()
                            .pickImage(camera: true);
                        context.navigateBack(context);
                      },
                      title: const Center(
                        child: EasyTextWidget(
                          text: kCameraText,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        context
                            .getSignUpPageBLocInstance()
                            .pickImage(gallery: true);
                        context.navigateBack(context);
                      },
                      shape: const Border(
                          bottom: BorderSide(
                              width: kSP1x, color: Colors.grey)),
                      title: const Center(
                        child: EasyTextWidget(
                          text: kGalleryText,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        context
                            .getSignUpPageBLocInstance()
                            .pickImage(remove: true);
                        context.navigateBack(context);
                      },
                      title: const Center(
                        child: EasyTextWidget(
                          text: kRemoveText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Stack(
            children: [
              ClipOval(
                child: Container(
                    height: profileImageHeight,
                    width: profileImageWidth,
                    color: Colors.grey,
                    child: (image == null)
                        ? Image.asset(
                      AssetsImagesUtil.kDefaultProfileImage,
                      fit: BoxFit.cover,
                    )
                        : Image.file(
                      image,
                      fit: BoxFit.cover,
                    )),
              ),
              const Positioned(
                right: kSP0x,
                bottom: kSP0x,
                child: Icon(Icons.camera_alt),
              )
            ],
          ),
        );
      },
    );
  }
}