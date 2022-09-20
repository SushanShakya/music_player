import 'package:audio_query/audio_query.dart';
import 'package:audio_service/audio_service.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';

class SongModelAdapter {
  late SongModel data;
  SongModelAdapter._();
  SongModelAdapter.fromMediaItem(MediaItem item) {
    data = SongModel(
      id: item.id,
      albumId: item.album ?? '',
      uri: item.artUri.toString(),
      title: item.displayTitle ?? item.title,
      subtitle: item.title,
      duration: item.duration?.inMilliseconds.toString() ?? '0',
      album: item.album ?? '',
    );
  }

  SongModelAdapter.fromSongInfo(SongInfo item) {
    data = SongModel(
      id: item.id,
      albumId: item.albumId,
      uri: item.uri,
      title: item.displayName,
      subtitle: item.title,
      duration: item.duration,
      album: item.album,
    );
  }

  SongModelAdapter.fromMediaStore(List<Object?> item) {
    var id = item[0] as String;
    data = SongModel(
      id: id,
      uri: 'content://media/external/audio/media/$id',
      album: item[1] as String,
      albumId: (item[2] as int).toString(),
      title: item[6] as String,
      subtitle: item[4] as String,
      duration: item[5] as String,
    );
  }
}
