import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:music/api/yt_trending_model.dart';
 
class TrendingData {
  final List<Artist> artists; 
  final YoutubeTrending youtubeTrending;
  final List<Video> videos;

  TrendingData({
    required this.artists, 
    required this.youtubeTrending,
    required this.videos,
  });

  factory TrendingData.fromJson(Map<String, dynamic> json) {
    final artistsJson = json['artists']['items'] as List<dynamic>?; 

    final videosJson = json['videos']['items'] as List<dynamic>?;

    final artists = artistsJson
        ?.map((artist) => Artist.fromJson(artist))
        .toList(growable: false); 

    final trend = YoutubeTrending.fromJson(json);
    final videos = videosJson
        ?.map((video) => Video.fromJson(video))
        .toList(growable: false);

    return TrendingData(
      artists: artists ?? [], 
      youtubeTrending: trend,
      videos: videos ?? [],
    );
  }
}

class Artist {
  final String browseId;
  final String rank;
  final String subscribers;
  final List<Thumbnail> thumbnails;
  final String title;
  final String trend;

  Artist({
    required this.browseId,
    required this.rank,
    required this.subscribers,
    required this.thumbnails,
    required this.title,
    required this.trend,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    try {
      return Artist(
        browseId: json['browseId'],
        rank: json['rank'],
        subscribers: json['subscribers'],
        thumbnails: List<Thumbnail>.from(
          json['thumbnails'].map((x) => Thumbnail.fromJson(x)),
        ),
        title: json['title'],
        trend: json['trend'],
      );
    } catch (e) {
      // Handle the format exception here or return a default value
      return Artist(
        // Provide default values or handle the exception in your own way
        browseId: '',
        rank: '',
        subscribers: '',
        thumbnails: [],
        title: '',
        trend: '',
      );
    }
  }
}

class Thumbnail {
  final int height;
  final String url;
  final int width;

  Thumbnail({
    required this.height,
    required this.url,
    required this.width,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      height: json['height'],
      url: json['url'],
      width: json['width'],
    );
  }
}

class Country {
  final String text;
  final String id;

  Country({
    required this.text,
    required this.id,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    try {
      return Country(
        text: json['text'],
        id: json['id'],
      );
    } catch (e) {
      // Handle the format exception here or return a default value
      return Country(
        // Provide default values or handle the exception in your own way
        text: '',
        id: '',
      );
    }
  }
}

class Video {
  final List<Artist> artists;
  final String playlistId;
  final List<Thumbnail> thumbnails;
  final String title;
  final String videoId;
  final String views;

  Video({
    required this.artists,
    required this.playlistId,
    required this.thumbnails,
    required this.title,
    required this.videoId,
    required this.views,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    try {
      final artistsJson = json['artists'] as List<dynamic>;
      final thumbnailsJson = json['thumbnails'] as List<dynamic>;

      final artists = artistsJson
          .map((artist) => Artist.fromJson(artist))
          .toList(growable: false);
      final thumbnails = thumbnailsJson
          .map((thumbnail) => Thumbnail.fromJson(thumbnail))
          .toList(growable: false);

      return Video(
        artists: artists,
        playlistId: json['playlistId'],
        thumbnails: thumbnails,
        title: json['title'],
        videoId: json['videoId'],
        views: json['views'],
      );
    } catch (e) {
      // Handle the format exception here or return a default value
      return Video(
        // Provide default values or handle the exception in your own way
        artists: [],
        playlistId: '',
        thumbnails: [],
        title: '',
        videoId: '',
        views: '',
      );
    }
  }
}

final trendingNotifierProvider = FutureProvider<TrendingData>((ref) async {
  final response = await http.get(
    Uri.parse(
        'https://python-music-server.vercel.app/get_country_charts?countryCode=in'),
  );
  if (response.statusCode == 200) {
    final jsonBody = json.decode(response.body);
    return TrendingData.fromJson(jsonBody);
  } else {
    throw Exception('Failed to fetch data');
  }
});
