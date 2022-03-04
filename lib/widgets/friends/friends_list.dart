import 'package:flutter/material.dart';

class Friend extends StatelessWidget {
  final Image avatar;
  final String name;
  const Friend({Key? key, required this.avatar, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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

List<Friend> listFriends = <Friend>[
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Иван Иванов'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Петр Петров'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Сергей Сергеев'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Иван Иванов'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Петр Петров'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Сергей Сергеев'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Иван Иванов'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Петр Петров'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Сергей Сергеев'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Иван Иванов'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Петр Петров'),
  Friend(avatar: Image.asset('images/ava.jpg'), name: 'Сергей Сергеев'),
];

List<Friend> listFriendsAfterSearch = <Friend>[];
List<Friend> TestlistFriendsAfterSearch = <Friend>[];

class FriendsWidget extends StatefulWidget {
  const FriendsWidget({Key? key}) : super(key: key);

  @override
  State<FriendsWidget> createState() => _FriendsWidgetState();
}

class _FriendsWidgetState extends State<FriendsWidget> {
  final searchController = TextEditingController();

  @override
  void initState() {
    _onChangedSearchField();
    searchController.addListener((_onChangedSearchField));
    super.initState();
  }

  void _onChangedSearchField() {
    if (searchController.text.toString().isNotEmpty) {
      listFriendsAfterSearch = listFriends.where((el) {
        return el.name
            .toLowerCase()
            .contains(searchController.text.toString().toLowerCase());
      }).toList();
    } else {
      listFriendsAfterSearch = listFriends;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
            itemCount: listFriendsAfterSearch.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: listFriendsAfterSearch[index],
              );
            }),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: searchController,
            //onChanged: onChangedSearchField,
            decoration: const InputDecoration(
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Color(0xeeffffff),
              hintText: 'Поиск',
            ),
          ),
        ),
      ],
    );
  }
}
