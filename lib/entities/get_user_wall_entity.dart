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

  UserWall({required this.count, required this.items});

  factory UserWall.fromJson(Map<String, dynamic> json) {
    return UserWall(
      count: json['count'],
      items: json['items'],
    );
  }
}

class UserWallItems {
  final int fromId;

  UserWallItems({required this.fromId});

  factory UserWallItems.fromJson(Map<String, dynamic> json) {
    return UserWallItems(
      fromId: json['from_id'],
    );
  }
}
