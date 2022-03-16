import 'package:flutter/material.dart';

class PeopleProfileWidget extends StatelessWidget {
  const PeopleProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)!.settings.arguments);

    return Scaffold(
        appBar: AppBar(
          title: Text('@id$arguments'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          children: [
            Row(
              children: [
                Container(
                  width: 80,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset('images/ava.jpg')),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Игорь Алейник',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text('Статус'),
                      SizedBox(height: 7),
                      Text('Заходил час назад',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Сообщение',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, letterSpacing: 2),
                    ),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.0),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xff2d81e0)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 20))),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'У вас в друзьях',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Colors.blue),
                    ),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.0),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFFE4E4E4)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 20))),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: const [
                      Icon(Icons.money, color: Colors.blue, size: 40),
                      SizedBox(height: 5),
                      Text('Деньги', style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: const [
                      Icon(Icons.card_giftcard, color: Colors.blue, size: 40),
                      SizedBox(height: 5),
                      Text('Подарок', style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 25),
            PeopleProfileInfo(),
            const SizedBox(height: 25),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[300],
            ),
          ],
        ));
  }
}

class PeopleProfileInfo extends StatelessWidget {
  const PeopleProfileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.manage_accounts_outlined, color: Colors.grey[500]),
            SizedBox(width: 8),
            Text('118 друзей', style: TextStyle(color: Colors.grey[500])),
          ],
        ),
        const SizedBox(height: 7),
        Row(
          children: [
            Icon(Icons.home, color: Colors.grey[500]),
            SizedBox(width: 8),
            Text('Город: Москва', style: TextStyle(color: Colors.grey[500])),
          ],
        ),
        const SizedBox(height: 7),
        Row(
          children: [
            Icon(Icons.sports_rugby_rounded, color: Colors.grey[500]),
            SizedBox(width: 8),
            Flexible(
              child: Text('Место учебы: Смоленский Гумманитарный университет',
                  style: TextStyle(color: Colors.grey[500], height: 1.5)),
            ),
          ],
        ),
        const SizedBox(height: 7),
        Row(
          children: [
            Icon(Icons.open_in_new, color: Colors.grey[500]),
            SizedBox(width: 8),
            Text('Открытый профиль', style: TextStyle(color: Colors.grey[500])),
          ],
        ),
        const SizedBox(height: 11),
        Row(
          children: const [
            Icon(Icons.info, color: Colors.blue),
            SizedBox(width: 8),
            Text('Подробная информация',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
          ],
        ),
      ],
    );
  }
}
