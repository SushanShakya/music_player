import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:music_player/main.dart';
import 'package:music_player/src/modules/player/adapters/audio_service_repeat_mode_adapter.dart';
import 'package:music_player/src/modules/player/enums/repeat_mode.dart';
import 'package:music_player/src/modules/player/models/progress_bar_model.dart';
import 'package:music_player/src/modules/player/models/repeat_model.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';
import 'package:music_player/src/services/sound/sound_handler.dart';

class PlayerControlBloc extends GetxController {
  Rx<bool> isPlaying = false.obs;

  Rx<bool> isFirst = false.obs;
  Rx<bool> isLast = false.obs;

  Rx<bool> shuffleMode = false.obs;

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

    audioHandler.shuffleMode.stream.listen(shuffleMode);

    audioHandler.playbackState.listen((item) {
      duration(duration.value.copyWith(buffered: item.bufferedPosition));
    });

    audioHandler.queue.listen((playlist) {
      _updateSkipBtns();
    });
    audioHandler.mediaItem.listen((value) {
      _updateSkipBtns();
    });
    audioHandler.repeatMode.stream.listen((event) {
      _updateSkipBtns();
    });
  }

  void _updateSkipBtns() {
    final mediaItem = audioHandler.mediaItem.value;
    final playlist = audioHandler.queue.value;
    final loopMode = audioHandler.mode;
    final isRepeated = loopMode == RepeatMode.playlist;
    if (playlist.length < 2 || mediaItem == null) {
      isFirst(true && !isRepeated);
      isLast(true && !isRepeated);
    } else {
      isFirst(playlist.first.id == mediaItem.id && !isRepeated);
      isLast(playlist.last.id == mediaItem.id && !isRepeated);
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

  void seek(double percent) {
    ProgressBarState state = duration.value;
    Duration d = Duration(
      milliseconds: (state.total.inMilliseconds * percent).toInt(),
    );
    audioHandler.seek(d);
  }

  void repeat() {
    repeatModel.update();
    final mode = repeatModel.mode.value;
    audioHandler
        .setRepeatMode(AudioServiceRepeatModeAdapter.fromRepeatMode(mode).data);
  }

  void shuffle() => audioHandler
      .setShuffleMode(AudioServiceShuffleModeUtil.fromBool(!shuffleMode.value));
}
