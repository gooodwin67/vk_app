class Response {
  final List<dynamic> response;

  Response({required this.response});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      response: json['response'],
    );
  }
}

class GroupInfo {
  final int? id;
  final String? name;
  final String? screenName;
  final int? isClosed;
  final String? type;
  final String? photo50;
  final String? photo100;
  final String? photo200;
  final String? cover;
  final String? description;

  GroupInfo({
    this.id,
    this.name,
    this.screenName,
    this.isClosed,
    this.type,
    this.photo50,
    this.photo100,
    this.photo200,
    this.cover,
    this.description,
  });

  factory GroupInfo.fromJson(Map<String, dynamic> json) {
    return GroupInfo(
      id: json['id'],
      name: json['name'],
      screenName: json['screen_name'],
      isClosed: json['is_closed'],
      type: json['type'],
      photo50: json['photo_50'],
      photo100: json['photo_100'],
      photo200: json['photo_200'],
      description: json['description'],
      cover: CoverImage.fromJson(json['cover']).enabled == 1
          ? CoverImage.fromJson(json['cover']).image!['url']
          : null,
    );
  }
}

class CoverImage {
  final Map? image;
  final int enabled;

  CoverImage({required this.image, required this.enabled});

  factory CoverImage.fromJson(Map<String, dynamic> json) {
    return CoverImage(
      enabled: json['enabled'],
      image: json['images'] != null ? json['images'][1] : null,
    );
  }
}
