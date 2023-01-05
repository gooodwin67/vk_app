class ResponseWall {
  final Map<String, dynamic> response;

  ResponseWall({required this.response});

  factory ResponseWall.fromJson(Map<String, dynamic> json) {
    return ResponseWall(response: json['response']);
  }
}

class UserWall {
  final int count;
  final List items;
  final List profiles;
  final List groups;

  UserWall(
      {required this.count,
      required this.items,
      required this.profiles,
      required this.groups});

  factory UserWall.fromJson(Map<String, dynamic> json) {
    return UserWall(
      count: json['count'],
      items: json['items'],
      profiles: json['profiles'],
      groups: json['groups'],
    );
  }
}

class UserWallItems {
  final int fromId;
  final int date;
  final Map<String, dynamic> likes;
  final Map<String, dynamic> reposts;
  final Map<String, dynamic> views;
  final List copyHistory;

  UserWallItems({
    required this.fromId,
    required this.date,
    required this.likes,
    required this.reposts,
    required this.views,
    required this.copyHistory,
  });

  factory UserWallItems.fromJson(Map<String, dynamic> json) {
    return UserWallItems(
      fromId: json['from_id'],
      date: json['date'],
      likes: json['likes'],
      reposts: json['reposts'],
      views: json['views'],
      copyHistory: json['copy_history'] ??
          [
            {'from_id': 0}
          ],
    );
  }
}

class CopyHistory {
  final int fromId;
  final String postGroupText;

  CopyHistory({required this.fromId, required this.postGroupText});

  factory CopyHistory.fromJson(Map<String, dynamic> json) {
    return CopyHistory(
      fromId: json['from_id'],
      postGroupText: json['text'],
    );
  }
}

class Likes {
  final int count;
  final int userLikes;

  Likes({required this.count, required this.userLikes});

  factory Likes.fromJson(Map<String, dynamic> json) {
    return Likes(
      count: json['count'],
      userLikes: json['user_likes'],
    );
  }
}

class Reposts {
  final int count;

  Reposts({required this.count});

  factory Reposts.fromJson(Map<String, dynamic> json) {
    return Reposts(
      count: json['count'],
    );
  }
}

class Views {
  final int count;

  Views({required this.count});

  factory Views.fromJson(Map<String, dynamic> json) {
    return Views(
      count: json == null ? 0 : json['count'],
    );
  }
}

class UserWallProfiles {
  final int id;
  final String firstName;
  final String lastName;
  final String photoProfile;

  UserWallProfiles({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.photoProfile,
  });

  factory UserWallProfiles.fromJson(Map<String, dynamic> json) {
    return UserWallProfiles(
      id: json['id'],
      lastName: json['last_name'],
      firstName: json['first_name'],
      photoProfile: json['photo_50'],
    );
  }
}

class UserWallGroups {
  final int idGroup;
  final String nameGroup;
  final String photoGroup;

  UserWallGroups({
    required this.idGroup,
    required this.nameGroup,
    required this.photoGroup,
  });

  factory UserWallGroups.fromJson(Map<String, dynamic> json) {
    return UserWallGroups(
      idGroup: json['id'],
      nameGroup: json['name'],
      photoGroup: json['photo_50'],
    );
  }
}
