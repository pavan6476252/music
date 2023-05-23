import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:music/views/components/new_and_trending.dart';

import '../../api/home_api.dart';
import '../components/recommended_music_video.dart';
import '../components/so_for_2023.dart';
import '../components/top_music_video.dart';

class DownloadsTab extends ConsumerStatefulWidget {
  const DownloadsTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DownloadsTabState();
}

class _DownloadsTabState extends ConsumerState<DownloadsTab> {
  @override
  Widget build(BuildContext context) {
    return Text("download"
        // return homePageAsyncData.when(
        //   data: (homePage) {
        //     return ListView.builder(
        //             itemCount: homePage.temperatures!.length,
        //             itemBuilder: (context, index) {
        //               final content = homePage.temperatures![index];

        //               return SizedBox.shrink();
        //             },
        //           );
        //         },
        //   loading: () => const Center(child: CircularProgressIndicator()),
        //   error: (error, stackTrace) =>
        //       Center(child: Text('Failed to fetch data: $error')),
        );
  }
}
