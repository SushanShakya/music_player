import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/blocs/player_control_bloc.dart';
import '../../songs/components/floating_song_indicator.dart';

class BodyWithIndicator extends StatelessWidget {
  final Widget child;
  const BodyWithIndicator({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PlayerControlBloc>();
    return Stack(
      children: [
        Positioned.fill(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: child,
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Obx(
              () => (ctrl.isPlaying.value)
                  ? FloatingSongIndicator()
                  : Container(),
            ),
          ),
        ),
      ],
    );
  }
}
