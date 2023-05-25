//horizontal playlistCards builder
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:music/utils/utils.dart';

import '../../../repository/constant_data.dart';
import '../../../utils/constants.dart';

class SuggestedPlaylistCards extends ConsumerStatefulWidget {
  const SuggestedPlaylistCards(
      {super.key, required this.data, required this.offset});
  final List<PlayListData> data;
  final int offset;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SuggestedPlaylistCardsState();
}

class _SuggestedPlaylistCardsState
    extends ConsumerState<SuggestedPlaylistCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.data.length,
        itemBuilder: (context, index) => PLaylistCard(
            index: index, data: widget.data[widget.offset + index]),
      ),
    );
  }
}

//playlist cards
class PLaylistCard extends StatelessWidget {
  const PLaylistCard({
    required this.index,
    required this.data,
    super.key,
  });
  final PlayListData data;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/playlist?id=${data.id}');
      },
      child: Container(
        margin: EdgeInsets.only(left: index == 0 ? 10 : 8),
        padding: const EdgeInsets.all(10),
        width: 140,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: showBackgroudImageProvider(data.image),
                fit: BoxFit.cover),
            backgroundBlendMode: BlendMode.darken,
            color: colorsList[index % colorsList.length],
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              (data.icon),
              color: Colors.white,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white, overflow: TextOverflow.clip),
                ),
                Text(
                  data.subtitle,
                  style: TextStyle(
                      color: Color.fromARGB(255, 193, 193, 193), fontSize: 10),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
