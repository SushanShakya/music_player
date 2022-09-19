import 'package:audio_query/audio_query.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';
import 'package:music_player/src/modules/songs/repo/song_fetch_repo.dart';

import '../adapters/song_model_adapter.dart';

class AudioQuerySongFetchRepo extends ISongFetchRepo {
  late FlutterAudioQuery _query;

  AudioQuerySongFetchRepo() {
    _query = FlutterAudioQuery();
  }

  @override
  Future<List<SongModel>> fetchSongs() async {
    List<SongInfo> data = await _query.getSongs(
      sortType: SongSortType.DISPLAY_NAME,
    );
    return List<SongModel>.from(
      data.map((e) => SongModelAdapter.fromSongInfo(e).data),
    );
  }
}
