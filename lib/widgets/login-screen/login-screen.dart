import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/entities/models/get_user_info_model.dart';
import 'package:vk_app/widgets/menu-screens/notifications-screen/test_friend/test_friend_profile_screen_model.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/friends_screen/friends_screen_model.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/profile-screen-model.dart';

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
                          .then((value) => context
                              .read<GetUserInfoModel>()
                              .getUserInfo(
                                  context, context.read<ApiClient>().userId))
                          .then(
                              (value) => Navigator.pushNamed(context, '/main'))
                          .then((value) => context
                              .read<ApiClient>()
                              .logining()); //logining false
                      //   context
                      //       .read<ProfileScreenModel>()
                      //       .getUserInfo(context.read<ApiClient>().token)
                      //       .then((value) => context
                      //           .read<ProfileScreenModel>()
                      //           .getUserPhotos(context.read<ApiClient>().token))
                      //       .then((value) =>
                      //           Navigator.pushNamed(context, '/main'));
                      // );
                      context.read<ApiClient>().logining();
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
    );
  }
}
