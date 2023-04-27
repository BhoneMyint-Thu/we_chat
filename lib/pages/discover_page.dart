import 'package:flutter/material.dart';
import 'package:we_chat/constant/strings.dart';
import 'package:we_chat/easy_widgets/easy_text_widget.dart';

import '../constant/dimens.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const EasyTextWidget(text: kDiscoverText,fontSize: kFZ20,),
      ),
      body: Container(),
    );
  }
}
