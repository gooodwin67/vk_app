import 'package:flutter/cupertino.dart';

class LoginModel extends ChangeNotifier {
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String _textInvalidLogin = '';
  String get textInvalidLogin => _textInvalidLogin;

  bool _loginActive = false;
  bool get canStartLogin => !_loginActive;

  Future<void> login(BuildContext context) async {}
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
