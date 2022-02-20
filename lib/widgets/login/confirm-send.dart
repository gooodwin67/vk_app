import 'package:flutter/material.dart';

class ConfirmSendWidget extends StatefulWidget {
  const ConfirmSendWidget({Key? key}) : super(key: key);

  @override
  State<ConfirmSendWidget> createState() => _ConfirmSendWidgetState();
}

class _ConfirmSendWidgetState extends State<ConfirmSendWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Забыли пароль?')),
      backgroundColor: const Color(0xff4680C2),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Text(
          'Всю информацию по сбросу пароля мы отправили вам на E-mail',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
    );
  }
}
