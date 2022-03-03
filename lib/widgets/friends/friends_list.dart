import 'package:flutter/material.dart';

class Friend extends StatelessWidget {
  Image avatar;
  String name;
  Friend({Key? key, required this.avatar, required this.name})
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

List<Widget> listFriends = <Widget>[
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

class FriendsWidget extends StatelessWidget {
  const FriendsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
            itemCount: listFriends.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: listFriends[index],
              );
            }),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: const TextField(
            decoration: InputDecoration(
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
