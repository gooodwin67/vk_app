class Response {
  final Map<String, dynamic> response;

  Response({required this.response});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      response: json['response'],
    );
  }
}

class ResponseGroup {
  int count = 0;
  final List items;

  ResponseGroup({required this.count, required this.items});

  factory ResponseGroup.fromJson(Map<String, dynamic> json) {
    return ResponseGroup(
      count: json['count'],
      items: json['items'] ?? [],
    );
  }
}

class Item {
  final int? id;
  final String? name;
  final String? screenName;
  final int? isClosed;
  final String? type;
  final String? photo50;
  final String? photo100;
  final String? photo200;

  Item(
      {this.id,
      this.name,
      this.screenName,
      this.isClosed,
      this.type,
      this.photo50,
      this.photo100,
      this.photo200});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      screenName: json['screen_name'],
      isClosed: json['is_closed'],
      type: json['type'],
      photo50: json['photo_50'],
      photo100: json['photo_100'],
      photo200: json['photo_200'],
    );
  }
}
