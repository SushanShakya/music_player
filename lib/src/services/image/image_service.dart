import 'dart:io';
import 'package:flutter/services.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  static Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File(
      '${(await getApplicationSupportDirectory()).path}/$path',
    );
    if (!await file.exists()) {
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file;
  }

  static Future<bool> checkExists(String id) async {
    try {
      var data = await OnAudioQuery().queryArtwork(
        int.parse(id),
        ArtworkType.AUDIO,
        format: ArtworkFormat.JPEG,
        size: 200,
        quality: 100,
      );
      if (data == null) throw 'e';
      return true;
    } catch (e) {
      return false;
    }
  }
}
