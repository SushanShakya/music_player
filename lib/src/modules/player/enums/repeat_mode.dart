import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum RepeatMode { off, song, playlist }

extension RepeatModeUtil on RepeatMode {
  IconData get icon {
    switch (this) {
      case RepeatMode.off:
        return FeatherIcons.activity;
      case RepeatMode.song:
        return FontAwesomeIcons.infinity;
      case RepeatMode.playlist:
        return FontAwesomeIcons.repeat;
    }
  }

  String get text {
    switch (this) {
      case RepeatMode.off:
        return 'Repeat Off';
      case RepeatMode.song:
        return 'Repeat Current Song';
      case RepeatMode.playlist:
        return 'Repeat All';
    }
  }
}
