// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class Friend extends StatelessWidget {
  Image avatar;
  String name;
  Friend({
    Key? key,
    required this.avatar,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: avatar,
                  ),
                  const SizedBox(width: 20),
                  Text(name,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {},
              child: const Icon(Icons.chat_bubble_outline, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

List<Friend> listFriend = <Friend>[
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Иван Иванов'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Петр Петров'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Андрей Андреев'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Иван Иванов'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Петр Петров'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Андрей Андреев'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Иван Иванов'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Петр Петров'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Андрей Андреев'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Иван Иванов'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Петр Петров'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Андрей Андреев'),
];

List<Friend> listFriendAfterSearch = <Friend>[];

class FriendsWidget extends StatefulWidget {
  const FriendsWidget({Key? key}) : super(key: key);

  @override
  State<FriendsWidget> createState() => _FriendsWidgetState();
}

class _FriendsWidgetState extends State<FriendsWidget> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    _searching();
    _searchController.addListener((_searching));
    super.initState();
  }

  _searching() {
    if (_searchController.text.toString().isNotEmpty) {
      listFriendAfterSearch = listFriend.where((friend) {
        return friend.name
            .toLowerCase()
            .contains(_searchController.text.toString().toLowerCase());
      }).toList();
    } else {
      listFriendAfterSearch = listFriend;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
            itemCount: listFriendAfterSearch.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: listFriendAfterSearch[index],
              );
            }),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Поиск',
                fillColor: Color(0xeeffffff)),
          ),
        ),
      ],
    );
  }
}
