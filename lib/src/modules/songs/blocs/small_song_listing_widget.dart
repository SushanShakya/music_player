import 'package:flutter/material.dart';

import 'package:music_player/src/modules/songs/components/song_widget.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';

class SmallSongListingWidget extends StatelessWidget {
  final List<SongModel> songs;
  const SmallSongListingWidget({
    Key? key,
    required this.songs,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        songs.length,
        (i) {
          var song = songs[i];
          return Padding(
            padding: i == (songs.length - 1)
                ? EdgeInsets.zero
                : const EdgeInsets.only(bottom: 10.0),
            child: SongWidget(song: song),
          );
        },
      ),
    );
  }
}
