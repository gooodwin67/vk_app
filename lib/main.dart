import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/models/get_user_friends_list_model.dart';
import 'package:vk_app/entities/models/get_user_info_model.dart';
import 'package:vk_app/routes/routes.dart';
import 'package:vk_app/widgets/login-screen/login-screen.dart';
import 'package:vk_app/widgets/main-screen/main-screen-model.dart';
import 'package:vk_app/widgets/main-screen/main-screen.dart';
import 'package:vk_app/widgets/menu-screens/notifications-screen/test_friend/test_friend_profile_screen.dart';
import 'package:vk_app/widgets/menu-screens/notifications-screen/test_friend/test_friend_profile_screen_model.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/friend_profile-screen/friend_profile-screen-model.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/friend_profile-screen/friend_profile_screen.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/friend_profile-screen/friends_profile_screen/friends_profile_screen.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/friend_profile-screen/friends_profile_screen/friends_profile_screen_model.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/friends_screen/friends_screen.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/profile-screen-model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ApiClient()),
      ChangeNotifierProvider(create: (_) => MainScreenModel()),
      ChangeNotifierProvider(create: (_) => FriendsScreenModel()),
      ChangeNotifierProvider(create: (_) => FriendProfileScreenModel()),
      ChangeNotifierProvider(create: (_) => ProfileFriendsScreenModel()),
      ChangeNotifierProvider(create: (_) => TestFriensProfiledModel()),
      ChangeNotifierProvider(create: (_) => GetUserInfoModel()),
      ChangeNotifierProvider(create: (_) => AllRoutesModel()),
    ],
    child: const MyApp(),
  ));
}

//test
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String thisRoute = AllRoutes.login;
  // bool is404 = false;

  // void goToRoute(route) {
  //   setState(() {
  //     thisRoute = route;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigator(
        pages: [
          MaterialPage(
            child: LoginScreenWidget(),
          ),
          if (context.watch<AllRoutesModel>().thisRoute ==
              context.watch<AllRoutesModel>().main)
            MaterialPage(
              arguments: {'id': context.watch<AllRoutesModel>().userId},
              child: MainScreenWidget(),
            ),
          if (context.watch<AllRoutesModel>().thisRoute ==
              context.watch<AllRoutesModel>().myFriends)
            MaterialPage(
              arguments: {'id': context.watch<AllRoutesModel>().userId},
              child: FriendsScreenWidget(),
            ),
          if (context.watch<AllRoutesModel>().is404 == true)
            const MaterialPage(
              child: Scaffold(
                body: Center(
                  child: Text('Страница не найдена'),
                ),
              ),
            ),
        ],
        onPopPage: (route, result) {
          // if (!route.didPop(result)) {
          //   return false;
          // }
          return true;
        },
      ),
      //home: LoginScreenWidget(),
      /*routes: {
        '/login': (context) => LoginScreenWidget(),
        '/main': (context) => MainScreenWidget(),
        '/main/friends': (context) => FriendsScreenWidget(),
        '/main/friends/profile': (context) => FriendProfileScreenWidget(),
        '/main/friends/profile/friends': (context) =>
            ProfileFriendsScreenWidget(),
      },*/
    );
  }
}
