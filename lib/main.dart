import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
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
import 'package:vk_app/widgets/menu-screens/profile-screen/friends_screen/friends_screen_model.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/profile-screen-model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ApiClient()),
      ChangeNotifierProvider(create: (_) => ProfileScreenModel()),
      ChangeNotifierProvider(create: (_) => MainScreenModel()),
      ChangeNotifierProvider(create: (_) => FriendsScreenModel()),
      ChangeNotifierProvider(create: (_) => FriendProfileScreenModel()),
      ChangeNotifierProvider(create: (_) => ProfileFriendsScreenModel()),
      ChangeNotifierProvider(create: (_) => TestFriensProfiledModel()),
    ],
    child: const MyApp(),
  ));
}

//test
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreenWidget(),
      routes: {
        '/login': (context) => LoginScreenWidget(),
        '/main': (context) => MainScreenWidget(),
        '/main/friends': (context) => FriendsScreenWidget(),
        '/main/friends/profile': (context) => FriendProfileScreenWidget(),
        '/main/friends/profile/friends': (context) =>
            ProfileFriendsScreenWidget(),
        '/main/friends/profile1': (context) => TestFriendProfileWidget(),
      },
    );
  }
}
