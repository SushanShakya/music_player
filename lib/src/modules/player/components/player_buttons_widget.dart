import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/src/modules/player/components/next_btn.dart';
import 'package:music_player/src/modules/player/components/power_btn.dart';

import '../blocs/home_bloc.dart';

class PlayerButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Get.find<HomeBloc>();
    return LayoutBuilder(
      builder: (c, box) {
        const spacing = 10.0;
        final width = (box.maxWidth - (2 * spacing)) / 3;
        return Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PreviousBtn(
                size: width / 0.8,
                isActive: bloc.isPlaying.value,
                onTap: () {},
              ),
              const SizedBox(width: spacing),
              PowerBtn(
                onTap: bloc.togglePlaying,
                isActive: bloc.isPlaying.value,
                size: width,
              ),
              const SizedBox(width: spacing),
              NextBtn(
                onTap: () {},
                isActive: bloc.isPlaying.value,
                size: width / 0.8,
              ),
            ],
          ),
        );
      },
    );
  }
}
