import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';

class LoginScreenWidget extends StatelessWidget {
  const LoginScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context
                    .read<ApiClient>()
                    .login()
                    .then((value) => Navigator.pushNamed(context, '/main'));
              },
              child: Text('Login'),
            ),
            !context.watch<ApiClient>().isLogin ? Text('off') : Text('on'),
          ],
        ),
      ),
    );
  }
}
