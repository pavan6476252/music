import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music/repository/constant_data.dart';
import 'package:music/utils/constants.dart';
import 'package:music/views/components/community_suggested/community_suggested.dart';

import '../components/suggested_playlist/suggested_playlist.dart';

class MobileHomePage extends ConsumerStatefulWidget {
  const MobileHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends ConsumerState<MobileHomePage> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Event Music"),
          actions: const [
            Icon(Icons.settings),
            SizedBox(
              width: 15,
            )
          ],
        ),
        drawer: const Drawer(),
        body: Scrollbar(
          controller: scrollController,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Heading(
                    title: 'Essentials',
                    widget: TextButton(onPressed: () {}, child: Text('more'))),
                SuggestedPlaylistCards(
                    data: EssentialPlaylistsData.data, offset: 0),
                SuggestedPlaylistCards(
                  data: EssentialPlaylistsData.data,
                  offset: 4,
                ),
                Heading(
                    title: "Community Suggested",
                    subtitle: "Created based on community suggestions",
                    widget: TextButton(onPressed: () {}, child: Text('more'))),
                CommunitySuggestedSongs(),
              ],
            ),
          ),
        ));
  }
}

//heading
class Heading extends StatelessWidget {
  const Heading({required this.title, this.subtitle, this.widget, super.key});
  final String title;
  final String? subtitle;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // ignore: prefer_if_null_operators
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle != null
                  ? Text(
                      subtitle ?? "",
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
                    )
                  : SizedBox.shrink()
            ],
          ),
          widget ?? SizedBox.shrink()
        ],
      ),
    );
  }
}
