import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/constants/constants.dart';
import 'package:vk_app/entities/models/get_user_friends_list_model.dart';
import 'package:vk_app/entities/models/get_user_info_model.dart';
import 'package:vk_app/entities/models/get_user_photos_model.dart';
import 'package:vk_app/entities/models/get_user_wall_model.dart';
import 'package:vk_app/entities/models/user_search_model.dart';

class SearchScreenWidget extends StatelessWidget {
  const SearchScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List usersList = context.watch<SearchScreenModel>().userList;
    //print(context.read<SearchScreenModel>().count);

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
                        onSubmitted: (value) {
                          context.read<SearchScreenModel>().clearUsersList();
                          context
                              .read<SearchScreenModel>()
                              .saveTextFilter(value);
                          context
                              .read<SearchScreenModel>()
                              .getUsersSearch(context);
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
                                children: [
                                  Text(
                                    'Фильтры',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        context
                                            .read<SearchScreenModel>()
                                            .clearUsersList();
                                        context
                                            .read<SearchScreenModel>()
                                            .resetFilter();

                                        context
                                            .read<SearchScreenModel>()
                                            .getUsersSearch(context);
                                        Navigator.pop(context);
                                      },
                                      child: Text('Сбросить фильтр',
                                          style: TextStyle(
                                              color: constants.secondColor
                                                  .withAlpha(200)))),
                                ],
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Город'),
                                      SizedBox(height: 10),
                                      InkWell(
                                        onTap: (() async {
                                          await context
                                              .read<SearchScreenModel>()
                                              .getCitiesSearch(context, '', 0);
                                          showDialog(
                                              context: context,
                                              builder:
                                                  ((context) => AlertDialog(
                                                        title: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text('Город'),
                                                            SizedBox(
                                                                height: 15),
                                                            TextField(
                                                              onChanged:
                                                                  (value) {
                                                                context
                                                                    .read<
                                                                        SearchScreenModel>()
                                                                    .getCitiesSearch(
                                                                        context,
                                                                        value,
                                                                        1);
                                                              },
                                                              decoration:
                                                                  InputDecoration(
                                                                label: Text(
                                                                    'Поиск'),
                                                                floatingLabelBehavior:
                                                                    FloatingLabelBehavior
                                                                        .never,
                                                                prefixIcon:
                                                                    Icon(Icons
                                                                        .search),
                                                                filled: true,
                                                                fillColor:
                                                                    constants
                                                                        .backColor,
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 15),
                                                            InkWell(
                                                              onTap: () {
                                                                context
                                                                    .read<
                                                                        SearchScreenModel>()
                                                                    .activeCityInSearch(
                                                                        0, '');
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                'Любой',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.all(22)
                                                                .copyWith(
                                                                    top: 0),
                                                        content:
                                                            ListView.builder(
                                                                itemCount: context
                                                                    .watch<
                                                                        SearchScreenModel>()
                                                                    .citiesCount,
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  return InkWell(
                                                                    onTap: () {
                                                                      context.read<SearchScreenModel>().activeCityInSearch(
                                                                          context
                                                                              .read<
                                                                                  SearchScreenModel>()
                                                                              .citiesListInfo[
                                                                                  index]
                                                                              .id,
                                                                          context
                                                                              .read<SearchScreenModel>()
                                                                              .citiesListInfo[index]
                                                                              .title);
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Text(context
                                                                            .watch<SearchScreenModel>()
                                                                            .citiesListInfo[index]
                                                                            .title),
                                                                        Text(context.watch<SearchScreenModel>().citiesListInfo[index].area ??
                                                                            ''),
                                                                        SizedBox(
                                                                            height:
                                                                                10),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                      )));
                                        }),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: constants.backColor,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(context
                                                          .watch<
                                                              SearchScreenModel>()
                                                          .currentCity ==
                                                      ''
                                                  ? 'Любой'
                                                  : context
                                                      .watch<
                                                          SearchScreenModel>()
                                                      .currentCity),
                                              Icon(Icons
                                                  .keyboard_arrow_down_rounded),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Пол'),
                                      SizedBox(height: 10),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: constants.backColor,
                                        ),
                                        child: DefaultTabController(
                                          initialIndex: context
                                              .watch<SearchScreenModel>()
                                              .sex,
                                          length: 3,
                                          child: TabBar(
                                            onTap: (value) {
                                              context
                                                  .read<SearchScreenModel>()
                                                  .changeFilterSex(value);
                                            },
                                            indicator: BoxDecoration(
                                              border: Border.all(
                                                  color: Color.fromARGB(
                                                      255, 133, 133, 133)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            labelColor: Colors.black,
                                            labelPadding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 15),
                                            tabs: [
                                              Text('Любой'),
                                              Text('Женский'),
                                              Text('Мужской'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Возраст'),
                                      SizedBox(height: 10),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: constants.backColor,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 5),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(context
                                                      .watch<
                                                          SearchScreenModel>()
                                                      .curentFilterAge
                                                      .start
                                                      .round()
                                                      .toString()),
                                                  Text(context
                                                      .watch<
                                                          SearchScreenModel>()
                                                      .curentFilterAge
                                                      .end
                                                      .round()
                                                      .toString())
                                                ],
                                              ),
                                            ),
                                            RangeSlider(
                                              values: context
                                                  .watch<SearchScreenModel>()
                                                  .curentFilterAge,
                                              max: 100,
                                              divisions: 100,
                                              labels: RangeLabels(
                                                context
                                                    .watch<SearchScreenModel>()
                                                    .curentFilterAge
                                                    .start
                                                    .round()
                                                    .toString(),
                                                context
                                                    .watch<SearchScreenModel>()
                                                    .curentFilterAge
                                                    .end
                                                    .round()
                                                    .toString(),
                                              ),
                                              onChanged: (RangeValues value) {
                                                context
                                                    .read<SearchScreenModel>()
                                                    .changeFilterAge(value);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Семейное положение'),
                                        SizedBox(height: 5),
                                        DropdownButton(
                                          value: context
                                              .watch<SearchScreenModel>()
                                              .status,
                                          items: const [
                                            DropdownMenuItem(
                                                child: Text('Любое'), value: 0),
                                            DropdownMenuItem(
                                                child: Text(
                                                    'не женат (не замужем)'),
                                                value: 1),
                                            DropdownMenuItem(
                                                child: Text('встречается'),
                                                value: 2),
                                            DropdownMenuItem(
                                                child: Text('помолвлен(-а)'),
                                                value: 3),
                                            DropdownMenuItem(
                                                child: Text('женат (замужем)'),
                                                value: 4),
                                            DropdownMenuItem(
                                                child: Text('всё сложно'),
                                                value: 5),
                                            DropdownMenuItem(
                                                child:
                                                    Text('в активном поиске'),
                                                value: 6),
                                            DropdownMenuItem(
                                                child: Text('влюблен(-а)'),
                                                value: 7),
                                            DropdownMenuItem(
                                                child:
                                                    Text('в гражданском браке'),
                                                value: 8),
                                          ],
                                          onChanged: (value) {
                                            context
                                                .read<SearchScreenModel>()
                                                .changeFilterStatus(value);
                                          },
                                        )
                                      ]),
                                ],
                              ),
                              actions: [
                                Container(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<SearchScreenModel>()
                                            .clearUsersList();
                                        context
                                            .read<SearchScreenModel>()
                                            .saveFilter();
                                        context
                                            .read<SearchScreenModel>()
                                            .getUsersSearch(context);

                                        Navigator.pop(context);
                                      },
                                      child: Text('Сохранить фильтр')),
                                ),
                              ],
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
                                    'Все',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: constants.secondColor
                                            .withAlpha(150)),
                                  ),
                                  SizedBox(width: 20),
                                  const Text(
                                    'Люди',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    'Сообщества',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: constants.secondColor
                                            .withAlpha(150)),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    'Новости',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: constants.secondColor
                                            .withAlpha(150)),
                                  ),
                                  SizedBox(width: 20),
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
                    if (index == usersList.length - 1) {
                      context.read<SearchScreenModel>().getUsersSearch(context);
                    }
                    return InkWell(
                      onTap: () {
                        context
                            .read<UserPhotosModel>()
                            .clearPhotosList()
                            .then((value) => context
                                .read<GetUserWallModel>()
                                .clearUserWallList())
                            .then((value) => context
                                .read<GetUserInfoModel>()
                                .getUserInfo(context, usersList[index].id)
                                .then((value) => context
                                    .read<UserPhotosModel>()
                                    .getUserPhotos(
                                        context, usersList[index].id, 6, 0))
                                .then((value) {
                                  if (context
                                      .read<GetUserInfoModel>()
                                      .userInfo
                                      .canAccess) {
                                    context
                                        .read<GetUserWallModel>()
                                        .getUserWall(
                                            context, 5, 0, usersList[index].id);
                                  }
                                })
                                .then((value) => context
                                    .go('/search/${usersList[index].id}'))
                                .then((value) => context
                                    .read<FriendsScreenModel>()
                                    .getUserFriends(
                                        context, usersList[index].id)));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: constants.mainPadding),
                        child: Row(
                          children: [
                            Stack(
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
                                          usersList[index].photo.toString()),
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
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: usersList[index].online == 1
                                      ? usersList[index].online_mobile == 1
                                          ? MobileOnlineIcon()
                                          : DesctopOnlineIcon()
                                      : SizedBox(),
                                )
                              ],
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${usersList[index].firstName} ${usersList[index].lastName}',
                                    style: TextStyle(fontSize: 17),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5),
                                  usersList[index].bdate == 0
                                      ? SizedBox()
                                      : Text(usersList[index].bdate.toString(),
                                          style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.person_add_alt_1_outlined,
                              color: constants.mainColor,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: usersList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
