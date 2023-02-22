import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/constants/constants.dart';
import 'package:vk_app/entities/models/get_groups_model.dart';

class GroupsScreenWidget extends StatefulWidget {
  const GroupsScreenWidget({Key? key}) : super(key: key);

  @override
  State<GroupsScreenWidget> createState() => _GroupsScreenWidgetState();
}

class _GroupsScreenWidgetState extends State<GroupsScreenWidget> {
  @override
  void initState() {
    context.read<GetGroupsModel>().getGroups(context, 'а', 0, 10);
    print(123);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var countGroups = context.watch<GetGroupsModel>().countGroups;
    var items = context.watch<GetGroupsModel>().items;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: constants.mainPadding,
            right: constants.mainPadding,
            top: constants.mainPadding,
          ),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                automaticallyImplyLeading: false,
                titleSpacing: 0,
                floating: false,
                title: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          context
                              .read<GetGroupsModel>()
                              .getGroups(context, value, 0, 10);
                        },
                        decoration: InputDecoration(
                          label: Text('Поиск'),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          fillColor: constants.backColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      child: Icon(Icons.format_align_left_sharp),
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) {
                          return SingleChildScrollView(
                            child: AlertDialog(
                              insetPadding: EdgeInsets.all(5),
                              contentPadding: EdgeInsets.all(15),
                              titlePadding:
                                  EdgeInsets.all(15).copyWith(bottom: 0),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Фильтры',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              content: Text('data'),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Сообщества',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(
                                color: constants.secondColor,
                              ),
                            ],
                          ),
                        ),
                    childCount: 1),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    // if (index == items.length - 1) {
                    //   context.read<SearchScreenModel>().getUsersSearch(context);
                    // }
                    return Container(
                      margin: EdgeInsets.only(bottom: constants.mainPadding),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: FadeInImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    items[index].photo100.toString()),
                                placeholder: const AssetImage(
                                    'assets/images/loading.gif'),
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  print(error); //do something
                                  return Image.asset(
                                      'assets/images/no-avatar.png');
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${items[index].name}',
                                  style: TextStyle(fontSize: 17),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 5),
                                Text(items[index].screenName.toString(),
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.add,
                            color: constants.mainColor,
                          )
                        ],
                      ),
                    );
                  },
                  childCount: items.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
