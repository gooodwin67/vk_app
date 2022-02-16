import 'package:flutter/material.dart';

class ResetPasswordScreenWidget extends StatefulWidget {
  const ResetPasswordScreenWidget({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreenWidget> createState() =>
      _ResetPasswordScreenWidgetState();
}

class _ResetPasswordScreenWidgetState extends State<ResetPasswordScreenWidget> {
  final _resetPasswordTextController = TextEditingController();

  void _onResetPassword() {
    print('resetPass');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Забыли пароль?')),
      backgroundColor: const Color(0xff4680C2),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            const SizedBox(height: 15),
            const Text(
              'Для сброса пароля введить пожалуйста ваш e-mail или телефон. Вам придет сообщения с дальнейшими инструкциями.',
              style: TextStyle(color: Colors.white, fontSize: 17, height: 1.5),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _resetPasswordTextController,
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
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Container(
                width: double.infinity,
                child: ButtonTheme(
                  minWidth: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onResetPassword,
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white, shape: const StadiumBorder()),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Сбросить пароль',
                        style: TextStyle(
                          color: Color(0xff4680C2),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
