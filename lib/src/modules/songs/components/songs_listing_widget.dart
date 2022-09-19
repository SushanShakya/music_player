import 'package:flutter/material.dart';

import 'package:music_player/src/modules/songs/components/song_widget.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';

class SongsListingWidget extends StatelessWidget {
  final List<SongModel> songs;
  const SongsListingWidget({
    Key? key,
    required this.songs,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: songs.length,
      separatorBuilder: (c, i) => const SizedBox(height: 10),
      itemBuilder: (c, i) {
        var cur = songs[i];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SongWidget(song: cur),
        );
      },
    );
  }
}
