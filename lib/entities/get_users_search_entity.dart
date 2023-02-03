class Response {
  final Map<String, dynamic> response;

  Response({required this.response});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      response: json['response'],
    );
  }
}

class UsersList {
  final List items;
  final int count;

  UsersList({required this.items, required this.count});

  factory UsersList.fromJson(Map<String, dynamic> json) {
    return UsersList(
      items: json['items'],
      count: json['count'],
    );
  }
}

class UsersListInfo {
  final int id;
  final String firstName;
  final String lastName;
  final String photo;
  final int online;
  final int online_mobile;
  final int bdate;

  UsersListInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.photo,
    required this.online,
    required this.online_mobile,
    required this.bdate,
  });

  factory UsersListInfo.fromJson(Map<String, dynamic> json) {
    final now = DateTime.now();
    var bdate = json['bdate'] != null ? json['bdate'].split('.') : [''];
    int age;

    if (bdate.last.length == 4) {
      if (now.month > int.parse(bdate[1])) {
        age = now.year - int.parse(bdate.last);
      } else if (now.month == int.parse(bdate[1])) {
        if (now.day >= int.parse(bdate[0])) {
          age = now.year - int.parse(bdate.last);
        } else {
          age = now.year - int.parse(bdate.last) - 1;
        }
      } else {
        age = now.year - int.parse(bdate.last) - 1;
      }
    } else {
      age = 0;
    }

    return UsersListInfo(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      photo: json['photo_100'],
      online: json['online'] ?? 0,
      online_mobile: json['online_mobile'] ?? 0,
      bdate: age,
    );
  }
}
