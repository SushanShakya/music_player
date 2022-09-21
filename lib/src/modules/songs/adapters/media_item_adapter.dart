import 'package:audio_service/audio_service.dart';
import 'package:music_player/main.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';
import 'package:music_player/src/services/image/image_service.dart';

class MediaItemAdapter {
  late MediaItem data;

  MediaItemAdapter._();

  MediaItemAdapter.fromSongModel(SongModel song) {
    data = MediaItem(
      id: song.id,
      title: song.subtitle,
      displayTitle: song.title,
      extras: {'uri': song.uri, 'album_id': song.album},
      album: song.album,
      artUri: Uri.parse(song.artUri),
      duration: Duration(milliseconds: int.parse(song.duration)),
    );
  }

  static Future<MediaItem> createFromSongModel(SongModel song) async {
    var data = MediaItem(
      id: song.id,
      title: song.subtitle,
      displayTitle: song.title,
      extras: {'uri': song.uri, 'album_id': song.album},
      album: song.album,
      artUri: Uri.parse(song.artUri),
      duration: Duration(milliseconds: int.parse(song.duration)),
    );
    if (await ImageService.checkExists(song.uri)) {
      return data;
    } else {
      return data.copyWith(
        artUri: noImgFile.uri,
      );
    }
  }

  static Future<MediaItem> createFromMediaItem(MediaItem song) async {
    var data = song;
    if (await ImageService.checkExists(song.artUri.toString())) {
      return data;
    } else {
      return data.copyWith(
        artUri: noImgFile.uri,
      );
    }
  }
}
