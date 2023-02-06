class ResponseCity {
  final Map<String, dynamic> response;

  ResponseCity({required this.response});

  factory ResponseCity.fromJson(Map<String, dynamic> json) {
    return ResponseCity(
      response: json['response'],
    );
  }
}

class CitiesList {
  final List items;
  final int count;

  CitiesList({required this.items, required this.count});

  factory CitiesList.fromJson(Map<String, dynamic> json) {
    return CitiesList(
      items: json['items'],
      count: json['count'],
    );
  }
}

class CitiesListInfo {
  final int id;
  final String title;

  CitiesListInfo({
    required this.id,
    required this.title,
  });

  factory CitiesListInfo.fromJson(Map<String, dynamic> json) {
    return CitiesListInfo(
      id: json['id'],
      title: json['title'],
    );
  }
}
