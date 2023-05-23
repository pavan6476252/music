import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:music/api/audio_provider.dart';
import 'package:music/api/home_api.dart';
import 'package:music/utils/utils.dart';

class QuickPick extends ConsumerStatefulWidget {
  const QuickPick({
    super.key,
    this.contents,
  });
  final List<Content>? contents;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuickPickState();
}

class _QuickPickState extends ConsumerState<QuickPick> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Quick Picks',
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 22),
          ),
        ),
        SizedBox(
          height: 190,
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: widget.contents!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(5),
              width: 150,
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 65,
                        backgroundImage: showBackgroudImageProvider(widget
                                .contents![index].thumbnails!
                                .elementAt(1)
                                .url ??
                            ""),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Card(
                          child: IconButton(
                              onPressed: () {
                                 ref
                              .read(audioPlayerProvider.notifier)
                              .playAudio(widget
                                .contents![index].videoId??'');
                              }, icon: Icon(Ionicons.play)),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.contents![index].title ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(overflow: TextOverflow.ellipsis),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
