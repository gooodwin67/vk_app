import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/models/get_my_friends_list_model.dart';
import 'package:vk_app/entities/models/get_my_info_model.dart';
import 'package:vk_app/entities/models/get_my_photos_model.dart';
import 'package:vk_app/entities/models/get_my_wall_model.dart';

class LoginScreenWidget extends StatelessWidget {
  const LoginScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.watch<ApiClient>().isLogining == true
          ? Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: Text('Loading...'),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<ApiClient>()
                          .login()
                          .then((value) =>
                              context.read<GetMyInfoModel>().getMyInfo(context))
                          .then((value) => context
                              .read<MyPhotosModel>()
                              .getMyPhotos(context, 6, 0))
                          .then((value) => context
                              .read<MyFriendsScreenModel>()
                              .getMyFriends(context))
                          .then((value) => context
                              .read<GetMyWallModel>()
                              .getMyWall(context, 5, 0))
                          .then((value) => context.read<ApiClient>().logining())
                          .then((value) => context.go('/profile'));

                      context.read<ApiClient>().logining(); //logining false
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
    );
  }
}
