import 'package:flutter/material.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _currentItemInBar = 0;

  var listItemsBar = <Widget>[
    Container(
      child: const Text('Home'),
    ),
    Container(
      child: const Text('Friends'),
    ),
    Container(
      child: const Text('Groups'),
    ),
    Container(
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Exit'),
      ),
    ),
  ];

  void _selectItemBottomBar(index) {
    setState(() {
      _currentItemInBar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(child: listItemsBar[_currentItemInBar]),
      bottomNavigationBar: BottomNavigationBar(
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
          ]),
    );
  }
}
