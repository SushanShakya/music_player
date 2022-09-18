import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_player/src/modules/songs/views/songs_listing_view.dart';
import 'package:music_player/src/services/sound/sound_handler.dart';

late SoundHandler audioHandler;

void main() async {
  audioHandler = await AudioService.init(
    builder: () => SoundHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
      androidNotificationChannelName: 'Sdev Music',
      androidNotificationOngoing: true,
    ),
  );
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
      home: SongsListingView(),
    );
  }
}
