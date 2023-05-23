import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:music/api/home_api.dart';
import 'package:music/utils/utils.dart';

class SoFar2023 extends ConsumerStatefulWidget {
  const SoFar2023({
    super.key,
    this.contents,
  });
  final List<Content>? contents;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SoFar2023State();
}

class _SoFar2023State extends ConsumerState<SoFar2023> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '2023 So Far',
             style:  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 22),
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
                  CircleAvatar(
                    radius: 65,
                    backgroundImage: showBackgroudImageProvider(
                        widget.contents![index].thumbnails!.elementAt(0).url ??
                            ""),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.contents![index].title ?? "",
                      style:  Theme.of(context).textTheme.bodyLarge!.copyWith(overflow: TextOverflow.ellipsis),
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
