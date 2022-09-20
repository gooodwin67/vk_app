import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/services/routes.dart';
import 'package:vk_app/widgets/friends/friends_list.dart';
import 'package:vk_app/widgets/groups/groups_list.dart';
import 'package:vk_app/widgets/login/login_model.dart';
import 'package:vk_app/widgets/login/login_widget.dart';
import 'package:vk_app/widgets/login/register_user.dart';
import 'package:vk_app/widgets/login/confirm-send.dart';
import 'package:vk_app/widgets/login/reset_password.dart';
import 'package:vk_app/widgets/main/main_provider.dart';
import 'package:vk_app/widgets/main/main_screen.dart';
import 'package:vk_app/widgets/main/main_screen_model.dart';
import 'package:vk_app/widgets/profiles/peoples_profile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ApiClient(),
      ),
      ChangeNotifierProvider(
        create: (_) => MainScreenModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => MainProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: routes[context.watch<MainProvider>().indexScreen],
    );
  }
}
