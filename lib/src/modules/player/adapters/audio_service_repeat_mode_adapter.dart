import 'package:audio_service/audio_service.dart';

import '../enums/repeat_mode.dart';

class AudioServiceRepeatModeAdapter {
  late AudioServiceRepeatMode data;

  AudioServiceRepeatModeAdapter.fromRepeatMode(RepeatMode mode) {
    data = _getMode(mode);
  }

  AudioServiceRepeatMode _getMode(RepeatMode mode) {
    switch (mode) {
      case RepeatMode.off:
        return AudioServiceRepeatMode.none;
      case RepeatMode.song:
        return AudioServiceRepeatMode.one;
      case RepeatMode.playlist:
        return AudioServiceRepeatMode.all;
    }
  }
}
