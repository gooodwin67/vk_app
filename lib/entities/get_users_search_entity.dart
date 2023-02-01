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

  UsersListInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.photo,
    required this.online,
    required this.online_mobile,
  });

  factory UsersListInfo.fromJson(Map<String, dynamic> json) {
    return UsersListInfo(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      photo: json['photo_100'],
      online: json['online'] ?? 0,
      online_mobile: json['online_mobile'] ?? 0,
    );
  }
}
