import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_app/constants/constants.dart';
import 'package:vk_app/widgets/menu-screens/profile-screen/friend_profile-screen/friend_profile-screen-model.dart';

class FriendProfileScreenWidget extends StatelessWidget {
  const FriendProfileScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    double height = 400;
    double widthImage = 100;

    String firstName = context.read<FriendProfileScreenModel>().firstName;
    String secondName = context.read<FriendProfileScreenModel>().secondName;
    String city = context.read<FriendProfileScreenModel>().city;
    Image photo = Image.network(context.read<FriendProfileScreenModel>().photo);
    BoxDecoration online = context.read<FriendProfileScreenModel>().online;
    List listPhotos = context.read<FriendProfileScreenModel>().urls;

    return Scaffold(
      extendBodyBehindAppBar: true,
      //https://stackoverflow.com/questions/68640078/tabbarview-inside-sliver-with-stickyheader
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          child: Container(
            color: constants.backColor,
            child: Column(
              children: [
                Container(
                  height: height,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        child: Container(
                          color: Colors.grey,
                          height: height / 2 + 12, //cover borderRadius
                          width: width,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: constants.secondColor.withAlpha(170),
                            ),
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: width,
                          height: height / 2,
                          padding: EdgeInsets.only(
                              top: widthImage / 2 + 12,
                              bottom: 15,
                              left: 15,
                              right: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "$firstName $secondName",
                                style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  city != ''
                                      ? Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              size: 20,
                                              color: constants.secondColor
                                                  .withAlpha(150),
                                            ),
                                            SizedBox(width: 3),
                                            Text(
                                              city,
                                              style: TextStyle(
                                                  color: constants.secondColor
                                                      .withAlpha(180)),
                                            ),
                                          ],
                                        )
                                      : const Text(''),
                                  SizedBox(width: 10),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        size: 20,
                                        color: constants.secondColor
                                            .withAlpha(150),
                                      ),
                                      SizedBox(width: 3),
                                      Text(
                                        'Подробнее',
                                        style: TextStyle(
                                            color: constants.secondColor
                                                .withAlpha(180)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: constants.backColor,
                                    elevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () {},
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_circle_outline_outlined,
                                        color: constants.mainColor,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Опубликовать',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: constants.mainColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: height / 2 - widthImage / 2,
                        left: width / 2 - widthImage / 2,
                        child: Stack(
                          children: [
                            Container(
                              width: widthImage,
                              height: widthImage,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.white, width: 3)),
                              child: ClipRRect(
                                child: photo,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            Positioned(
                              right: 9,
                              bottom: 9,
                              child: Container(
                                width: 17,
                                height: 17,
                                decoration: online,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/main/friends');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: constants.mainPadding, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '161 друг',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 80,
                          height: 30,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 50,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                      'assets/images/no-avatar.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 25,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                      'assets/images/no-avatar.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                    'assets/images/no-avatar.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: constants.mainPadding, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(color: constants.backColor)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.photo_outlined,
                                  color: constants.mainColor,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Фото',
                                  style: TextStyle(
                                      color: constants.mainColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 241,
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                              ),
                              itemCount: listPhotos.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Image.network(
                                    listPhotos[index].toString(),
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.add, color: constants.mainColor),
                              SizedBox(width: 5),
                              Text(
                                'Загрузить фото',
                                style: TextStyle(color: constants.mainColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Показать все',
                                style: TextStyle(color: constants.mainColor),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.chevron_right_outlined,
                                  color: constants.mainColor),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: constants.mainPadding, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: constants.mainPadding, vertical: 5),
                    decoration: BoxDecoration(
                      color: constants.backColor,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit_note_outlined,
                            color: constants.mainColor),
                        SizedBox(width: 5),
                        Text(
                          'Что у вас новго',
                          style: TextStyle(
                              color: constants.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
