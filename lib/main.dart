import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_player/src/modules/common/views/curved_scaffold.dart';
import 'package:music_player/src/modules/player/blocs/player_control_bloc.dart';
import 'package:music_player/src/modules/player/components/fancy_seek_indicator.dart';
import 'package:music_player/src/modules/songs/components/floating_song_indicator.dart';
import 'package:music_player/src/res/colors.dart';
import 'package:music_player/src/services/image/image_service.dart';
import 'package:music_player/src/services/sound/sound_handler.dart';

import 'src/modules/player/views/default_home_view.dart';

late SoundHandler audioHandler;
late File noImgFile;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  audioHandler = await AudioService.init(
    builder: () => SoundHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
      androidNotificationChannelName: 'Sdev Music',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
      androidNotificationIcon: 'drawable/indicator',
      notificationColor: scaffoldColor,
    ),
  );
  noImgFile = await ImageService.getImageFileFromAssets('notification_img.jpg');
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
  ]);
  runApp(MusicPlayer());
}

class MusicPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(elevation: 0, color: Colors.transparent),
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: CurvedScaffold(
        child: DefaultHomeView(),
        // child: Dummy(),
      ),
    );
  }
}

class Dummy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ImageService.checkExists(
      'content://media/external/audio/media/1594/albumart',
    ).then((value) {
      print('--- Exists');
      print(value);
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FancySeekIndicator(
              percentage: 0.5,
              onChange: (da) {},
            ),
          ),
        ],
      ),
    );
    final bloc = Get.put(PlayerControlBloc());
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(child: FloatingSongIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
