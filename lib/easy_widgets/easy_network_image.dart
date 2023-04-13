import 'package:flutter/material.dart';
import 'package:we_chat/utils/assets_images_utils.dart';

class EasyNetworkImage extends StatelessWidget {
  const EasyNetworkImage(
      {Key? key,
      required this.ifNullCondition,
      required this.networkImage,
      this.imgWidth,
      this.imgHeight,
      this.boxFit=BoxFit.fill})
      : super(key: key);

  final bool ifNullCondition;
  final String networkImage;
  final double? imgHeight;
  final double? imgWidth;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return (ifNullCondition)
        ? Image.asset(
            AssetsImagesUtil.kDefaultProfileImage,
            width: imgWidth,
            height: imgHeight,
          )
        : Image.network(
            networkImage,
            width: imgWidth,
            height: imgHeight,
      fit: boxFit,
          );
  }
}
