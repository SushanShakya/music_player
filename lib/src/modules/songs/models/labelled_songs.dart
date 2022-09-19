import 'package:equatable/equatable.dart';

import 'package:music_player/src/modules/songs/models/song_model.dart';

class LabelledSongs extends Equatable {
  final String title;
  final List<SongModel> songs;

  const LabelledSongs({
    required this.title,
    required this.songs,
  });

  @override
  List<Object> get props => [title, songs];
}
