import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/widgets/menu-screens/notifications-screen/test_friend/test_friend_profile_screen_model.dart';

class NotificationsScreenWidget extends StatelessWidget {
  const NotificationsScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context
              .read<TestFriensProfiledModel>()
              .getUserInfo(context, 606812)
              .then((value) =>
                  Navigator.pushNamed(context, '/main/friends/profile1'));
        },
        child: Text('Friends'),
      ),
    );
  }
}
