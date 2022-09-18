import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/src/modules/songs/blocs/song_fetch_bloc.dart';
import 'package:music_player/src/modules/songs/blocs/song_play_bloc.dart';
import 'package:music_player/src/modules/songs/components/song_widget.dart';

class SongsListingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var ctrl = Get.put(SongFetchBloc());
    var ctrl2 = Get.put(SongPlayBloc());
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Obx(
          () => ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: ctrl.songs.value.length,
            separatorBuilder: (c, i) => const SizedBox(height: 10),
            itemBuilder: (c, i) {
              var cur = ctrl.songs.value[i];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SongWidget(song: cur),
              );
            },
          ),
        ),
      ),
    );
  }
}
