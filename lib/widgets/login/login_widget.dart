import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/widgets/main/main_provider.dart';
import 'package:vk_app/widgets/main/main_screen_model.dart';

class LoginScreenWidget extends StatelessWidget {
  const LoginScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void getData() async {
      context.read<MainProvider>().changeScreen(1);
      await context.read<ApiClient>().login();
      /*await context
          .read<MainScreenModel>()
          .getUserInfo(context.read<ApiClient>().token);*/
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Login'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => getData(),
            child: Text('Login'),
          ),
        ),
      ),
    );
  }
}
