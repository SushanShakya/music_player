import 'package:get/get.dart';
import 'package:music_player/main.dart';
import 'package:music_player/src/modules/player/enums/playlist_mode.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';
import 'package:music_player/src/services/sound/sound_handler.dart';

class SongPlayBloc extends GetxController {
  late Rx<String?> currentSongId;
  late SoundHandler _player;

  SongPlayBloc() {
    _player = audioHandler;
    currentSongId = null.obs;
  }

  Future<void> setPlaylist(List<SongModel> playlist, PlaylistMode mode) =>
      _player.setPlaylist(playlist, mode);

  Future<void> playSong(SongModel song) =>
      _player.setSong(song).then((value) => _player.play());

  Future<void> pauseSong() => _player.pause();
}
