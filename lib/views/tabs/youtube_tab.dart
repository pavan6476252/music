import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import '../../api/audio_provider.dart';
import '../../api/yt_trending_data.dart';
import '../../utils/utils.dart';

class YoutubeMusicDataScreen extends StatefulWidget {
  const YoutubeMusicDataScreen({Key? key}) : super(key: key);

  @override
  State<YoutubeMusicDataScreen> createState() => _YoutubeMusicDataScreenState();
}

class _YoutubeMusicDataScreenState extends State<YoutubeMusicDataScreen> {
  Timer? _timer;
  int _seconds = 0;
  final int _duration = 5; // Duration in seconds
  bool _isTimerRunning = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    if (!_isTimerRunning) {
      const oneSecond = Duration(seconds: 1);
      _seconds = 0; // Reset the seconds
      _isTimerRunning = true;
      _timer = Timer.periodic(oneSecond, (Timer timer) {
        setState(() {
          _seconds++;
          if (_seconds >= _duration) {
            timer.cancel();
            _isTimerRunning = false;
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final musicDataAsync = ref.watch(trendingNotifierProvider);

        return musicDataAsync.when(
          data: (musicData) {
            return ListView(
              children: [
                SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: musicData.artists.length,
                    itemBuilder: (context, index) {
                      final artist = musicData.artists[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 41,
                              backgroundImage: showBackgroudImageProvider(
                                artist.thumbnails[1].url,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              artist.title,
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              artist.subscribers,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 210,
                  width: double.maxFinite,
                  child: ListView.builder(
                    itemCount: musicData.youtubeTrending.trending.items.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final trends =
                          musicData.youtubeTrending.trending.items[index];
                      return SizedBox(
                        width: 250,
                        child: InkWell(
                          onTap: () {
                            ref
                                .read(audioPlayerProvider.notifier)
                                .playAudio(trends.videoId);
                          },
                          child: Card(
                            elevation: 5,
                            margin: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: showBackgroudImage(
                                    trends.thumbnails[0].url,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        trends.title,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        trends.artists
                                            .map((element) => element.name)
                                            .join(" , ")
                                            .replaceAll(RegExp(r'\{|\}'), ''),
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: musicData.videos.length,
                  itemBuilder: (context, index) {
                    final video = musicData.videos[index];

                    return Card(
                      child: ListTile(
                        onTap: () async {
                          ref
                              .read(audioPlayerProvider.notifier)
                              .playAudio(video.videoId);
                        },
                        leading: SizedBox(
                          width: 111,
                          height: 111,
                          child: showBackgroudImage(
                            video.thumbnails[1].url,
                          ),
                        ),
                        title: Text(
                          video.title,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Views: ${video.views}'),
                            Text(
                              'Artist: ${video.artists.map((artist) => artist.title).join(', ')}',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
          loading: () {
            // Music data is still loading
            return const Center(child: CircularProgressIndicator());
          },
          error: (error, stackTrace) {
            // Failed to fetch music data

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: $error'),
                SizedBox(height: 15),
                OutlinedButton(
                  onPressed: _isTimerRunning
                      ? null
                      : () {
                          startTimer();
                          ref.refresh(trendingNotifierProvider.future);
                        },
                  child: _isTimerRunning
                      ? Text('Reloading .. wait $_seconds')
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Ionicons.reload),
                            SizedBox(width: 10),
                            Text("Reload"),
                          ],
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
