import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final youtubeProvider = Provider<YoutubeProvider>((ref) {
  return YoutubeProvider();
});

class YoutubeProvider {
  Future<String> extractAudioUrl(String videoId) async {
    final yt = YoutubeExplode();
    try {
        final videoManifest = await yt.videos.streamsClient.getManifest(videoId);
      final audioStreamInfo = videoManifest.audioOnly.withHighestBitrate();
      final audioUrl = audioStreamInfo.url;
      return audioUrl.toString();
    } finally {
      yt.close();
    }
  }
}
