import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/entities/get_group_info_entity.dart';
import 'package:vk_app/entities/models/get_group_info_model.dart';

class GroupInfoScreen extends StatefulWidget {
  final String? groupId;
  const GroupInfoScreen({Key? key, required this.groupId}) : super(key: key);

  @override
  State<GroupInfoScreen> createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends State<GroupInfoScreen> {
  var groupInfo;
  @override
  void initState() {
    context
        .read<GetGroupInfoModel>()
        .getGroupInfo(context, this.widget.groupId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var groupInfo = context.watch<GetGroupInfoModel>().groupInfo;

    return Scaffold(
      body: groupInfo == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Text(groupInfo.name.toString()),
            ),
    );
  }
}
