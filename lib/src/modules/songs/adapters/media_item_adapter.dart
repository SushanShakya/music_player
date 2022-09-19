import 'package:audio_service/audio_service.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';

class MediaItemAdapter {
  late MediaItem data;

  MediaItemAdapter._();

  MediaItemAdapter.fromSongModel(SongModel song) {
    data = MediaItem(
      id: song.id,
      title: song.subtitle,
      displayTitle: song.title,
      artUri: Uri.parse(
        'content://media/external/audio/media/${song.id}/albumart',
      ),
    );
  }
}