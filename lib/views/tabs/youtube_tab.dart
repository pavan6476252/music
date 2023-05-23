import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:music/utils/utils.dart';

import '../../api/audio_provider.dart';
import '../../api/yt_trending_data.dart';

class YoutubeMusicDataScreen extends StatelessWidget {
  const YoutubeMusicDataScreen({super.key});

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
                                )),
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
                // const SizedBox(height: 16),
                // _list(musicData),
                const SizedBox(height: 16),
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
                        // context.push('/audioplayer?query=${video.videoId}'),
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
                                'Artist: ${video.artists.map((artist) => artist.title).join(', ')}'),
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
            print(stackTrace);
            print(error);
            return Center(child: Text('Error: $error'));
          },
        );
      },
    );
  }
//   _list(TrendingData musicData){
//     return ListView.builder(
//   scrollDirection: Axis.horizontal,
//   itemCount: musicData.items.length,
//   itemBuilder: (context, index) {
//     final item = trendingData.items[index];
//     final artists = item.artists
//         .where((artist) => artist.id != null && artist.name != null)
//         .toList();
//     final views = item.artists
//         .where((artist) => artist.id == null && artist.name != null)
//         .toList();

//     return Container(
//       width: 200,
//       margin: EdgeInsets.symmetric(horizontal: 8.0),
//       child: Card(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Expanded(
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   Image.network(
//                     item.thumbnails[0].url,
//                     fit: BoxFit.cover,
//                   ),
//                   Positioned.fill(
//                     child: ClipRect(
//                       child: BackdropFilter(
//                         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                         child: Container(
//                           color: Colors.black.withOpacity(0.5),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     left: 0,
//                     right: 0,
//                     child: Container(
//                       padding: EdgeInsets.all(8.0),
//                       color: Colors.black.withOpacity(0.5),
//                       child: Text(
//                         item.title,
//                         style: TextStyle(fontSize: 12, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               'Artists:',
//               style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//             ),
//             Row(
//               children: artists.map((artist) {
//                 return Padding(
//                   padding: EdgeInsets.only(right: 8.0),
//                   child: Text(
//                     artist.name!,
//                     style: TextStyle(fontSize: 12),
//                   ),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               'Views:',
//               style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//             ),
//             Row(
//               children: views.map((view) {
//                 return Padding(
//                   padding: EdgeInsets.only(right: 8.0),
//                   child: Text(
//                     view.name!,
//                     style: TextStyle(fontSize: 12),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   },
// );

//   }
}
