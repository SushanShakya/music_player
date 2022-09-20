import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:music_player/src/modules/home/blocs/player_control_bloc.dart';
import 'package:music_player/src/modules/home/components/padded_icon_button.dart';
import 'package:music_player/src/modules/home/components/play_pause_btn.dart';

class PlayerControlBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PlayerControlBloc>();
    return Row(
      children: [
        PaddedIconButton(
          icon: FontAwesomeIcons.repeat,
          size: 16,
          onTap: () {},
        ),
        const Spacer(),
        PaddedIconButton(
          icon: FontAwesomeIcons.backward,
          onTap: () {},
        ),
        const SizedBox(width: 15),
        Obx(
          () => PlayPauseBtn(
            isPlaying: ctrl.isPlaying.value,
            onTap: ctrl.togglePlaying,
          ),
        ),
        const SizedBox(width: 15),
        PaddedIconButton(
          icon: FontAwesomeIcons.forward,
          onTap: () {},
        ),
        const Spacer(),
        PaddedIconButton(
          icon: FontAwesomeIcons.shuffle,
          size: 16,
          onTap: () {},
        ),
      ],
    );
  }
}
