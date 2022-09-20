import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class JustAudioRepeatAdapter {
  late LoopMode data;

  JustAudioRepeatAdapter.fromAudioService(AudioServiceRepeatMode mode) {
    data = _getMode(mode);
  }

  LoopMode _getMode(AudioServiceRepeatMode mode) {
    switch (mode) {
      case AudioServiceRepeatMode.all:
        return LoopMode.all;
      case AudioServiceRepeatMode.one:
        return LoopMode.one;
      default:
        return LoopMode.off;
    }
  }
}
