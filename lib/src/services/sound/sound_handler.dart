import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/src/modules/songs/adapters/media_item_adapter.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';

class SoundHandler extends BaseAudioHandler with SeekHandler {
  late AudioPlayer _player;

  void _broadcastState(PlaybackEvent event) {
    final playing = _player.playing;
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        if (playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
    ));
  }

  SoundHandler() {
    _player = AudioPlayer()..playbackEventStream.listen(_broadcastState);
  }

  Future<void> setSong(SongModel song) async {
    mediaItem.add(MediaItemAdapter.fromSongModel(song).data);
    await _player.setAudioSource(ProgressiveAudioSource(Uri.parse(song.uri)));
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();
}
