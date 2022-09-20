import 'dart:io';
import 'dart:typed_data';

import 'package:android_content_provider/android_content_provider.dart';
import 'package:flutter/material.dart';
import 'package:music_player/constants/assets.dart';
import 'package:music_player/src/modules/common/components/squircle_widget.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';

class SongImage extends StatefulWidget {
  final SongModel? song;
  final double? size;
  const SongImage({
    Key? key,
    this.size,
    this.song,
  }) : super(key: key);

  @override
  State<SongImage> createState() => _SongImageState();
}

class _SongImageState extends State<SongImage> {
  CancellationSignal? _loadSignal;
  Uint8List? _bytes;
  bool loaded = false;

  static const int _artSize = 60;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.song != null) {
      _fetchArt();
    }
  }

  @override
  void didUpdateWidget(covariant SongImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.song != null && oldWidget.song != null) {
      if (widget.song!.id != oldWidget.song!.id) {
        _fetchArt();
      }
    }
  }

  int getCacheSize() {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    return (_artSize * devicePixelRatio).toInt();
  }

  Future<void> _fetchArt() async {
    _loadSignal?.cancel();
    _loadSignal = CancellationSignal();
    final cacheSize = getCacheSize();
    try {
      _bytes = await AndroidContentResolver.instance.loadThumbnail(
        uri: widget.song!.uri,
        width: cacheSize,
        height: cacheSize,
        cancellationSignal: _loadSignal,
      );
    } catch (e) {
      _bytes = null;
    }
    if (_bytes == null) {
      try {
        _bytes = await AndroidContentResolver.instance.loadThumbnail(
          uri: widget.song!.artUri,
          width: cacheSize,
          height: cacheSize,
          cancellationSignal: _loadSignal,
        );
      } catch (e) {
        _bytes = null;
      }
    }
    if (mounted) {
      setState(() {
        loaded = true;
      });
    }
  }

  @override
  void dispose() {
    _loadSignal?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final artPath = widget.song?.imageUrl;
    File? file;
    if (artPath != null) file = File(artPath);
    return SquircleWidget(
      size: widget.size ?? width * 0.25,
      child: (_bytes != null)
          ? Image.memory(
              _bytes!,
              fit: BoxFit.cover,
            )
          : (artPath != null && (file?.existsSync() ?? false))
              ? Image.file(
                  file!,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  Assets.no_image,
                  fit: BoxFit.cover,
                ),
    );
  }
}
