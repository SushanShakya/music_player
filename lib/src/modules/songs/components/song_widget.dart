import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/src/modules/common/components/tap_effect.dart';

import 'package:music_player/src/modules/songs/blocs/song_play_bloc.dart';
import 'package:music_player/src/modules/songs/components/song_image.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';
import 'package:music_player/src/res/styles.dart';

class SongWidget extends StatelessWidget {
  final SongModel song;
  const SongWidget({
    Key? key,
    required this.song,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<SongPlayBloc>();
    return TapEffect(
      onClick: () {
        ctrl.playSong(song);
      },
      child: Row(
        children: [
          SongImage(song: song),
          const SizedBox(width: 10),
          Expanded(
            child: _Content(
              title: song.title,
              subtitle: song.subtitle,
              duration: song.fomattedDuration,
            ),
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final String title;
  final String subtitle;
  final String duration;
  const _Content({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.duration,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(thickness: 2),
        Text(
          title,
          maxLines: 1,
          style: titleStyle,
        ),
        Text(
          subtitle,
          maxLines: 2,
          style: subtitleStyle,
        ),
        const Divider(thickness: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(Icons.access_time, size: 16),
            const SizedBox(width: 2),
            Expanded(
              child: Text(
                duration,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 5),
            TapEffect(
              onClick: () {},
              child: const Icon(Icons.playlist_add),
            ),
            const SizedBox(width: 5),
            // const Icon(Icons.play_arrow_rounded),
          ],
        ),
        const Divider(thickness: 2),
      ],
    );
  }
}
