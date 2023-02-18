class ResponseWall {
  final Map<String, dynamic> response;

  ResponseWall({required this.response});

  factory ResponseWall.fromJson(Map<String, dynamic> json) {
    return ResponseWall(response: json['response'] ?? {});
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
  final String text;
  final Map<String, dynamic> likes;
  final Map<String, dynamic> reposts;
  final Map<String, dynamic> views;
  final List copyHistory;
  final List attachments;

  UserWallItems({
    required this.fromId,
    required this.date,
    required this.text,
    required this.likes,
    required this.reposts,
    required this.views,
    required this.copyHistory,
    required this.attachments,
  });

  factory UserWallItems.fromJson(Map<String, dynamic> json) {
    return UserWallItems(
      fromId: json['from_id'],
      date: json['date'],
      text: json['text'],
      likes: json['likes'],
      reposts: json['reposts'],
      views: json['views'] ?? {'count': 0},
      copyHistory: json['copy_history'] ??
          [
            {'from_id': 0}
          ],
      attachments: json['attachments'] ?? [],
    );
  }
}

class CopyHistory {
  final int fromId;
  final String postGroupText;
  final List attachments;

  CopyHistory(
      {required this.fromId,
      required this.postGroupText,
      required this.attachments});

  factory CopyHistory.fromJson(Map<String, dynamic> json) {
    return CopyHistory(
      fromId: json['from_id'],
      postGroupText: json['text'] ?? '',
      attachments: json['attachments'] ?? [],
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
    //print(json);
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

class Attachments {
  final String type;

  Attachments({required this.type});

  factory Attachments.fromJson(Map<String, dynamic> json) {
    return Attachments(
      type: json['type'],
    );
  }
}

class TypeDocResponse {
  final Map doc;

  TypeDocResponse({required this.doc});

  factory TypeDocResponse.fromJson(Map<String, dynamic> json) {
    return TypeDocResponse(
      doc: json['doc'],
    );
  }
}

class TypeDocPreview {
  final String ext;
  final Map<String, dynamic> preview;

  TypeDocPreview({required this.ext, required this.preview});

  factory TypeDocPreview.fromJson(Map<String, dynamic> json) {
    return TypeDocPreview(
      ext: json['ext'],
      preview: json['preview'] ?? {'preview': ''},
    );
  }
}

class TypePhotoResponse {
  final Map<String, dynamic> photo;

  TypePhotoResponse({required this.photo});

  factory TypePhotoResponse.fromJson(Map<String, dynamic> json) {
    return TypePhotoResponse(
      photo: json['photo'],
    );
  }
}

class PhotoPhotos {
  final List sizes;

  PhotoPhotos({required this.sizes});

  factory PhotoPhotos.fromJson(Map<String, dynamic> json) {
    return PhotoPhotos(
      sizes: json['sizes'],
    );
  }
}

class PhotoUrl {
  final String url;

  PhotoUrl({required this.url});

  factory PhotoUrl.fromJson(Map<String, dynamic> json) {
    return PhotoUrl(
      url: json['url'],
    );
  }
}

class TypeLinkResponse {
  final Map link;

  TypeLinkResponse({required this.link});

  factory TypeLinkResponse.fromJson(Map<String, dynamic> json) {
    return TypeLinkResponse(
      link: json['link'],
    );
  }
}

class Link {
  final String url;
  final String title;
  final Map<String, dynamic> photo;

  Link({required this.url, required this.title, required this.photo});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'] ?? 'url',
      title: json['title'] ?? 'title',
      photo: json['photo'] ?? {'photo': ''},
    );
  }
}

class LinkPhotos {
  final List sizes;

  LinkPhotos({required this.sizes});

  factory LinkPhotos.fromJson(Map<String, dynamic> json) {
    return LinkPhotos(
      sizes: json['sizes'] ?? [],
    );
  }
}

class LinkPhotoUrl {
  final String url;

  LinkPhotoUrl({required this.url});

  factory LinkPhotoUrl.fromJson(Map<String, dynamic> json) {
    return LinkPhotoUrl(
      url: json['url'] ?? '',
    );
  }
}

class LinkDocUrl {
  final String src;

  LinkDocUrl({required this.src});

  factory LinkDocUrl.fromJson(Map<String, dynamic> json) {
    return LinkDocUrl(
      src: json['src'] ?? '',
    );
  }
}
