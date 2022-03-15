import 'package:flutter/material.dart';
import 'package:vk_app/widgets/login/login_widget.dart';
import 'package:vk_app/widgets/login/register_user.dart';
import 'package:vk_app/widgets/login/confirm-send.dart';
import 'package:vk_app/widgets/login/reset_password.dart';
import 'package:vk_app/widgets/main/main_screen.dart';
//import 'package:vk_app/widgets/profiles/peoples_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: LoginScreenWidget(),
      initialRoute: '/main',
      routes: {
        '/': (context) => LoginScreenWidget(),
        '/main': (context) => MainScreenWidget(),
        //'/main/people-profile': (context) => PeopleProfileWidget(),
        '/reset-password': (context) => ResetPasswordScreenWidget(),
        '/register': (context) => RegisterUserWidget(),
        '/confirm-send': (context) => ConfirmSendWidget(),
      },
    );
  }
}
