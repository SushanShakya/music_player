import 'dart:io';
import 'package:android_content_provider/android_content_provider.dart';
import 'package:flutter/services.dart';
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

  static Future<bool> checkExists(String uri) async {
    try {
      var data = await AndroidContentResolver.instance.loadThumbnail(
        uri: uri,
        width: 100,
        height: 100,
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
