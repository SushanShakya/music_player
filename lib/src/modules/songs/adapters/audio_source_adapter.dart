import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioSourceAdapter {
  late UriAudioSource data;
  AudioSourceAdapter._();

  AudioSourceAdapter.fromMediaItem(MediaItem item) {
    data = AudioSource.uri(
      Uri.parse(item.extras!['uri']),
      tag: item,
    );
  }
}
