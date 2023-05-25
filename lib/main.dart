import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:music/utils/responsive.dart';
import 'package:music/views/mobile/audio_player/audio_player.dart';
import 'package:music/views/mobile/mobile_home_page.dart';
import 'package:music/views/mobile/playlist_opener/playlist_viewer.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _route,
      title: 'Music',
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}

GoRouter _route = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) =>
        const Responsive(mobileResponsive: MobileHomePage()),
  ),
  GoRoute(
    path: '/playlist',
    builder: (context, state) {
      final id = state.queryParameters['id'];
      return PlayListViewer(id: id);
    },
  ),
  GoRoute(
    path: '/player',
    builder: (context, state) {
      final videoId = state.queryParameters['videoId'];
      print(videoId);
      final image = state.queryParameters['image'];
      print(image);

      print("goRouter");

      return AudioPlayerPage(
        videoId: videoId,
        image: image,
      );
    },
  )
]);
