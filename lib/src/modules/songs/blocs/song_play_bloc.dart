import 'package:audio_query/audio_query.dart';
import 'package:get/get.dart';
import 'package:music_player/main.dart';
import 'package:music_player/src/services/sound/sound_handler.dart';

class SongPlayBloc extends GetxController {
  late Rx<bool> isPlaying;
  late Rx<String?> currentSongId;
  late SoundHandler _player;

  SongPlayBloc() {
    _player = audioHandler;
    isPlaying = false.obs;
    currentSongId = null.obs;
  }

  void togglePlaying() {
    isPlaying(!isPlaying.value);
  }

  void playSong(SongInfo song) {
    _player.setSong(song).then((value) => _player.play());
  }

  Future<void> pauseSong() => _player.pause();
}
