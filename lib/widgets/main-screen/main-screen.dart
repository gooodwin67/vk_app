import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/constants/constants.dart';
import 'package:vk_app/widgets/main-screen/main-screen-model.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MenuItemWidget(linkIndex: 0, icon: Icons.newspaper_outlined),
              MenuItemWidget(linkIndex: 1, icon: Icons.search_outlined),
              MenuItemWidget(linkIndex: 2, icon: Icons.message_outlined),
              MenuItemWidget(
                  linkIndex: 3, icon: Icons.notifications_none_outlined),
              MenuItemWidget(linkIndex: 4, icon: Icons.menu),
            ],
          ),
        ),
      ),
      body: context.watch<MainScreenModel>().activeWidget,
    );
  }
}

class MenuItemWidget extends StatelessWidget {
  final int linkIndex;
  final IconData icon;
  const MenuItemWidget({Key? key, required this.linkIndex, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<MainScreenModel>().SetActiveMenu(linkIndex);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(
          icon,
          color: context.watch<MainScreenModel>().activeMenuIndex == linkIndex
              ? constants.mainColor
              : constants.secondColor,
        ),
      ),
    );
  }
}
