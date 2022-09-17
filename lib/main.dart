import 'package:flutter/material.dart';

import 'src/modules/home/views/speaker_home_view.dart';

void main() => runApp(MusicPlayer());

class MusicPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(elevation: 0),
      ),
      home: SpeakerHomeView(),
    );
  }
}
