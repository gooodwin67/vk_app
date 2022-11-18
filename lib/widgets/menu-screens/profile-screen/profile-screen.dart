import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/profile-screen-model.dart';

class ProfileScreenWidget extends StatelessWidget {
  const ProfileScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print('build');
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(context.watch<ProfileScreenModel>().userName.toString()),
        ),
      ),
    );
  }
}
