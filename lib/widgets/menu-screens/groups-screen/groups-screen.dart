import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/entities/models/get_groups_model.dart';

class GroupsScreenWidget extends StatefulWidget {
  const GroupsScreenWidget({Key? key}) : super(key: key);

  @override
  State<GroupsScreenWidget> createState() => _GroupsScreenWidgetState();
}

class _GroupsScreenWidgetState extends State<GroupsScreenWidget> {
  @override
  void didChangeDependencies() {
    context.read<GetGroupsModel>().getGroups(context, 'Челси', 0, 0);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Groups'),
    );
  }
}
