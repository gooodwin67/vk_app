import 'package:flutter/material.dart';
import 'package:vk_app/domain/api_client/api_client.dart';

class MainScreenModel extends ChangeNotifier {
  final apiClient = ApiClient();
  int info = 0;

  Future<void> loadInfo() async {
    final infoResponse = await apiClient.getInfo();
    info = infoResponse.id;
    notifyListeners();
    print(info);
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
