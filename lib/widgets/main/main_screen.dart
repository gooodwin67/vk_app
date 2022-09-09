import 'package:flutter/material.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
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
  final mainScreenModel = MainScreenModel();

  void _selectItemBottomBar(index) {
    setState(() {
      _currentItemInBar = index;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mainScreenModel.loadInfo();
  }

  @override
  Widget build(BuildContext context) {
    final model = MainScreenProvider.of(context)?.model;
    if (model != null) print(model.info.toString());

    var listItemsBar = <Widget>[
      MainScreenProvider(
        model: mainScreenModel,
        child: Container(
          child: model != null ? Text(model.info.toString()) : Text('111'),
        ),
      ),
      Container(
        child: const FriendsWidget(),
      ),
      Container(
        child: GroupsListWidget(),
      ),
      Container(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Exit'),
        ),
      ),
    ];
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
