import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/models/get_my_friends_list_model.dart';
import 'package:vk_app/entities/models/get_my_info_model.dart';
import 'package:vk_app/entities/models/get_my_photos_model.dart';
import 'package:vk_app/entities/models/get_user_friends_list_model.dart';
import 'package:vk_app/entities/models/get_user_info_model.dart';
import 'package:vk_app/entities/models/get_user_photos_model.dart';
import 'package:vk_app/routes/routes.dart';
import 'package:vk_app/routes/bottom-menu/bottom-menu-model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ApiClient()),
      ChangeNotifierProvider(create: (_) => BottomMenuModel()),
      ChangeNotifierProvider(create: (_) => FriendsScreenModel()),
      ChangeNotifierProvider(create: (_) => GetUserInfoModel()),
      ChangeNotifierProvider(create: (_) => GetMyInfoModel()),
      ChangeNotifierProvider(create: (_) => MyFriendsScreenModel()),
      ChangeNotifierProvider(create: (_) => UserPhotosModel()),
      ChangeNotifierProvider(create: (_) => MyPhotosModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    );
  }
}
