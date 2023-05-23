import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:music/api/home_api.dart';
import 'package:music/utils/utils.dart';

class RecommendedMusicVideo extends ConsumerStatefulWidget {
  const RecommendedMusicVideo({
    super.key,
    this.contents,
  });
  final List<Content>? contents;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecommendedMusicVideoState();
}

class _RecommendedMusicVideoState extends ConsumerState<RecommendedMusicVideo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Recommended music videos',
            style:  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 22),
          ),
        ),
        SizedBox(
           
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
                itemCount: widget.contents!.length,
                 
                itemBuilder: (context, index) => Column(
                      children: [
                        Container(
                          width: widget.contents![index].thumbnails!
                                  .elementAt(0)
                                  .width!
                                  .toDouble() ,
                          height: widget.contents![index].thumbnails!
                                  .elementAt(0)
                                  .height!
                                  .toDouble() ,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: showBackgroudImageProvider(widget
                                          .contents![index].thumbnails!
                                          .elementAt(0)
                                          .url ??
                                      ""))),
                        ),
                        Text(
                          widget.contents![index].title ?? "",
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(overflow: TextOverflow.ellipsis),
                        )
                      ],
                    )))
      ],
    );
  }
}
