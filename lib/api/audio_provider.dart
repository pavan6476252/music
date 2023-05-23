import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod/riverpod.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class AudioPlayerController extends StateNotifier<AudioPlayerState> {
  final AudioPlayer _audioPlayer = AudioPlayer(playerId: 'mainPlayer');

  AudioPlayerController() : super(AudioPlayerState.stopped()) {
    _audioPlayer.onPlayerComplete.listen((_) {
      pauseAudio();
    });

    // Change the audioCache for the AudioPlayer instance
    _audioPlayer.audioCache = AudioCache.instance;
  }
  void playAudio(String videoId) async {
    state = AudioPlayerState.loading();

    String audioUrl = await extractAudioUrl(videoId);
    await _audioPlayer.stop();
    await _audioPlayer.setSourceUrl(audioUrl); // Update isLocal to false
    await _audioPlayer.resume();
    state = AudioPlayerState.playing();
  }

  void pauseAudio() {
    _audioPlayer.pause();
    state = AudioPlayerState.paused();
  }

  void resumeAudio() {
    _audioPlayer.resume();
    state = AudioPlayerState.playing();
  }

  void stopAudio() {
    _audioPlayer.stop();
    state = AudioPlayerState.stopped();
  }

  void seekAudio(Duration position) {
    _audioPlayer.seek(position);
  }

  Stream<Duration> get audioPositionStream => _audioPlayer.onPositionChanged;
  Stream<Duration?> get audioDurationStream => _audioPlayer.onDurationChanged;

  Future<String> extractAudioUrl(String videoId) async {
    var yt = YoutubeExplode();
    var manifest = await yt.videos.streamsClient.getManifest(videoId);
    var audioStreamInfo = manifest.audioOnly.withHighestBitrate();
    return audioStreamInfo.url.toString();
  }
}

class AudioPlayerState {
  final bool isLoading;
  final bool isPlaying;
  final bool isPaused;
  final bool isStopped;
  final Duration currentPosition;
  final Duration totalDuration;

  AudioPlayerState({
    this.isLoading = false,
    this.isPlaying = false,
    this.isPaused = false,
    this.isStopped = false,
    this.currentPosition = Duration.zero,
    this.totalDuration = Duration.zero,
  });

  factory AudioPlayerState.loading() {
    return AudioPlayerState(isLoading: true);
  }

  factory AudioPlayerState.playing() {
    return AudioPlayerState(isPlaying: true);
  }

  factory AudioPlayerState.paused() {
    return AudioPlayerState(isPaused: true);
  }

  factory AudioPlayerState.stopped() {
    return AudioPlayerState(isStopped: true);
  }

  AudioPlayerState copyWith({
    bool? isLoading,
    bool? isPlaying,
    bool? isPaused,
    bool? isStopped,
    Duration? currentPosition,
    Duration? totalDuration,
  }) {
    return AudioPlayerState(
      isLoading: isLoading ?? this.isLoading,
      isPlaying: isPlaying ?? this.isPlaying,
      isPaused: isPaused ?? this.isPaused,
      isStopped: isStopped ?? this.isStopped,
      currentPosition: currentPosition ?? this.currentPosition,
      totalDuration: totalDuration ?? this.totalDuration,
    );
  }
}

final audioPlayerProvider =
    StateNotifierProvider<AudioPlayerController, AudioPlayerState>((ref) {
  return AudioPlayerController();
});
