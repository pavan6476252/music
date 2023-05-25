import 'package:flutter/material.dart';

const vinayak =
    'https://www.wallpapertip.com/wmimgs/66-666864_god-vinayagar-wallpapers-free-download-psy-ganesha.jpg';

const cristian =
    'https://img.freepik.com/free-photo/free-photo-good-friday-background-with-jesus-christ-cross_1340-28455.jpg?w=2000';

class EssentialPlaylistsData {
  static List<PlayListData> data = [
    PlayListData(
        icon: (Icons.music_note_outlined),
        image: vinayak,
        title: "GOD SONGS",
        subtitle: "Playlist",
        id: "PLBB_MwfPi6EGDnoqfl2YW6RYJge-TnItA"),
    PlayListData(
        icon: (Icons.music_note_outlined),
        image: cristian,
        title: "Cristian Songs",
        subtitle: "Playlist",
        id: "PLBB_MwfPi6EHj-9yqnh4eSl4JcM7RDlWY"),
  ];
}

class PlayListData {
  final String image;
  final String title;
  final String id;
  final String subtitle;
  final IconData icon;
  PlayListData(
      {required this.icon,
      required this.id,
      required this.image,
      required this.title,
      required this.subtitle});
}
