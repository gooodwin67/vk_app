import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/constants/constants.dart';
import 'package:vk_app/routes/bottom-menu/bottom-menu-model.dart';

class BottomMenuWidget extends StatelessWidget {
  const BottomMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaf(child: ScafChild());
  }
}

class Scaf extends StatelessWidget {
  final Widget child;
  const Scaf({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            height: 55,
            child: ScafChild(),
          ),
        ),
        body: child //context.watch<MainScreenModel>().activeWidget,
        );
  }
}

class ScafChild extends StatelessWidget {
  const ScafChild({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        MenuItemWidget(linkIndex: 0, icon: Icons.newspaper_outlined),
        MenuItemWidget(linkIndex: 1, icon: Icons.search_outlined),
        MenuItemWidget(linkIndex: 2, icon: Icons.message_outlined),
        MenuItemWidget(linkIndex: 3, icon: Icons.notifications_none_outlined),
        MenuItemWidget(linkIndex: 4, icon: Icons.menu),
      ],
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
      onTap: () async {
        await context.read<BottomMenuModel>().SetActiveMenu(linkIndex);
        context.go(context.read<BottomMenuModel>().activeWidget);

        //context.go('/profile');
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(
          icon,
          color: context.watch<BottomMenuModel>().activeMenuIndex == linkIndex
              ? constants.mainColor
              : constants.secondColor,
        ),
      ),
    );
  }
}
