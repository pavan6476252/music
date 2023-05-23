import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final homePageModelProvider = FutureProvider.autoDispose<HomePageModel>(
  (ref) async {
    const url = 'https://python-music-server.vercel.app/home?limit=25';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
    // Cache the response value
      ref.keepAlive();
      return HomePageModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch data');
    }
  },
);

class HomePageModel {
  List<Temperatures>? temperatures;

  HomePageModel({this.temperatures});

  factory HomePageModel.fromJson(List<dynamic> json) {
    List<Temperatures>? temperatures;
    if (json != null) {
      temperatures = json.map((item) => Temperatures.fromJson(item)).toList();
    }
    return HomePageModel(temperatures: temperatures);
  }
}

class Temperatures {
  List<Content>? contents;
  String? title;

  Temperatures({this.contents, this.title});

  factory Temperatures.fromJson(Map<String, dynamic> json) {
    List<Content>? contents;
    if (json['contents'] != null) {
      contents = List<Content>.from(
          json['contents'].map((item) => Content.fromJson(item)));
    }
    return Temperatures(contents: contents, title: json['title']);
  }
}

class Content {
  Album? album;
  List<Album>? artists;
  bool? isExplicit;
  List<Thumbnail>? thumbnails;
  String? title;
  String? videoId;
  String? description;
  String? playlistId;
  String? browseId;
  String? year;

  Content({
    this.album,
    this.artists,
    this.isExplicit,
    this.thumbnails,
    this.title,
    this.videoId,
    this.description,
    this.playlistId,
    this.browseId,
    this.year,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    List<Thumbnail>? thumbnails;
    if (json['thumbnails'] != null) {
      thumbnails = List<Thumbnail>.from(
          json['thumbnails'].map((item) => Thumbnail.fromJson(item)));
    }

    List<Album>? artists;
    if (json['artists'] != null) {
      artists = List<Album>.from(
          json['artists'].map((item) => Album.fromJson(item)));
    }

    return Content(
      album: json['album'] != null ? Album.fromJson(json['album']) : null,
      artists: artists,
      isExplicit: json['isExplicit'],
      thumbnails: thumbnails,
      title: json['title'],
      videoId: json['videoId'],
      description: json['description'],
      playlistId: json['playlistId'],
      browseId: json['browseId'],
      year: json['year'],
    );
  }
}

class Album {
  String? id;
  String? name;

  Album({this.id, this.name});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(id: json['id'], name: json['name']);
  }
}

class Thumbnail {
  int? height;
  String? url;
  int? width;

  Thumbnail({this.height, this.url, this.width});

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      height: json['height'],
      url: json['url'],
      width: json['width'],
    );
  }
}
