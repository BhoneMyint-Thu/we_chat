import 'package:flutter/material.dart';
import 'package:we_chat/easy_widgets/easy_text_widget.dart';

import '../constant/dimens.dart';

class EasyListTIleWidget extends StatelessWidget {
  const EasyListTIleWidget({Key? key,required this.leadingText,this.title}) : super(key: key);

  final String leadingText;
  final Widget ? title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: listTileLeadingWidth,
        height: listTIleLeadingHeight,
        child: Center(
          child: EasyTextWidget(text: leadingText,),
        ),
      ),
      title:title,
    );
  }
}
