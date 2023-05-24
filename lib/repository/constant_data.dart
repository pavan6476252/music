import 'package:flutter/material.dart';

const vinayak =
    'https://www.wallpapertip.com/wmimgs/66-666864_god-vinayagar-wallpapers-free-download-psy-ganesha.jpg';

class EssentialPlaylistsData {
  static List<PlayListData> data = [
    PlayListData((Icons.music_note_outlined), vinayak, "CHILL OUT", "24 songs"),
    PlayListData((Icons.music_note_outlined), vinayak, "workoUT", "14 songs"),
    PlayListData((Icons.music_note_outlined), vinayak, "ParkOUT", "24 songs"),
    PlayListData((Icons.music_note_outlined), vinayak, "NightMood OUT", "24 songs"),
    PlayListData((Icons.music_note_outlined), vinayak, "Dj songs", "44 songs"),
    PlayListData((Icons.music_note_outlined), vinayak, "Dance", "14 songs"),
    PlayListData((Icons.music_note_outlined), vinayak, "Love OUT", "24 songs"),
    PlayListData((Icons.music_note_outlined), vinayak, "old songs", "44 songs"),
  ];
}

class PlayListData {
  final String image;
  final String title;
  final String subtitle;
  final IconData icon;
  PlayListData(this.icon, this.image, this.title, this.subtitle);
}
