import 'package:flutter/material.dart';

class GroupsListWidget extends StatelessWidget {
  const GroupsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: ListView(
        children: [
          const TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none, width: 0),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                prefixIcon: Icon(Icons.search_outlined),
                filled: true,
                labelText: 'Поиск по сообществам',
                labelStyle: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 104, 104, 104)),
                fillColor: Color(0xaacccccc)),
          ),
          SizedBox(height: 25),
          const Text('СООБЩЕСТВА',
              style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 133, 133, 133),
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          Column(
            children: listGroups,
          ),
        ],
      ),
    );
  }
}

class GroupInListWidget extends StatelessWidget {
  Image avatar;
  String name;
  String users;
  GroupInListWidget(
      {Key? key, required this.avatar, required this.name, required this.users})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      height: 50,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: avatar,
            ),
          ),
          SizedBox(width: 15),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text(users,
                    style:
                        TextStyle(color: Color.fromARGB(255, 112, 112, 112))),
              ],
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> listGroups = <Widget>[
  GroupInListWidget(
      avatar: Image.asset('images/group-avatar.jpg'),
      name: 'Сайт болельщиков Челси',
      users: '1452 участника'),
  GroupInListWidget(
      avatar: Image.asset('images/mb-avatar.jpg'),
      name: 'Керамическая плитка в Смоленске',
      users: '352 участника'),
  GroupInListWidget(
      avatar: Image.asset('images/smol-avatar.jpg'),
      name: 'Важное в Смоленске',
      users: '183452 участника'),
  GroupInListWidget(
      avatar: Image.asset('images/group-avatar.jpg'),
      name: 'Сайт болельщиков Челси',
      users: '1452 участника'),
  GroupInListWidget(
      avatar: Image.asset('images/mb-avatar.jpg'),
      name: 'Керамическая плитка в Смоленске',
      users: '352 участника'),
  GroupInListWidget(
      avatar: Image.asset('images/smol-avatar.jpg'),
      name: 'Важное в Смоленске',
      users: '183452 участника'),
  GroupInListWidget(
      avatar: Image.asset('images/group-avatar.jpg'),
      name: 'Сайт болельщиков Челси',
      users: '1452 участника'),
  GroupInListWidget(
      avatar: Image.asset('images/mb-avatar.jpg'),
      name: 'Керамическая плитка в Смоленске',
      users: '352 участника'),
  GroupInListWidget(
      avatar: Image.asset('images/smol-avatar.jpg'),
      name: 'Важное в Смоленске',
      users: '183452 участника'),
];
