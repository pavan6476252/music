import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:music/api/home_api.dart';
import 'package:music/utils/utils.dart';

class TopMusicVideo extends ConsumerStatefulWidget {
  const TopMusicVideo({
    super.key,
    this.contents,
  });
  final List<Content>? contents;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TopMusicVideoState();
}

class _TopMusicVideoState extends ConsumerState<TopMusicVideo> {
  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Top music videos',
            style:  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 22),
          ),
        ),
        SizedBox(
            height: 220,
            width: double.maxFinite,
            child: ListView.builder(
                itemCount: widget.contents!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: widget.contents![index].thumbnails!
                                    .elementAt(0)
                                    .width!
                                    .toDouble() *
                                0.7,
                            height: widget.contents![index].thumbnails!
                                    .elementAt(0)
                                    .height!
                                    .toDouble() *
                                0.7,
                            
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: showBackgroudImageProvider(widget
                                            .contents![index].thumbnails!
                                            .elementAt(0)
                                            .url ??
                                        ""))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.contents![index].title ?? "",
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(overflow: TextOverflow.ellipsis),
                            ),
                          )
                        ],
                      ),
                )))
      ],
    );
  }
}
