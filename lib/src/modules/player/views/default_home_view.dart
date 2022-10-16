import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_player/src/modules/player/blocs/player_control_bloc.dart';
import 'package:music_player/src/modules/player/views/player_view.dart';
import 'package:music_player/src/modules/songs/blocs/song_play_bloc.dart';
import 'package:music_player/src/modules/songs/views/recent_song_listing_view.dart';
import 'package:music_player/src/modules/songs/views/songs_listing_view.dart';
import 'package:music_player/src/services/navigation/navigation_service.dart';

import '../../songs/blocs/song_fetch_bloc.dart';

class DefaultHomeView extends StatefulWidget {
  @override
  State<DefaultHomeView> createState() => DefaultHomeViewState();
}

class DefaultHomeViewState extends State<DefaultHomeView> {
  late SongPlayBloc songPlayBloc;
  late PlayerControlBloc playerControlBloc;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    controller = PageController(initialPage: 1);
    Get.put(SongFetchBloc());
    playerControlBloc = Get.put(PlayerControlBloc());
    songPlayBloc = Get.put(SongPlayBloc());
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          clipBehavior: Clip.antiAlias,
          controller: controller,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            RecentSongListingView(),
            PlayerView(
              onAllSongsClick: () {
                controller.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
            ),
            SongsListingView(),
          ],
        ),
      ),
    );
  }

  void showSongs() =>
      NavigationService(context).pushSlideLeft(SongsListingView());
}
