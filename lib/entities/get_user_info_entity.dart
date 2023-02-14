class ResponseInfo {
  final List response;

  ResponseInfo({required this.response, deactivated});

  factory ResponseInfo.fromJson(Map<String, dynamic> json) {
    return ResponseInfo(
      response: json['response'],
    );
  }
}

class UserInfo {
  final int id;
  final String deactivated;
  final bool canAccess;
  final String firstName;
  final String secondName;
  final String photo;
  final String domain;
  Map<String, dynamic> cover;
  Map<String, dynamic> city;
  int online;
  int online_mobile;

  UserInfo({
    required this.id,
    required this.deactivated,
    required this.canAccess,
    required this.firstName,
    required this.secondName,
    required this.photo,
    required this.domain,
    required this.cover,
    required this.city,
    required this.online,
    required this.online_mobile,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      deactivated: json['deactivated'] ?? '0',
      canAccess: json['can_access_closed'] ?? true,
      firstName: json['first_name'],
      secondName: json['last_name'],
      photo: json['photo_100'],
      domain: json['domain'] ?? '',
      cover: json['cover'] ?? {},
      city: json['city'] ?? {},
      online: json['online'] ?? 0,
      online_mobile: json['online_mobile'] ?? 0,
    );
  }
}

class CityResponse {
  final City cityresponse;

  CityResponse({required this.cityresponse});

  factory CityResponse.fromJson(Map<int, dynamic> json) {
    return CityResponse(
      cityresponse: json[0],
    );
  }
}

class City {
  String title = '';

  City({required this.title});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      title: json['title'] ?? '',
    );
  }
}

class CoverResponse {
  final Cover coverResponse;

  CoverResponse({required this.coverResponse});

  factory CoverResponse.fromJson(Map<int, dynamic> json) {
    return CoverResponse(
      coverResponse: json[0],
    );
  }
}

class Cover {
  List listCovers;

  Cover({required this.listCovers});

  factory Cover.fromJson(Map<String, dynamic> json) {
    return Cover(
      listCovers: json['images'] ?? [],
    );
  }
}

class CoverUrl {
  String url;

  CoverUrl({required this.url});

  factory CoverUrl.fromJson(Map<String, dynamic> json) {
    return CoverUrl(
      url: json['url'] ?? '',
    );
  }
}
