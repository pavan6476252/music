import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:music/views/seach_page.dart';
 
import 'views/home_page.dart';
import 'widgets/audio_widget.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _route,
      title: 'Music',
      theme: ThemeData(
        // brightness: Brightness.dark,
        
        useMaterial3: true,
      ),
      
    );
  }
}

GoRouter _route = GoRouter(routes: [
  GoRoute(  
    path: "/",
    builder: (context, state) => HomePage(),
  ),
  GoRoute(
    path: "/search",
    builder: (context, state) => SearchScreen(),
  ),
  //  GoRoute(
  //         path: '/audioplayer',
  //         builder: (BuildContext context, GoRouterState state) {
  //           final id = state.queryParameters['query'];
  //           return AudioPlayerScreen(
  //             videoId: id??"",
  //           );
  //         },
  //       ),
  
]);
