import 'package:flutter/material.dart';
import 'package:vk_app/domain/api_client/api_client.dart';

class MainScreenModel extends ChangeNotifier {
  String resss = '1';

  Future Ressss() async {
    resss = ApiClient().resss;
    notifyListeners();
  }
}

class MainScreenProvider extends InheritedNotifier {
  MainScreenProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(
          key: key,
          child: child,
          notifier: model,
        );

  final MainScreenModel model;

  static MainScreenProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MainScreenProvider>();
  }
}
