import 'package:android_content_provider/android_content_provider.dart';
import 'package:get/get.dart';
import 'package:music_player/main.dart';
import 'package:music_player/src/modules/common/blocs/loading_bloc.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';
import 'package:music_player/src/modules/songs/repo/content_resolver_song_fetch_repo.dart';

import '../repo/song_fetch_repo.dart';

class SongFetchBloc extends LoadingBloc {
  late Rx<List<SongModel>> songs;
  late ISongFetchRepo r;
  final Rx<String?> error = null.obs;

  static Map<int, String> arts = {};

  SongFetchBloc({ISongFetchRepo? repo}) {
    r = repo ?? ContentResolverSongFetchRepo();
    songs = Rx([]);
    fetchSongs();
    _fetchArts();
  }

  void fetchSongs() {
    loaded(() async {
      try {
        var data = await r.fetchSongs();
        if (data.isNotEmpty) {
          audioHandler.setPlaylist(data);
        }
        songs(data);
      } catch (e) {
        error("Failed to get Songs");
      }
    });
  }

  Future<void> _fetchArts() async {
    final cursor = await AndroidContentResolver.instance.query(
      // Default android metadata
      // MediaStore.Audio.Albums.EXTERNAL_CONTENT_URI
      uri: 'content://media/external/audio/albums',
      projection: const ['_id', 'album_art'],
      selection: 'album_art != 0',
      selectionArgs: null,
      sortOrder: null,
    );
    if (cursor == null) return;
    try {
      final albumCount =
          (await cursor.batchedGet().getCount().commit()).first as int;
      final batch = cursor.batchedGet()
        ..getInt(0)
        ..getString(1);
      final albumsData = await batch.commitRange(0, albumCount);
      for (final data in albumsData) {
        arts[data.first as int] = data.last as String;
      }
    } finally {
      cursor.close();
    }
  }
}
