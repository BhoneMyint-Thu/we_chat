import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:we_chat/data/apply/we_chat_apply.dart';
import 'package:we_chat/data/apply/we_chat_apply_impl.dart';
import 'package:we_chat/data/vos/user_vo/user_vo.dart';
import 'package:we_chat/pages/home_page.dart';
import 'package:we_chat/pages/we_chat_new_user_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'constant/hive_constant.dart';
import 'constant/strings.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Firebase.initializeApp();

  Hive.registerAdapter(UserVOAdapter());

  await Hive.openBox<UserVO>(kWeChatHiveBoxName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final WeChatApply apply=WeChatApplyImpl();
    return MaterialApp(
      color: Colors.black,
      debugShowCheckedModeBanner: false,
      title:kAppTitle,
      theme: ThemeData(
                scaffoldBackgroundColor: Colors.black
      ),
      home: (apply.isLoggedIn())?const HomePage() :const WeChatNewUserPage(),
    );
  }
}
