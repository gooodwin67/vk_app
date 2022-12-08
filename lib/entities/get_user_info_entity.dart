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
  Map<String, dynamic> city = {};
  int online = 0;

  UserInfo({
    required this.id,
    required this.deactivated,
    required this.canAccess,
    required this.firstName,
    required this.secondName,
    required this.photo,
    required this.city,
    required this.online,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      deactivated: json['deactivated'] ?? '0',
      canAccess: json['can_access_closed'] ?? true,
      firstName: json['first_name'],
      secondName: json['last_name'],
      photo: json['photo_100'],
      city: json['city'] ?? {},
      online: json['online'] != null ? 1 : 0,
    );
  }
}
