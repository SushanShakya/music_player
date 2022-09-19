import '../models/song_model.dart';

abstract class ISongFetchRepo {
  Future<List<SongModel>> fetchSongs();
}
