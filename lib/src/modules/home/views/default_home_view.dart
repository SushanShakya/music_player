import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_player/src/modules/common/components/tap_effect.dart';
import 'package:music_player/src/modules/home/blocs/player_control_bloc.dart';
import 'package:music_player/src/modules/home/components/back_and_forth_animation_wrapper.dart';
import 'package:music_player/src/modules/home/components/fancy_seek_indicator.dart';
import 'package:music_player/src/modules/home/components/player_control_bar.dart';
import 'package:music_player/src/modules/songs/blocs/song_play_bloc.dart';
import 'package:music_player/src/modules/songs/components/song_image.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';
import 'package:music_player/src/modules/songs/views/songs_listing_view.dart';
import 'package:music_player/src/res/styles.dart';
import 'package:music_player/src/services/navigation/navigation_service.dart';

import '../../songs/blocs/song_fetch_bloc.dart';

class DefaultHomeView extends StatefulWidget {
  @override
  State<DefaultHomeView> createState() => _DefaultHomeViewState();
}

class _DefaultHomeViewState extends State<DefaultHomeView> {
  late SongPlayBloc songPlayBloc;
  late PlayerControlBloc playerControlBloc;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Get.put(SongFetchBloc());
    playerControlBloc = Get.put(PlayerControlBloc());
    songPlayBloc = Get.put(SongPlayBloc());
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragUpdate: (dat) {
            if ((dat.primaryDelta ?? 0) < -10) {
              showSongs();
            }
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Column(
                    children: [
                      Expanded(
                        child: Obx(
                          () {
                            SongModel? song =
                                playerControlBloc.currentSong.value;
                            return Column(
                              children: [
                                Expanded(
                                  child: LayoutBuilder(
                                    builder: (c, box) => Center(
                                      child: SongImage(
                                        size: box.maxWidth * 0.6,
                                        song: song,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  song?.title ?? "No Song Selected",
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: titleStyle,
                                ),
                                Text(
                                  song?.album ?? "-",
                                  style: subtitleStyle,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      const FancySeekIndicator(percentage: 0.5),
                      const SizedBox(height: 30),
                      PlayerControlBar(),
                      Row(
                        children: [
                          const Spacer(),
                          TapEffect(
                            onClick: showSongs,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('All Songs', style: subtitleStyle),
                                  const BackAndForthAnimationWrapper(
                                    child: Icon(Icons.chevron_right),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // PaddedIconButton(
                //   icon: FontAwesomeIcons.xmark,
                //   onTap: () {},
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSongs() {
    NavigationService(context).pushSlideLeft(SongsListingView());
  }
}
