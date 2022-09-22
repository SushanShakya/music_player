import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SongScrollBloc extends GetxController {
  late ScrollController controller;

  SongScrollBloc() {
    controller = ScrollController();
  }
}
