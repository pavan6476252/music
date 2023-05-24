import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunitySuggestedSongs extends ConsumerStatefulWidget {
  const CommunitySuggestedSongs({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CommunitySuggestedSongsState();
}

class _CommunitySuggestedSongsState
    extends ConsumerState<CommunitySuggestedSongs> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SuggestedSongTile(),
        SuggestedSongTile(),
        SuggestedSongTile(),
        SuggestedSongTile(),
      ],
    );
  }
}

//song tile

class SuggestedSongTile extends StatelessWidget {
  const SuggestedSongTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('assets/images/vinayaka.jpg'),
        ),
        title: Text(
          "Alternative streee dj song",
          style: TextStyle(fontWeight: FontWeight.w500,overflow: TextOverflow.ellipsis), 
        ),
        subtitle: Text(
          "Broad casting live from new york city . Bringing you the best House dj songs..",
          style: TextStyle(
            
              fontSize: 11, color: Color.fromARGB(255, 136, 136, 136)),
              maxLines: 2,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite_border, size: 25),
            SizedBox(width: 8),
            Icon(
              Icons.play_arrow_outlined,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
