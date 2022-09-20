import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:music_player/main.dart';
import 'package:music_player/src/modules/home/models/progress_bar_model.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';

class PlayerControlBloc extends GetxController {
  Rx<bool> isPlaying = false.obs;

  Rx<SongModel?> currentSong = Rx<SongModel?>(null);
  Rx<ProgressBarState> duration = ProgressBarState.initial().obs;

  PlayerControlBloc() {
    audioHandler.playbackState
        .map((e) => e.playing)
        .distinct()
        .listen(isPlaying);

    audioHandler.currentSong.stream.listen((s) {
      print('----- LISTENING TO SONG');
      currentSong(s);
    });

    AudioService.position.listen((d) {
      duration(duration.value.copyWith(current: d));
    });

    audioHandler.mediaItem.listen((item) {
      duration(duration.value.copyWith(total: item?.duration));
    });
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
  void next() {}
  void prev() {}
}
