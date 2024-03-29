class Response {
  final Map<String, dynamic> response;

  Response({required this.response});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      response: json['response'],
    );
  }
}

class FriendsList {
  final List items;
  final int count;

  FriendsList({required this.items, required this.count});

  factory FriendsList.fromJson(Map<String, dynamic> json) {
    return FriendsList(
      items: json['items'],
      count: json['count'],
    );
  }
}

class FriendsListInfo {
  final int id;
  final String firstName;
  final String lastName;
  final String photo;
  final int online;
  final int online_mobile;

  FriendsListInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.photo,
    required this.online,
    required this.online_mobile,
  });

  factory FriendsListInfo.fromJson(Map<String, dynamic> json) {
    return FriendsListInfo(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      photo: json['photo_100'],
      online: json['online'] ?? 0,
      online_mobile: json['online_mobile'] ?? 0,
    );
  }
}
