import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/widgets/main/main_screen_model.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<MainScreenModel>()
        .getUserInfo(context.read<ApiClient>().token);
    return Scaffold(
      body: !context.watch<ApiClient>().isLogin
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text('Loading...'),
            )
          : Container(
              child: Center(
                child: Text('Main'),
              ),
            ),
    );
  }
}
