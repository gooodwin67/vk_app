class ResponseWall {
  final Map<String, dynamic> response;

  ResponseWall({required this.response});

  factory ResponseWall.fromJson(Map<String, dynamic> json) {
    return ResponseWall(
      response: json['response'] as Map<String, dynamic>,
    );
  }
}

class UserWall {
  final int count;
  final List items;
  final List profiles;

  UserWall({required this.count, required this.items, required this.profiles});

  factory UserWall.fromJson(Map<String, dynamic> json) {
    return UserWall(
      count: json['count'],
      items: json['items'],
      profiles: json['profiles'],
    );
  }
}

class UserWallItems {
  final int fromId;
  final int date;

  UserWallItems({
    required this.fromId,
    required this.date,
  });

  factory UserWallItems.fromJson(Map<String, dynamic> json) {
    return UserWallItems(
      fromId: json['from_id'],
      date: json['date'],
    );
  }
}

class UserWallProfiles {
  final int id;
  final String firstName;
  final String lastName;

  UserWallProfiles({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory UserWallProfiles.fromJson(Map<String, dynamic> json) {
    return UserWallProfiles(
      id: json['id'],
      lastName: json['last_name'],
      firstName: json['first_name'],
    );
  }
}
