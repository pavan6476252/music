class YoutubeTrending {
  final Trending trending;

  YoutubeTrending({required this.trending});

  factory YoutubeTrending.fromJson(Map<String, dynamic> json) {
    return YoutubeTrending(
      trending: Trending.fromJson(json['trending']),
    );
  }
}

class Trending {
  final List<Item> items;
  final String playlist;

  Trending({required this.items, required this.playlist});

  factory Trending.fromJson(Map<String, dynamic> json) {
    final List<dynamic> itemsData = json['items'];
    final items = itemsData.map((item) => Item.fromJson(item)).toList();

    return Trending(
      items: items,
      playlist: json['playlist'],
    );
  }
}

class Item {
  final List<Artist> artists;
  final String playlistId;
  final List<Thumbnail> thumbnails;
  final String title;
  final String videoId;
  final dynamic views;

  Item({
    required this.artists,
    required this.playlistId,
    required this.thumbnails,
    required this.title,
    required this.videoId,
    this.views,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    final List<dynamic> artistsData = json['artists'];
    final artists = artistsData.map((artist) => Artist.fromJson(artist)).toList();

    final List<dynamic> thumbnailsData = json['thumbnails'];
    final thumbnails =
        thumbnailsData.map((thumbnail) => Thumbnail.fromJson(thumbnail)).toList();

    return Item(
      artists: artists,
      playlistId: json['playlistId'],
      thumbnails: thumbnails,
      title: json['title'],
      videoId: json['videoId'],
      views: json['views'],
    );
  }
}

class Artist {
  final String? id;
  final String name;

  Artist({this.id, required this.name});

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Thumbnail {
  final int height;
  final String url;
  final int width;

  Thumbnail({required this.height, required this.url, required this.width});

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      height: json['height'],
      url: json['url'],
      width: json['width'],
    );
  }
}
