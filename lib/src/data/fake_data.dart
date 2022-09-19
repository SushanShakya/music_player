import 'package:music_player/src/modules/songs/models/song_model.dart';

class FakeData {
  static List<SongModel> get songs => List.generate(
        10,
        (i) => const SongModel(
          id: "1",
          albumId: '1',
          uri: '',
          title: 'Om Shanti Om',
          subtitle: 'T-series',
          duration: '100',
        ),
      );
}
