class PhotosResponse {
  final Map<String, dynamic> response;

  PhotosResponse({required this.response});

  factory PhotosResponse.fromJson(Map<String, dynamic> json) {
    return PhotosResponse(
      response: json['response'] as Map<String, dynamic>,
    );
  }
}

class PhotosItems {
  final List items;
  final int count;

  PhotosItems({required this.items, required this.count});

  factory PhotosItems.fromJson(Map<String, dynamic> json) {
    return PhotosItems(
      items: json['items'],
      count: json['count'],
    );
  }
}

class PhotosItemsResponse {
  final String id;
  final List sizes;

  PhotosItemsResponse({required this.id, required this.sizes});

  factory PhotosItemsResponse.fromJson(Map<String, dynamic> json) {
    return PhotosItemsResponse(
      id: json['id'].toString(),
      sizes: json['sizes'],
    );
  }
}

class PhotosItemsSizesItems {
  final Map<String, dynamic> size;

  PhotosItemsSizesItems({required this.size});

  factory PhotosItemsSizesItems.fromJson(json) {
    return PhotosItemsSizesItems(
      size: json,
    );
  }
}

class PhotosItemsUrl {
  final String url;

  PhotosItemsUrl({required this.url});

  factory PhotosItemsUrl.fromJson(Map<String, dynamic> json) {
    return PhotosItemsUrl(
      url: json['url'],
    );
  }
}
