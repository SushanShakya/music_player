import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:music_player/src/modules/common/components/glowing_btn.dart';
import 'package:music_player/src/modules/common/components/tap_effect.dart';

import '../../../res/colors.dart';

class PlayPauseBtn extends StatelessWidget {
  final void Function() onTap;
  final bool isPlaying;
  const PlayPauseBtn({
    Key? key,
    required this.onTap,
    this.isPlaying = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TapEffect(
      onClick: onTap,
      child: Container(
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: scaffoldColor,
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: isPlaying
                ? const Icon(
                    FontAwesomeIcons.pause,
                    color: Colors.white,
                  )
                : const Icon(
                    FontAwesomeIcons.play,
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
    return GlowingBtn(
      onTap: onTap,
      isActive: isPlaying,
      icon: isPlaying ? Icons.pause_outlined : Icons.play_arrow_rounded,
    );
  }
}
