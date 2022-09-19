import 'package:android_content_provider/android_content_provider.dart';
import 'package:music_player/src/modules/songs/adapters/song_model_adapter.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';
import 'package:music_player/src/modules/songs/repo/song_fetch_repo.dart';

class ContentResolverSongFetchRepo extends ISongFetchRepo {
  @override
  Future<List<SongModel>> fetchSongs() async {
    final cursor = await AndroidContentResolver.instance.query(
      // MediaStore.Audio.Media.EXTERNAL_CONTENT_URI
      uri: 'content://media/external/audio/media',
      projection: SongModel.mediaStoreProjection,
      selection: 'is_music != 0',
      selectionArgs: null,
      sortOrder: null,
    );
    try {
      final songCount =
          (await cursor!.batchedGet().getCount().commit()).first as int;
      final batch = SongModel.createBatch(cursor);
      final songsData = await batch.commitRange(0, songCount);
      return List<SongModel>.from(
        songsData.map((data) => SongModelAdapter.fromMediaStore(data).data),
      );
    } finally {
      cursor?.close();
    }
  }
}
