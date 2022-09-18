import 'package:get/get.dart';

class LoadingBloc extends GetxController {
  late Rx<bool> isLoading;

  LoadingBloc() {
    isLoading = false.obs;
  }

  void loaded(void Function() callback) {
    isLoading(true);
    callback();
    isLoading(false);
  }
}
