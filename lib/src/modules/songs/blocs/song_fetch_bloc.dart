import 'dart:typed_data';

import 'package:audio_query/audio_query.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:music_player/src/modules/common/blocs/loading_bloc.dart';

class SongFetchBloc extends LoadingBloc {
  late FlutterAudioQuery _query;
  late Rx<List<SongInfo>> songs;
  final Rx<String?> error = null.obs;

  SongFetchBloc() {
    _query = FlutterAudioQuery();
    songs = Rx([]);
    fetchSongs();
  }

  void fetchSongs() {
    loaded(() async {
      try {
        List<SongInfo> data = await _query.getSongs(
          sortType: SongSortType.DISPLAY_NAME,
        );
        print(data.first.filePath);
        songs(data);
      } catch (e) {
        error("Failed to get Songs");
      }
    });
  }

  Future<Uint8List> fetchArtwork(String id, double size) async {
    try {
      return await _query.getArtwork(
        type: ResourceType.SONG,
        id: id,
        size: Size(size, size),
      );
    } catch (e) {
      return Uint8List.fromList([]);
    }
  }
}
