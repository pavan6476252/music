import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music/utils/utils.dart';

import '../api/audio_provider.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({super.key});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  double currentPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final audioPlayerState = watch.watch(audioPlayerProvider);
      final audioPlayerController = watch.watch(audioPlayerProvider.notifier);
      return Column(
        children: [
          ListTile(
            leading: audioPlayerState.isLoading
                ? const SizedBox(
                    width: 30, height: 30, child: CircularProgressIndicator())
                : audioPlayerState.isPlaying
                    ? const Icon(Icons.pause)
                    : audioPlayerState.isPaused
                        ? const Icon(Icons.play_arrow)
                        : const Icon(Icons.play_arrow),
            title: audioPlayerState.isLoading
                ? const Text('Loading...')
                : audioPlayerState.isPlaying
                    ? const Text('Playing')
                    : audioPlayerState.isPaused
                        ? const Text('Paused')
                        : const Text('Stopped'),
            trailing: IconButton(
              icon: const Icon(Icons.stop),
              onPressed: () => audioPlayerController.stopAudio(),
            ),
            onTap: () {
              if (audioPlayerState.isLoading) {
                return;
              } else if (audioPlayerState.isPlaying) {
                audioPlayerController.pauseAudio();
              } else if (audioPlayerState.isPaused) {
                audioPlayerController.resumeAudio();
              } else {
                // audioPlayerController.playAudio(videoId);
                showSnakBar(context, "No Audio id provieded");
              }
            },
          ),
          StreamBuilder<Duration>(
            stream: audioPlayerController.audioPositionStream,
            builder: (context, snapshot) {
              final position = snapshot.data ?? Duration.zero;
              return StreamBuilder<Duration?>(
                stream: audioPlayerController.audioDurationStream,
                builder: (context, snapshot) {
                  final duration = snapshot.data ?? Duration.zero;
                  double progress = 0.0;

                  if (duration != Duration.zero) {
                    progress = position.inSeconds / duration.inSeconds;
                  }

                  if (progress.isNaN || progress.isInfinite) {
                    progress = 0.0;
                  }

                  return SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight:
                            4.0, // Adjust the track height to your preference
                      ),
                      child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight:
                                2.0, // Adjust the track height to your preference
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius:
                                    6.0), // Adjust the thumb size
                            overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 5.0), // Adjust the overlay size
                            trackShape:
                                CustomTrackShape(), // Custom track shape to remove background
                          ),
                          child: Slider(
                            onChanged: (value) {
                              Duration seekPosition = Duration(
                                  milliseconds:
                                      (value * duration.inMilliseconds)
                                          .toInt());
                              audioPlayerController.seekAudio(seekPosition);
                              setState(() {
                                currentPosition = value;
                              });
                            },
                            onChangeEnd: (value) {
                              // Optionally, perform any additional logic when the slider value is finalized
                            },
                            value: progress,
                          )));
                },
              );
            },
          ),
        ],
      );
    });
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
