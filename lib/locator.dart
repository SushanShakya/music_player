import 'package:audio_query/audio_query.dart';
import 'package:get_it/get_it.dart';

GetIt g = GetIt.instance;

void setupLocator() {
  g.registerLazySingleton(() => FlutterAudioQuery());
}
