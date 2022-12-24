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
  final String text;
  final Map likes;
  final Map reposts;

  PhotosItemsResponse(
      {required this.id,
      required this.sizes,
      required this.text,
      required this.likes,
      required this.reposts});

  factory PhotosItemsResponse.fromJson(Map<String, dynamic> json) {
    return PhotosItemsResponse(
      id: json['id'].toString(),
      sizes: json['sizes'],
      text: json['text'],
      likes: json['likes'],
      reposts: json['reposts'],
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

  factory PhotosItemsUrl.fromJson(Map<dynamic, dynamic> json) {
    return PhotosItemsUrl(
      url: json['url'],
    );
  }
}

class PhotosItemsLikes {
  final int count;
  final int userLikes;

  PhotosItemsLikes({required this.count, required this.userLikes});

  factory PhotosItemsLikes.fromJson(Map<dynamic, dynamic> json) {
    return PhotosItemsLikes(
      count: json['count'],
      userLikes: json['user_likes'],
    );
  }
}

class PhotosItemsReposts {
  final int count;

  PhotosItemsReposts({required this.count});

  factory PhotosItemsReposts.fromJson(Map<dynamic, dynamic> json) {
    return PhotosItemsReposts(
      count: json['count'],
    );
  }
}

class PhotoRes {
  final PhotosItemsSizesItems sizes;
  final String text;
  final PhotosItemsLikes likes;
  final PhotosItemsReposts reposts;

  PhotoRes(
      {required this.sizes,
      required this.text,
      required this.likes,
      required this.reposts});
}

class Photo {
  final String url;
  final String text;
  final int likes;
  final int userLikes;
  final int reposts;

  Photo(
      {required this.url,
      required this.text,
      required this.likes,
      required this.userLikes,
      required this.reposts});
}
