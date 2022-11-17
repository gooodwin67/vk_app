import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/widgets/main/main_screen_model.dart';

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
                      context.read<ApiClient>().login().then((value) {
                        context
                            .read<MainScreenModel>()
                            .getUserInfo(context.read<ApiClient>().token)
                            .then((value) =>
                                Navigator.pushNamed(context, '/main'));
                      });
                      context.read<ApiClient>().logining();
                    },
                    child: Text('Login'),
                  ),
                  !context.watch<ApiClient>().isLogin
                      ? Text('off')
                      : Text('on'),
                ],
              ),
            ),
    );
  }
}