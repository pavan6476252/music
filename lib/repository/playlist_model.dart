import 'dart:convert'; 
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
 
final playlistProvider = FutureProvider.autoDispose
    .family<WatchPlaylistModel, String>((ref, playlistId) async {
  final url =
      'https://python-music-server.vercel.app/get_watch_playlists?playlistId=${playlistId}';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonBody = json.decode(response.body);
    return WatchPlaylistModel.fromJson(jsonBody);
  } else {
    // Throw an exception with a custom error message
    throw Exception('Failed to load playlist');
  }
});
class WatchPlaylistModel {
  final String? lyrics;
  final String playlistId;
  final String related;
  final List<Track> tracks;

  WatchPlaylistModel({
    this.lyrics,
    required this.playlistId,
    required this.related,
    required this.tracks,
  });

  factory WatchPlaylistModel.fromJson(Map<String, dynamic> json) {
    return WatchPlaylistModel(
      lyrics: json['lyrics'],
      playlistId: json['playlistId'],
      related: json['related'],
      tracks: List<Track>.from(json['tracks'].map((x) => Track.fromJson(x))),
    );
  }
}

class Track {
  final List<Artist> artists;
  final List<dynamic>? feedbackTokens;
  final String length;
  final dynamic likeStatus;
  final List<Thumbnail> thumbnail;
  final String title;
  final String videoId;
  final String videoType;
  final String views;

  Track({
    required this.artists,
    this.feedbackTokens,
    required this.length,
    this.likeStatus,
    required this.thumbnail,
    required this.title,
    required this.videoId,
    required this.videoType,
    required this.views,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      artists: List<Artist>.from(json['artists'].map((x) => Artist.fromJson(x))),
      feedbackTokens: json['feedbackTokens'],
      length: json['length'],
      likeStatus: json['likeStatus'],
      thumbnail: List<Thumbnail>.from(
          json['thumbnail'].map((x) => Thumbnail.fromJson(x))),
      title: json['title'],
      videoId: json['videoId'],
      videoType: json['videoType'],
      views: json['views'],
    );
  }
}

class Artist {
  final String id;
  final String name;

  Artist({required this.id, required this.name});

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
