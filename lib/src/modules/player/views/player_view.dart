import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:music_player/src/extensions/str_extension.dart';
import 'package:music_player/src/modules/common/components/tap_effect.dart';
import 'package:music_player/src/modules/player/blocs/player_control_bloc.dart';
import 'package:music_player/src/modules/player/components/fancy_seek_indicator.dart';
import 'package:music_player/src/modules/player/components/player_control_bar.dart';
import 'package:music_player/src/modules/player/models/progress_bar_model.dart';
import 'package:music_player/src/modules/songs/blocs/song_play_bloc.dart';
import 'package:music_player/src/modules/songs/components/song_image.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';
import 'package:music_player/src/res/styles.dart';

import '../components/back_and_forth_animation_wrapper.dart';
import '../components/padded_icon_button.dart';
import '../components/title_subtitle_widget.dart';

class PlayerView extends StatefulWidget {
  final void Function() onAllSongsClick;
  const PlayerView({
    Key? key,
    required this.onAllSongsClick,
  }) : super(key: key);
  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  late SongPlayBloc songPlayBloc;
  late PlayerControlBloc playerControlBloc;

  @override
  void initState() {
    super.initState();
    playerControlBloc = Get.find<PlayerControlBloc>();
    songPlayBloc = Get.find<SongPlayBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                          SongModel? song = playerControlBloc.currentSong.value;
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
                              TitleSubtitleWidget(
                                title: song?.title,
                                subtitle: song?.album,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    Obx(() {
                      ProgressBarState dat = playerControlBloc.duration.value;
                      double percentage = 0.0;
                      if (dat.total != Duration.zero) {
                        percentage =
                            (dat.current.inSeconds / dat.total.inSeconds);
                      }
                      return Column(
                        children: [
                          FancySeekIndicator(
                            percentage: percentage,
                            onChange: playerControlBloc.seek,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                dat.current.inMilliseconds
                                    .toString()
                                    .durationIndicatorFormat,
                                style: subtitleStyle,
                              ),
                              const Spacer(),
                              Text(
                                dat.total.inMilliseconds
                                    .toString()
                                    .durationIndicatorFormat,
                                style: subtitleStyle,
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                    const SizedBox(height: 30),
                    PlayerControlBar(),
                    Row(
                      children: [
                        const Spacer(),
                        TapEffect(
                          onClick: widget.onAllSongsClick,
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
              Align(
                alignment: Alignment.topRight,
                child: BackAndForthAnimationWrapper(
                  child: PaddedIconButton(
                    icon: FontAwesomeIcons.chevronRight,
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void showSongs() =>
  //     NavigationService(context).pushSlideLeft(SongsListingView());
}
