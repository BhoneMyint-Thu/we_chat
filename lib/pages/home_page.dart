import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat/bloc/home_page_bloc.dart';
import 'package:we_chat/constant/dimens.dart';
import 'package:we_chat/easy_widgets/easy_text_widget.dart';
import 'package:we_chat/pages/chat_page.dart';
import 'package:we_chat/pages/contact_page.dart';
import 'package:we_chat/pages/discover_page.dart';
import 'package:we_chat/pages/me_page.dart';
import 'package:we_chat/utils/extension.dart';

import '../constant/strings.dart';
import '../utils/enums.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>(
        create: (context) => HomePageBloc(),
        builder: (context, child) => Selector<HomePageBloc, int>(
              selector: (_, obj) => obj.getCurrentIndex,
              builder: (context, pageIndex, _) {
                return Scaffold(
                  appBar: (pageIndex == WeChatPages.values.first.index)
                      ? AppBar(
                          automaticallyImplyLeading: false,
                          backgroundColor: Colors.black,
                          centerTitle: true,
                          title: const EasyTextWidget(
                            text: kChatPageAppBarTitle,
                          ),
                          actions: const [
                            Icon(Icons.search),
                            SizedBox(
                              width: kSP20x,
                            ),
                            Icon(Icons.add_circle_outline),
                            SizedBox(
                              width: kSP20x,
                            ),
                          ],
                        )
                      : null,

                  body: IndexedStack(
                    index: pageIndex,
                    children: const [
                      ChatPage(),
                      ContactPage(),
                      DiscoverPage(),
                      MePage()
                    ],
                  ),

                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: pageIndex,
                    selectedItemColor: Colors.green,
                    unselectedItemColor: Colors.white,
                    elevation: kBottomNavBarElevation,
                    items: const [
                      BottomNavigationBarItem(
                          backgroundColor: Colors.black,
                          icon: Icon(Icons.comment_bank),
                          label: kChatText),
                      BottomNavigationBarItem(
                          backgroundColor: Colors.black,
                          icon: Icon(Icons.contact_page),
                          label: kContactText),
                      BottomNavigationBarItem(
                          backgroundColor: Colors.black,
                          icon: Icon(Icons.remove_red_eye),
                          label: kDiscoverText),
                      BottomNavigationBarItem(
                          backgroundColor: Colors.black,
                          icon: Icon(Icons.person),
                          label: kMeText),
                    ],
                    onTap: (index) {
                      context.getHomePageBloc().changePage(index);
                    },
                  ),
                );
              },
            ));
  }
}
