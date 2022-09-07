import 'package:flutter/material.dart';
import 'package:vk_app/domain/api_client/api_client.dart';

class LoginModel extends ChangeNotifier {
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final apiClient = ApiClient();
  final login = ApiClient().login;

  String _textInvalidLogin = '';
  String get textInvalidLogin => _textInvalidLogin;

  bool _loginActive = false;
  bool get canStartLogin => !_loginActive;

  Future logginIn(context) async {
    await login();
    Navigator.pushNamed(context, '/main');
  }
}

class LoginProvider extends InheritedNotifier {
  LoginProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(
          key: key,
          child: child,
          notifier: model,
        );

  final LoginModel model;

  static LoginProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LoginProvider>();
  }
}
