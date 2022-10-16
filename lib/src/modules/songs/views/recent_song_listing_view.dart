import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/src/modules/player/enums/playlist_mode.dart';
import 'package:music_player/src/modules/songs/blocs/song_fetch_bloc.dart';
import 'package:music_player/src/modules/songs/blocs/song_play_bloc.dart';
import 'package:music_player/src/modules/songs/components/song_widget.dart';
import 'package:music_player/src/modules/songs/views/base_song_listing_view.dart';

class RecentSongListingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<SongFetchBloc>();
    final ctrl2 = Get.find<SongPlayBloc>();
    return BaseSongListingView(
      title: "Recent Songs",
      builder: (c) {
        var songs = ctrl.recentSongs.value;
        return [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (c, i) {
                  final song = songs[i];
                  return Padding(
                    padding: i == (songs.length - 1)
                        ? EdgeInsets.zero
                        : const EdgeInsets.only(bottom: 10.0),
                    child: SongWidget(
                      song: song,
                      onTap: () {
                        ctrl2
                            .setPlaylist(songs, PlaylistMode.recent)
                            .then((value) => ctrl2.playSong(song));
                      },
                    ),
                  );
                },
                childCount: songs.length,
              ),
            ),
          ),
        ];
      },
    );
  }
}
