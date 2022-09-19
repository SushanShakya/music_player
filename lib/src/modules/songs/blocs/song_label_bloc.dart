import 'package:get/get.dart';
import 'package:music_player/src/modules/songs/models/labelled_songs.dart';

import '../models/song_model.dart';

class SongLabelBloc extends GetxController {
  late Rx<List<LabelledSongs>> labeledSongs;

  SongLabelBloc(List<SongModel> songs) {
    var data = _labelSongs(songs);
    labeledSongs = Rx(data);
  }

  List<LabelledSongs> _labelSongs(List<SongModel> songs) {
    var data = <LabelledSongs>[];
    for (var title in titles) {
      late List<SongModel> x;
      if (title == '#') {
        x = songs.where((e) {
          if (e.title.isEmpty) return true;
          return !titles.skip(1).contains(e.title[0].toUpperCase());
        }).toList();
      } else {
        x = songs
            .where((e) => e.title.toUpperCase().startsWith(title))
            .toList();
      }
      if (x.isEmpty) continue;
      data.add(LabelledSongs(title: title, songs: x));
    }
    return data;
  }

  static List<String> titles = "#ABCDEFGHIJKLMNOPQRSTUVWXYZ".split('').toList();
}
