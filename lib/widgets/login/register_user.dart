import 'package:flutter/material.dart';

class RegisterUserWidget extends StatefulWidget {
  const RegisterUserWidget({Key? key}) : super(key: key);

  @override
  State<RegisterUserWidget> createState() => _RegisterUserWidgetState();
}

class _RegisterUserWidgetState extends State<RegisterUserWidget> {
  final _resetPasswordTextController = TextEditingController();

  void _onResetPassword() {
    print('Register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация')),
      backgroundColor: const Color(0xff4680C2),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
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
                hintText: 'ФИО',
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
            SizedBox(height: 20),
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
                hintText: 'Email',
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
            SizedBox(height: 20),
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
                hintText: 'Телефон',
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
                        'Зарегистрироваться',
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
