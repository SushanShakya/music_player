import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:music_player/main.dart';
import 'package:music_player/src/modules/player/adapters/audio_service_repeat_mode_adapter.dart';
import 'package:music_player/src/modules/player/enums/repeat_mode.dart';
import 'package:music_player/src/modules/player/models/progress_bar_model.dart';
import 'package:music_player/src/modules/player/models/repeat_model.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';

class PlayerControlBloc extends GetxController {
  Rx<bool> isPlaying = false.obs;

  Rx<bool> isFirst = false.obs;
  Rx<bool> isLast = false.obs;

  Rx<SongModel?> currentSong = Rx<SongModel?>(null);
  Rx<ProgressBarState> duration = ProgressBarState.initial().obs;
  late RepeatModel repeatModel;

  RepeatMode get repeatMode => repeatModel.mode.value;

  PlayerControlBloc() {
    repeatModel = RepeatModel();
    audioHandler.playbackState
        .map((e) => e.playing)
        .distinct()
        .listen(isPlaying);

    audioHandler.currentSong.stream.listen((s) {
      currentSong(s);
    });

    AudioService.position.listen((d) {
      duration(duration.value.copyWith(current: d));
    });

    audioHandler.mediaItem.listen((item) {
      duration(duration.value.copyWith(total: item?.duration));
    });

    audioHandler.playbackState.listen((item) {
      duration(duration.value.copyWith(buffered: item.bufferedPosition));
    });

    audioHandler.queue.listen((playlist) {
      _updateSkipBtns();
    });
  }

  void _updateSkipBtns() {
    final mediaItem = audioHandler.mediaItem.value;
    final playlist = audioHandler.queue.value;
    if (playlist.length < 2 || mediaItem == null) {
      isFirst(true);
      isLast(true);
    } else {
      isFirst(playlist.first == mediaItem);
      isLast(playlist.last == mediaItem);
    }
  }

  void togglePlaying() {
    if (isPlaying.value) {
      pause();
    } else {
      play();
    }
  }

  void play() {
    audioHandler.play();
  }

  void pause() => audioHandler.pause();
  void stop() => audioHandler.stop();
  void next() => audioHandler.skipToNext();
  void prev() => audioHandler.skipToPrevious();

  void repeat() {
    repeatModel.update();
    final mode = repeatModel.mode.value;
    audioHandler.setRepeatMode(
      AudioServiceRepeatModeAdapter.fromRepeatMode(mode).data,
    );
  }
}
