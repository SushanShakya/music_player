import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:music_player/src/modules/common/components/animated_notification.dart';
import 'package:music_player/src/modules/player/blocs/player_control_bloc.dart';
import 'package:music_player/src/modules/player/components/padded_icon_button.dart';
import 'package:music_player/src/modules/player/components/play_pause_btn.dart';
import 'package:music_player/src/modules/player/enums/repeat_mode.dart';

class PlayerControlBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PlayerControlBloc>();
    return Row(
      children: [
        Obx(
          () {
            final mode = ctrl.repeatModel.mode.value;
            return PaddedIconButton(
              icon: mode.icon,
              size: 16,
              onTap: () {
                showRepeatNotification(
                  context: context,
                  mode: ctrl.repeatModel.getNext(),
                );
                ctrl.repeat();
              },
            );
          },
        ),
        const Spacer(),
        PaddedIconButton(
          icon: FontAwesomeIcons.backward,
          onTap: ctrl.prev,
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
          onTap: ctrl.next,
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
