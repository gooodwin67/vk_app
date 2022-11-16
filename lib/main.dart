import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/widgets/login-screen/login-screen.dart';
import 'package:vk_app/widgets/main/main_screen.dart';
import 'package:vk_app/widgets/main/main_screen_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ApiClient()),
      ChangeNotifierProvider(create: (_) => MainScreenModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreenWidget(),
      routes: {
        '/login': (context) => LoginScreenWidget(),
        '/main': (context) => MainScreenWidget(),
      },
    );
  }
}
