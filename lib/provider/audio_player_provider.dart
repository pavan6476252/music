import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music/provider/yt_explod_provider.dart';

final audioPlayerProvider = Provider<AudioPlayer>((ref) => AudioPlayer());

final audioStateProvider = ChangeNotifierProvider<AudioState>((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);

  return AudioState(audioPlayer, ref);
});

class AudioState extends ChangeNotifier {
  final AudioPlayer _audioPlayer;
  int _currentIndex = 0;
  ChangeNotifierProviderRef<AudioState> ref;
  AudioState(this._audioPlayer, this.ref);

  int get currentIndex => _currentIndex;

  Future<void> setUrl(String videoId) async {
    final link = await ref.read(youtubeProvider).extractAudioUrl(videoId);
    await _audioPlayer.setAudioSource(
      AudioSource.uri(Uri.parse(link)),
    ); 
    play();
     
  }

  Future<void> play() async {
    notifyListeners();
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    notifyListeners();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    notifyListeners();
  }

  PlayerState playerState() {
    notifyListeners();
    return _audioPlayer.playerState;
  }

  Stream<Duration?> get durationStream => _audioPlayer.durationStream;

  Stream<Duration> get positionStream => _audioPlayer.positionStream;

  Stream<ProcessingState> get processingStateStream =>
      _audioPlayer.processingStateStream;
  Stream<LoopMode> get loopModeStream => _audioPlayer.loopModeStream;

  Stream<SequenceState?> get sequenceStateStream =>
      _audioPlayer.sequenceStateStream;

  Stream<bool?> get shuffleModeEnabledStream =>
      _audioPlayer.shuffleModeEnabledStream;

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }
}
