import 'package:just_audio/just_audio.dart';
import 'package:music_player/src/modules/player/enums/repeat_mode.dart';

class RepeatModeAdapter {
  late RepeatMode data;

  RepeatModeAdapter.fromLoopMode(LoopMode mode) {
    data = _getData(mode);
  }

  RepeatMode _getData(LoopMode mode) {
    switch (mode) {
      case LoopMode.all:
        return RepeatMode.playlist;
      case LoopMode.one:
        return RepeatMode.song;
      case LoopMode.off:
        return RepeatMode.off;
    }
  }
}
