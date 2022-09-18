import 'dart:typed_data';

import 'package:audio_query/audio_query.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/src/extensions/str_extension.dart';
import 'package:music_player/src/modules/common/components/tap_effect.dart';

import 'package:music_player/src/modules/songs/blocs/song_fetch_bloc.dart';
import 'package:music_player/src/modules/songs/blocs/song_play_bloc.dart';

import '../../common/components/squircle_border.dart';

class SongWidget extends StatelessWidget {
  final SongInfo song;
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
          _Image(id: song.id),
          const SizedBox(width: 10),
          Expanded(
            child: _Content(
              title: song.displayName,
              subtitle: song.title,
              duration: song.duration.durationFormat,
            ),
          ),
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final String id;
  const _Image({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final ctrl = Get.find<SongFetchBloc>();
    return SizedBox(
      height: width * 0.25,
      width: width * 0.25,
      child: Material(
        shape: const SquircleBorder(
          side: BorderSide(color: Colors.black),
        ),
        child: FutureBuilder<Uint8List>(
          future: ctrl.fetchArtwork(id, width * 0.25),
          builder: (c, s) {
            if (s.hasData) {
              if (s.data!.isEmpty) return Container();
              return Image.memory(s.data!);
            }
            return Container();
          },
        ),
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
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          subtitle,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 12,
            height: 1.3,
            color: Color(0xffBEBEBE),
          ),
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
