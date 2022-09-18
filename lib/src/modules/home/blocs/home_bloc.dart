import 'package:get/get.dart';

class HomeBloc extends GetxController {
  late Rx<bool> isPlaying;

  HomeBloc() {
    isPlaying = false.obs;
  }

  void togglePlaying() {
    isPlaying(!isPlaying.value);
  }
}
