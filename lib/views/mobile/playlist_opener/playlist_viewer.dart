import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:music/repository/playlist_model.dart';
import 'package:music/utils/mobile_scaffold_loading_shimmer.dart';
import 'package:music/utils/utils.dart';
import 'package:music/views/mobile/mobile_home_page.dart';

class PlayListViewer extends ConsumerStatefulWidget {
  const PlayListViewer({super.key, required this.id});
  final String? id;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlayListViewerState();
}

class _PlayListViewerState extends ConsumerState<PlayListViewer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.id);
    final playlistData = ref.watch(playlistProvider(widget.id ?? ""));
    return playlistData.when(
        data: (data) => Scaffold(
              // extendBodyBehindAppBar: true,
              appBar: AppBar(
                title: Text("Playlist"),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 30,
                  ),
                  onPressed: () => context.pop(),
                ),
                backgroundColor: Colors.transparent,
                actions: const [
                  Icon(
                    Icons.download,
                    size: 30,
                  ),
                  SizedBox(width: 15),
                  Icon(
                    Icons.settings,
                    size: 30,
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
              body: BodyBuilder(watchplaylist: data),
            ),
        error: (error, stackTrace) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              showSnakBar(context, 'Failed to load playlist'),
            );
          });

          return const MobileScaffoldShimmer();
        },
        loading: () => const MobileScaffoldShimmer());
  }
}

class BodyBuilder extends StatefulWidget {
  const BodyBuilder({super.key, required this.watchplaylist});
  final WatchPlaylistModel watchplaylist;

  @override
  State<BodyBuilder> createState() => _BodyBuilderState();
}

class _BodyBuilderState extends State<BodyBuilder> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            // PlayListThumbnail(
            //   name: playlist.authorName,
            //   desc: playlist.description,
            //   duration: playlist.duration,
            //   images: playlist.thumbnails,
            //   trackCount: playlist.trackCount,
            // ),
            SongsBuilder(tracks: widget.watchplaylist.tracks),
            // RelatedPlaylistBuilder(related: playlist.related)
          ],
        ),
      ),
    );
  }
}

class PlayListThumbnail extends StatelessWidget {
  const PlayListThumbnail(
      {super.key,
      required this.name,
      required this.desc,
      required this.duration,
      required this.images,
      required this.trackCount});
  final String? name;
  final String? desc;
  final String? duration;
  final List<Thumbnail>? images;
  final int? trackCount;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 350,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: showBackgroudImageProvider(images![0].url),
                      fit: BoxFit.cover)),
            ),
            ListTile(
              title: Text(name ?? ""),
              subtitle: Text(duration ?? ""),
            )
          ],
        ),
        const Positioned(
          bottom: 40,
          right: 30,
          child: CircleAvatar(
            radius: 30,
            child: Icon(
              Icons.play_arrow_rounded,
              size: 40,
            ),
          ),
        )
      ],
    );
  }
}

class SongsBuilder extends StatelessWidget {
  const SongsBuilder({super.key, required this.tracks});
  final List<Track>? tracks;
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Column(
        children: [
          const Heading(title: "Featuring"),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tracks!.length,
            itemBuilder: (context, index) => ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: showBackgroudImageProvider(
                          tracks![index].thumbnail[0].url),
                    )),
                width: 60,
                height: 80,
              ),
              title: Text(
                tracks![index].title,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(tracks![index].artists![0].name ?? ""),
              trailing: const SizedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite_border_rounded,
                      size: 30,
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.more_vert,
                      size: 30,
                    )
                  ],
                ),
              ),
              onTap: () {
                // print(tracks![index].videoId);
                context.push(
                    '/player?videoId=${tracks![index].videoId}&image=${tracks![index].thumbnail[1].url}');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RelatedPlaylistBuilder extends StatelessWidget {
  const RelatedPlaylistBuilder({super.key, required this.related});
  final List<dynamic>? related;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Heading(title: 'Related Playlist'),
        ),
        MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: related!.length,
            itemBuilder: (context, index) {
              return ListTile(
                trailing: TextButton(
                  onPressed: () {
                    context.push('/playlist?id=${related![index].playlistId}');
                  },
                  child: const Text("Open"),
                ),
                title: Text(
                  related![index].title ?? "",
                  maxLines: 1,
                ),
                subtitle: Text(
                  related![index].description ?? "",
                  maxLines: 2,
                ),
                leading: SizedBox(
                  height: 80,
                  width: 80,
                  child: showBackgroudImage(
                      related![index].thumbnails![0].url ?? ""),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
