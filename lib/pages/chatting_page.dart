import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/bloc/chatting_page_bloc.dart';
import 'package:we_chat/constant/dimens.dart';
import 'package:we_chat/data/vos/message_vo/message_vo.dart';
import 'package:we_chat/easy_widgets/easy_text_widget.dart';
import 'package:we_chat/utils/extension.dart';

import '../constant/strings.dart';

class ChattingPage extends StatelessWidget {
  const ChattingPage(
      {Key? key, required this.friendId, required this.friendName})
      : super(key: key);
  final String friendId;
  final String friendName;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChattingPageBloc>(
      create: (context) => ChattingPageBloc(friendId),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: EasyTextWidget(
            text: friendName,
            fontSize: kFZ20,
          ),
        ),
        body: Selector<ChattingPageBloc, List<MessageVO>>(
          selector: (_, obj) => obj.getMessages,
          builder: (context, messages, _) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(kSP20x),
                    child: GroupedListView<MessageVO, DateTime>(
                      controller:
                          context.getChattingPageBloc().getScrollController,
                      floatingHeader: true,
                      elements: messages,
                      itemComparator: (item1, item2) =>
                          item1.dateTime!.compareTo(item2.dateTime!),
                      groupBy: (element) => DateTime(
                        element.dateTime!.year,
                        element.dateTime!.month,
                        element.dateTime!.day,
                        element.dateTime!.hour,
                      ),
                      groupHeaderBuilder: (element) => SizedBox(
                        height: 50,
                        child: Center(
                          child: Card(
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(kSP10x),
                              child: EasyTextWidget(
                                text: DateFormat('EEEE, h a')
                                    .format(element.dateTime!),
                                fontSize: kFZ10,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      itemBuilder: (context, element) {
                        ////////////////////////////////////////////
                        /////////////////message ///////////////////
                        ////////////////////////////////////////////
                        return Align(
                          alignment: (element.senderId == friendId)
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: GestureDetector(
                            onLongPress: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return SizedBox(
                                    height: kBtmSheetHeight,
                                    child: Center(
                                      child: MaterialButton(
                                        onPressed: () {
                                          context
                                              .getChattingPageBloc()
                                              .deleteMessage(friendId,
                                                  element.messageId ?? '')
                                              .whenComplete(() {

                                            context.navigateBack(context);
                                          });
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.delete),
                                            EasyTextWidget(
                                              text: kDeleteText,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Card(
                              elevation: kMessageElevation,
                              color: Colors.blue,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(kSP10x),topLeft:  Radius.circular(kSP10x))),
                              child: Padding(
                                padding: const EdgeInsets.all(kSP10x),
                                child: EasyTextWidget(
                                  text: element.message ?? '',
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                ////////////////////////////////////////////
                ///////////text field and sent button///////
                ////////////////////////////////////////////
                ListTile(
                  title: TextField(
                    controller: context.getChattingPageBloc().getTextController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: kSP15x, horizontal: kSP10x),
                        fillColor: Colors.black,
                        filled: true,
                        hintText: kMessageHintText,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(kSP20x),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(kSP20x))),
                  ),
                  trailing:IconButton(
                    color: Colors.blue,
                    onPressed: () {
                      if(context.getChattingPageBloc().getTextController.text.isNotEmpty){
                        context
                            .getChattingPageBloc()
                            .sendMessage(friendId)
                            .whenComplete(() => context
                            .getChattingPageBloc()
                            .getTextController
                            .clear());
                      }
                    },
                    icon: const Icon(Icons.send),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
