import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:music_player/constants/assets.dart';
import 'package:music_player/src/modules/common/components/squircle_widget.dart';
import 'package:on_audio_query/on_audio_query.dart' hide SongModel;

import '../models/song_model.dart';

class SongImage extends StatelessWidget {
  final SongModel? song;
  final double? size;

  static Map<String, Uint8List> data = {};

  const SongImage({
    Key? key,
    this.size,
    this.song,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final w = width * 0.25;
    Widget noImage = Image.asset(
      Assets.no_image,
      fit: BoxFit.cover,
    );
    return SquircleWidget(
      size: size ?? w,
      child: song == null
          ? noImage
          : data[song!.id] != null
              ? Image.memory(
                  data[song!.id]!,
                  gaplessPlayback: false,
                  repeat: ImageRepeat.noRepeat,
                  scale: 1.0,
                  width: w,
                  height: w,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  errorBuilder: (context, exception, stackTrace) {
                    return noImage;
                  },
                )
              : FutureBuilder<Uint8List?>(
                  future: OnAudioQuery().queryArtwork(
                    int.parse(song!.id),
                    ArtworkType.AUDIO,
                    format: ArtworkFormat.JPEG,
                    size: (w).toInt(),
                    quality: 100,
                  ),
                  builder: (c, item) {
                    if (item.data != null && item.data!.isNotEmpty) {
                      if (data[song!.id] == null) {
                        data[song!.id] = item.data!;
                      }
                      return Image.memory(
                        item.data!,
                        gaplessPlayback: false,
                        repeat: ImageRepeat.noRepeat,
                        scale: 1.0,
                        width: w,
                        height: w,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        errorBuilder: (context, exception, stackTrace) {
                          return noImage;
                        },
                      );
                    } else {
                      return noImage;
                    }
                  },
                ),
    );
  }
}
