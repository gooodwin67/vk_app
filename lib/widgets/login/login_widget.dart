import 'package:flutter/material.dart';
import 'package:vk_app/widgets/login/login_model.dart';

class LoginScreenWidget extends StatelessWidget {
  const LoginScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = LoginProvider.of(context)?.model;
    return Scaffold(
      backgroundColor: const Color(0xff4680C2),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Container(
              height: 230,
              child: Center(
                child: Container(
                  width: 100,
                  height: 100,
                  child: const Placeholder(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ErrorLoginMessage(),
                TextField(
                  controller: model?.loginTextController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    isCollapsed: true,
                    filled: true,
                    fillColor: Color(0xff5D99DD),
                    hintText: 'Email или Телефон',
                    hintStyle: TextStyle(
                        color: Color(0xaaffffff),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8),
                  ),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8),
                  cursorColor: Colors.white,
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: model?.passwordTextController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      // ignore: unnecessary_const
                      borderRadius: const BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    isCollapsed: true,
                    filled: true,
                    fillColor: Color(0xff5D99DD),
                    hintText: 'Пароль',
                    hintStyle: TextStyle(
                        color: Color(0xaaffffff),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8),
                  ),
                  obscureText: true,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8),
                  cursorColor: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextButton(
                    onPressed: () {}, //_onResetPassword,
                    child: const Text('Забыли?',
                        style: TextStyle(
                            color: Color(0xaaffffff),
                            decoration: TextDecoration.underline)),
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                    width: double.infinity,
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      child: LoginBtn(),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Center(
                  child: TextButton(
                    onPressed: () {}, //_onRegister,
                    child: const Text('Зарегистрироваться',
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LoginBtn extends StatelessWidget {
  const LoginBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = LoginProvider.of(context)?.model;
    return ElevatedButton(
      onPressed: model?.canStartLogin == true
          ? () => model?.login(context)
          : null, //_onEnter,
      style: ElevatedButton.styleFrom(
          primary: Colors.white, shape: const StadiumBorder()),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(
          'Войти',
          style: TextStyle(
            color: Color(0xff4680C2),
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class _ErrorLoginMessage extends StatelessWidget {
  const _ErrorLoginMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = LoginProvider.of(context)?.model.textInvalidLogin;
    if (errorMessage == null) return SizedBox();
    return Text(
      errorMessage,
      style: TextStyle(color: Colors.red[200], fontSize: 20),
    );
  }
}


/*
  void _onResetPassword() {
    Navigator.pushNamed(context, '/reset-password');
  }

  void _onEnter() {
    if (_loginTextController.text == 'admin' &&
        _passwordTextController.text == 'admin') {
      textInvalidLogin = '';
      Navigator.pushNamed(context, '/main');
    } else {
      textInvalidLogin = 'Не верный логин или пароль';
    }
    setState(() {});
  }

  void _onRegister() {
    Navigator.pushNamed(context, '/register');
  }
*/
  
