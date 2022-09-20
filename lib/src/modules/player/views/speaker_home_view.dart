import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/constants/assets.dart';
import 'package:music_player/src/modules/common/components/tap_effect.dart';
import 'package:music_player/src/modules/player/components/player_buttons_widget.dart';
import 'package:music_player/src/modules/player/components/volume_btn.dart';
import 'package:music_player/src/res/colors.dart';

import '../blocs/home_bloc.dart';

class SpeakerHomeView extends StatefulWidget {
  @override
  State<SpeakerHomeView> createState() => _SpeakerHomeViewState();
}

class _SpeakerHomeViewState extends State<SpeakerHomeView> {
  late HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = Get.put(HomeBloc());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: TapEffect(
                  onClick: () {},
                  child: Image.asset(Assets.speaker),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: PlayerButtonWidget(),
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (c, box) => VolumeBtn(
                        size: box.maxWidth - 20,
                        percentage: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
