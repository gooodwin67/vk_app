import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:vk_app/widgets/login-screen/login-screen.dart';
import 'package:vk_app/widgets/main-screen/main-screen.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/friend_profile-screen/friend_profile_screen.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/friend_profile-screen/friends_profile_screen/friends_profile_screen.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/friends_screen/friends_screen.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/photos_screen/photos_screen.dart';

get router => _router;

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreenWidget();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'main',
          builder: (BuildContext context, GoRouterState state) {
            return const MainScreenWidget();
          },
          routes: [
            GoRoute(
              path: 'photos',
              builder: (BuildContext context, GoRouterState state) {
                return PhotosScreenWidget();
              },
            ),
            GoRoute(
              path: 'my-friends',
              builder: (BuildContext context, GoRouterState state) {
                return const FriendsScreenWidget();
              },
              routes: [
                GoRoute(
                  path: ':userId',
                  builder: (BuildContext context, GoRouterState state) {
                    return FriendProfileScreenWidget(
                      userId: state.params['userId'],
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'friends',
                      builder: (BuildContext context, GoRouterState state) {
                        return ProfileFriendsScreenWidget();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

class AppRouterDelegate extends GetDelegate {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: (route, result) => route.didPop(result),
      pages: currentConfiguration != null
          ? [currentConfiguration!.currentPage!]
          : [GetNavConfig.fromRoute('main')!.currentPage!],
    );
  }
}
