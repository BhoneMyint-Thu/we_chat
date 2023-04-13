import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/bloc/contact_page_bloc.dart';
import 'package:we_chat/constant/dimens.dart';
import 'package:we_chat/data/vos/user_vo/user_vo.dart';
import 'package:we_chat/easy_widgets/easy_network_image.dart';
import 'package:we_chat/easy_widgets/easy_text_widget.dart';
import 'package:we_chat/pages/chatting_page.dart';
import 'package:we_chat/utils/extension.dart';

import '../constant/strings.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContactPageBloc>(
      create: (context) => ContactPageBloc(),
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: const EasyTextWidget(
            text: kContactPageAppBarTitle,
            fontSize: kFZ20,
          ),
          backgroundColor: Colors.black,
        ),
        body: Selector<ContactPageBloc, List<UserVO>>(
          selector: (_, obj) => obj.getFriendList,
          builder: (context, friList, _) {
            return Padding(
              padding: const EdgeInsets.all(kSP10x),
              child: GroupedListView<UserVO, String>(
                elements: friList,

                groupBy: (user) =>
                    user.userName?.toUpperCase().substring(0, 1) ?? '',

                groupComparator: (group1, group2) => group1.compareTo(group2),

                itemComparator: (item1, item2) =>
                    item1.userName?.compareTo(item2.userName ?? '') ?? 0,

                groupHeaderBuilder: (element) => SizedBox(
                  height: kGroupHeaderHeight,
                  child: Card(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(kSP10x),
                      child: EasyTextWidget(
                        text: element.userName?.toUpperCase().substring(0, 1) ??
                            '',
                      ),
                    ),
                  ),
                ),

                ////////////////////////////////////////////
                /////////////////contact item///////////////
                ////////////////////////////////////////////
                itemBuilder: (context, element) {
                  return Container(
                    margin: const EdgeInsets.all(kSP10x),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(kSP5x),
                      tileColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kSP20x)),
                      title: EasyTextWidget(
                        text: element.userName ?? '',
                      ),
                      leading: ClipOval(
                        child: EasyNetworkImage(
                          ifNullCondition: element.profilePic == null,
                          networkImage: element.profilePic ?? '',
                          imgWidth: kSP50x,
                          imgHeight: kSP50x,
                        ),
                      ),
                      onTap: () {
                        context.navigateToNextScreen(
                            context,
                            ChattingPage(
                              friendId: element.id!,
                              friendName: element.userName ?? '',
                            ));
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
