import 'package:flutter/material.dart';
import 'package:vk_app/services/routes.dart';
import 'package:vk_app/widgets/friends/friends_list.dart';
import 'package:vk_app/widgets/groups/groups_list.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    int _currentItemInBar = 0;
    _selectItemBottomBar(index) {
      Navigator.pushNamed(context, '/friends');
    }

    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xff4680C2),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 207, 206, 206),
        currentIndex: _currentItemInBar,
        onTap: _selectItemBottomBar,
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
        ]);
  }
}

var listItemsBar = <Widget>[
  FriendsWidget(),
  Container(
    child: GroupsListWidget(),
  ),
];
