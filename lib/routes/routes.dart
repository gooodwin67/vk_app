import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vk_app/widgets/login-screen/login-screen.dart';
import 'package:vk_app/routes/bottom-menu/bottom-menu.dart';
import 'package:vk_app/widgets/menu-screens/groups-screen/group-info-screen/group_info_screen.dart';
import 'package:vk_app/widgets/menu-screens/groups-screen/groups-screen.dart';
import 'package:vk_app/widgets/menu-screens/messages-screen/messages-screen.dart';
import 'package:vk_app/widgets/menu-screens/news-screen/news-screen.dart';
import 'package:vk_app/widgets/menu-screens/notifications-screen/notifications-screen.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/friend_profile-screen/friend_photos_screen/friend_photos_screen.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/friend_profile-screen/friend_profile_screen.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/friend_profile-screen/friends_profile_screen/friends_profile_screen.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/friends_screen/friends_screen.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/photos_screen/photos_screen.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/profile-screen.dart';
import 'package:vk_app/widgets/menu-screens/search-screen/search-screen.dart';

get router => _router;

final _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreenWidget();
      },
    ),
    ShellRoute(
      builder: (BuildContext context, state, child) {
        //print(child);
        return Scaf(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/news',
          builder: (BuildContext context, GoRouterState state) {
            return const NewsScreenWidget();
          },
        ),
        GoRoute(
          path: '/search',
          builder: (BuildContext context, GoRouterState state) {
            return const SearchScreenWidget();
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
                  path: 'photos',
                  builder: (BuildContext context, GoRouterState state) {
                    return FriendPhotosScreenWidget();
                  },
                ),
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
        GoRoute(
            path: '/groups',
            builder: (BuildContext context, GoRouterState state) {
              return const GroupsScreenWidget();
            },
            routes: [
              GoRoute(
                path: ':groupId',
                builder: (BuildContext context, GoRouterState state) {
                  return GroupInfoScreen(
                    groupId: state.params['groupId'],
                  );
                },
              )
            ]),
        GoRoute(
          path: '/notifications',
          builder: (BuildContext context, GoRouterState state) {
            return const NotificationsScreenWidget();
          },
        ),
        GoRoute(
          path: '/profile',
          builder: (BuildContext context, GoRouterState state) {
            return const ProfileScreenWidget();
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
                      path: 'photos',
                      builder: (BuildContext context, GoRouterState state) {
                        return FriendPhotosScreenWidget();
                      },
                    ),
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
