import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:music/api/home_api.dart';
import 'package:music/utils/utils.dart';

class CelebratingAsianCulture extends ConsumerStatefulWidget {
  const CelebratingAsianCulture({
    super.key,
    this.contents,
  });
  final List<Content>? contents;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CelebratingAsianCultureState();
}

class _CelebratingAsianCultureState extends ConsumerState<CelebratingAsianCulture> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Celebrating Asian culture',
            style:  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 22),
          ),
        ),
        SizedBox(
            height: 250,
            width: double.maxFinite,
            child: ListView.builder(
                itemCount: widget.contents!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Column(
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
