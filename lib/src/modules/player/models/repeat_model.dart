import 'package:get/get.dart';
import 'package:music_player/src/modules/player/enums/repeat_mode.dart';

class RepeatModel {
  late Rx<RepeatMode> mode;

  RepeatModel() {
    mode = RepeatMode.off.obs;
  }

  RepeatMode getNext() {
    int i = mode.value.index;
    int next = (i + 1) % RepeatMode.values.length;
    return RepeatMode.values[next];
  }

  void update() {
    mode(getNext());
  }
}
