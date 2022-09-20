import 'package:flutter/material.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/services/bottom_bar.dart';
import 'package:vk_app/widgets/friends/friends_list.dart';
import 'package:vk_app/widgets/groups/groups_list.dart';
import 'package:vk_app/widgets/main/main_screen_model.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _currentItemInBar = 0;
  _selectItemBottomBar(index) {
    Navigator.pushNamed(context, '/friends');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaf(currentItemInBar: _currentItemInBar));
  }
}

class Scaf extends StatelessWidget {
  const Scaf({
    Key? key,
    required int currentItemInBar,
  })  : _currentItemInBar = currentItemInBar,
        super(key: key);

  final int _currentItemInBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: const Center(child: Text('111')),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xff4680C2),
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color.fromARGB(255, 207, 206, 206),
          currentIndex: _currentItemInBar,
          onTap: (index) {
            Navigator.of(context).pushNamed('/friends');
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Friends',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_add),
              label: 'Groups',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: 'Account',
            ),
          ]),
    );
  }
}
