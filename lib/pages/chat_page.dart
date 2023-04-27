import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/bloc/chat_page_bloc.dart';
import 'package:we_chat/constant/dimens.dart';
import 'package:we_chat/easy_widgets/easy_network_image.dart';
import 'package:we_chat/easy_widgets/easy_text_widget.dart';
import 'package:we_chat/pages/chatting_page.dart';
import 'package:we_chat/utils/extension.dart';

import '../constant/strings.dart';
import '../data/vos/user_vo/user_vo.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatPageBloc>(
      create: (context) => ChatPageBloc(),
      builder: (context, child) => Scaffold(
        body: Selector<ChatPageBloc, List<UserVO>>(
          selector: (_, obj) => obj.getChattingFriends,
          shouldRebuild: (previous, next) => previous == next,
          builder: (context, chattingFriends, _) {
            return (chattingFriends.isEmpty)
                ? const Center(
                    child: EasyTextWidget(
                      text: kNoChatHistoryText,
                      fontSize: kFZ16,
                      color: Colors.grey,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(kSP10x),
                    child: ListView.separated(
                      itemCount: chattingFriends.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: kSP20x,
                      ),
                      itemBuilder: (context, index) {
                        return ListTile(
                          isThreeLine: true,
                          ////////////////////////////////////////////
                          /////////////////username///////////////////
                          ////////////////////////////////////////////
                          title: EasyTextWidget(
                            text: chattingFriends[index].userName ?? '',
                            fontSize: kFZ20,
                          ),

                          ////////////////////////////////////////////
                          /////////////////last sent msg//////////////
                          ////////////////////////////////////////////
                          subtitle: EasyTextWidget(
                            text: (context
                                        .getChatPageBloc()
                                        .getLoggedInUserId ==
                                    chattingFriends[index].lastMessageSenderId)
                                ? "You: ${chattingFriends[index].lastSentMessage ?? ''}"
                                : "${chattingFriends[index].userName ?? ''}: ${chattingFriends[index].lastSentMessage ?? ''}",
                            color: Colors.grey,
                            fontSize: kFZ13,
                          ),
                          ////////////////////////////////////////////
                          /////////////////profile img////////////////
                          ////////////////////////////////////////////
                          leading: ClipOval(
                              child: EasyNetworkImage(
                            ifNullCondition:
                                (chattingFriends[index].profilePic == null),
                            networkImage:
                                chattingFriends[index].profilePic ?? '',
                            imgWidth: kSP50x,
                            imgHeight: kSP50x,
                                boxFit: BoxFit.cover,
                          )),
                          onTap: () {
                            context.navigateToNextScreen(
                                context,
                                ChattingPage(
                                    friendId: chattingFriends[index].id ?? '',
                                    friendName:
                                        chattingFriends[index].userName ?? ''));
                          },
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
