import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/src/modules/common/components/tap_effect.dart';
import 'package:music_player/src/modules/player/blocs/player_control_bloc.dart';
import 'package:music_player/src/modules/player/components/waveform_widget.dart';

import 'package:music_player/src/modules/songs/blocs/song_play_bloc.dart';
import 'package:music_player/src/modules/songs/components/song_image.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';
import 'package:music_player/src/res/colors.dart';
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
    final ctrl2 = Get.find<PlayerControlBloc>();
    final width = MediaQuery.of(context).size.width;
    return TapEffect(
      onClick: () {
        ctrl.playSong(song);
      },
      child: Row(
        children: [
          Obx(() {
            final cur = ctrl2.currentSong.value;
            final isPlaying = ctrl2.isPlaying.value;
            bool show = (cur != null && isPlaying && (cur.id == song.id));
            if (show) {
              const waveHeight = 20.0;
              final height = width * 0.25;
              const padding = 10;
              return SizedBox(
                width: height,
                height: height * 1.3,
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1.0),
                  duration: const Duration(milliseconds: 300),
                  builder: (c, t, ch) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: (height * (1 - t)) +
                              ((height - waveHeight - padding) * t),
                          padding: EdgeInsets.only(bottom: padding * t),
                          child: LayoutBuilder(
                            builder: (c, box) => SongImage(
                              song: song,
                              size: box.maxHeight,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: waveHeight * t,
                          child: (t == 1)
                              ? const WaveformWidget(
                                  maxHeight: waveHeight,
                                  color: scaffoldColor,
                                )
                              : const SizedBox(),
                        ),
                      ],
                    );
                  },
                ),
              );
            }
            return SongImage(song: song, size: width * 0.25);
          }),
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
