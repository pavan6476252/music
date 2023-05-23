import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:music/api/home_api.dart';
import 'package:music/views/components/CelebratingAsianculture.dart';
import 'package:music/views/components/all_time_essential.dart';
import 'package:music/views/components/feel_good_favorites.dart';
import 'package:music/views/components/irresistible_sign_alongs.dart';
import 'package:music/views/components/new_releases.dart';
import 'package:music/views/components/quick_picks.dart';
import 'package:music/views/components/recommended_music_video.dart';
import 'package:music/views/components/romantic_music_video.dart';
import 'package:music/views/components/throwback_jams.dart';
import 'package:music/views/components/today_big_hits.dart';
import 'package:music/views/tabs/downloads_tab.dart';
import 'package:music/views/tabs/youtube_tab.dart';
import 'package:music/widgets/audio_widget.dart';

import '../api/audio_provider.dart';
import 'components/new_and_trending.dart';
import 'components/so_for_2023.dart';
import 'components/top_music_video.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _page = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _page);
  }

  void changeTab(int page) {
    setState(() {
      _page = page;
    });
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Timer? _timer;
  int _seconds = 0;
  final int _duration = 5; // Duration in seconds
  bool _isTimerRunning = false;

  @override
  void dispose() {
    _timer?.cancel();
    pageController.dispose();
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

  List<Temperatures> homeItem = [];
  @override
  Widget build(BuildContext context) {
    final homePageAsyncData = ref.watch(homePageModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Music"),
        actions: [
          IconButton(onPressed: () {
              context.push('/search');
          }, icon: const Icon(Ionicons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Ionicons.settings))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  _page = value;
                });
              },
              children: [
                homePageAsyncData.when(
                  data: (homePage) {
                    return ListView.builder(
                        itemCount: homePage.temperatures!.length,
                        itemBuilder: (context, index) {
                          final content = homePage.temperatures![index];
                          if (content.title == 'Quick picks') {
                            return QuickPick(contents: content.contents);
                          }
                          if (content.title == "Today's biggest hits") {
                            return TodayBigHits(contents: content.contents);
                          }
                          if (content.title == "New releases") {
                            return NewReleases(contents: content.contents);
                          }

                          if (content.title == "All-time essentials") {
                            return AllTimeEssentials(
                                contents: content.contents);
                          }

                          if (content.title == 'Throwback jams') {
                            return ThrowBackJams(contents: content.contents);
                          }
                          if (content.title == 'Feel-good favorites') {
                            return FeelGoodFavorites(
                                contents: content.contents);
                          }
                          if (content.title == '2023 So Far') {
                            return SoFar2023(contents: content.contents);
                          }
                          if (content.title == 'Top music videos') {
                            return TopMusicVideo(contents: content.contents);
                          }
                          if (content.title == 'Irresistible sing-alongs') {
                            return IrresistibleSingAlongs(
                                contents: content.contents);
                          }

                          if (content.title == 'New & trending songs') {
                            return NewAndTrending(contents: content.contents);
                          }
                          if (content.title == 'Recommended music videos') {
                            return RecommendedMusicVideo(
                                contents: content.contents);
                          }
                          if (content.title == 'Celebrating Asian culture') {
                            return CelebratingAsianCulture(
                                contents: content.contents);
                          }
                          if (content.title == 'All the feelings') {
                            return AllTimeEssentials(
                                contents: content.contents);
                          }

                          if (content.title == 'Romantic moods') {
                            return RomanticMusicVideo(
                                contents: content.contents);
                          }
                          return Text(content.title ?? "");
                        });
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Failed to fetch data: $error'),
                      const SizedBox(height: 15),
                      OutlinedButton(
                        onPressed: _isTimerRunning
                            ? null
                            : () {
                                startTimer();
                                ref.refresh(homePageModelProvider.future);
                              },
                        child: _isTimerRunning
                            ? Text('Reloading .. wait $_seconds')
                            : const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Ionicons.reload),
                                  SizedBox(width: 10),
                                  Text("Reload"),
                                ],
                              ),
                      )
                    ],
                  )),
                ),
                //trending
                const YoutubeMusicDataScreen(),
                const DownloadsTab(),
              ],
            ),
          ),
          const AudioPlayerWidget(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page,
          onTap: (value) => changeTab(value),
          items: [
            BottomNavigationBarItem(
                backgroundColor: _page == 0 ? Colors.amber : Colors.grey,
                label: "Home",
                icon: const Icon(Ionicons.home_outline)),
          
            BottomNavigationBarItem(
                backgroundColor: _page == 0 ? Colors.amber : Colors.grey,
                label: "Youtube",
                icon: const Icon(Ionicons.logo_youtube)),
                  BottomNavigationBarItem(
                backgroundColor: _page == 0 ? Colors.amber : Colors.grey,
                label: "Downloads",
                icon: const Icon(Ionicons.download)),
          ]),
     
    );
  }
}
