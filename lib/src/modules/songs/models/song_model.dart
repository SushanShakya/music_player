import 'package:android_content_provider/android_content_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player/src/extensions/str_extension.dart';

import '../blocs/song_fetch_bloc.dart';

class SongModel extends Equatable {
  final String id;
  final String albumId;
  final String album;
  final String uri;
  final String title;
  final String subtitle;
  final String duration;
  final int created;

  DateTime get createdDate =>
      DateTime.fromMillisecondsSinceEpoch(created * 1000);

  String get artUri => 'content://media/external/audio/media/$id/albumart';

  int get album_id {
    int? data = int.tryParse(albumId);
    data ??= -1;
    return data;
  }

  String get fomattedDuration {
    return duration.durationFormat;
  }

  String? get imageUrl {
    return SongFetchBloc.arts[album_id];
  }

  const SongModel({
    required this.id,
    required this.album,
    required this.albumId,
    required this.uri,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.created,
  });

  // From https://developer.android.com/reference/android/provider/MediaStore.MediaColumns
  static const mediaStoreProjection = [
    '_id',
    'album',
    'album_id',
    'artist',
    'title',
    'duration',
    '_display_name',
    "date_added",
  ];

  static NativeCursorGetBatch createBatch(NativeCursor cursor) =>
      cursor.batchedGet()
        ..getString(0)
        ..getString(1)
        ..getInt(2)
        ..getString(3)
        ..getString(4)
        ..getString(5)
        ..getString(6).getInt(7);

  @override
  List<Object?> get props => [id, imageUrl, title, subtitle, duration, uri];
}
