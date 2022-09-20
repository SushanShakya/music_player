import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/src/modules/songs/adapters/audio_source_adapter.dart';
import 'package:music_player/src/modules/songs/adapters/media_item_adapter.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';

class SoundHandler extends BaseAudioHandler with SeekHandler {
  late AudioPlayer _player;
  late StreamController<SongModel> currentSong;
  late StreamController<Duration> duration;

  late List<SongModel> playlist;
  final _playlist = ConcatenatingAudioSource(children: []);

  void _broadcastState(PlaybackEvent event) {
    final playing = _player.playing;
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        if (playing) MediaControl.pause else MediaControl.play,
        MediaControl.skipToNext,
        MediaControl.stop,
      ],
      systemActions: const {
        MediaAction.seek,
      },
      androidCompactActionIndices: const [0, 1, 2],
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

  Future<void> _loadEmptyPlaylist() async {
    try {
      await _player.setAudioSource(_playlist);
    } catch (e) {
      print("Error: $e");
    }
  }

  SoundHandler() {
    playlist = [];
    currentSong = StreamController.broadcast();
    duration = StreamController.broadcast();
    _player = AudioPlayer()..playbackEventStream.listen(_broadcastState);
    // ..durationStream.listen(_handleDurationChanges);
    _loadEmptyPlaylist();
  }

  // void _handleDurationChanges(Duration? d) {
  //   int? i = _player.currentIndex;
  //   List<MediaItem> q = queue.value;
  //   if (i == null || q.isEmpty) return;
  //   MediaItem newSong = q[i].copyWith(duration: d);
  //   q[i] = newSong;
  //   queue.add(q);
  //   mediaItem.add(newSong);
  // }

  Future<void> setSong(SongModel song) async {
    // mediaItem.add(MediaItemAdapter.fromSongModel(song).data);
    currentSong.sink.add(song);
    await _player.setAudioSource(ProgressiveAudioSource(Uri.parse(song.uri)));
  }

  Future<void> setPlaylist(List<SongModel> songs) async {
    _playlist.clear();
    await addQueueItems(
      songs.map((e) => MediaItemAdapter.fromSongModel(e).data).toList(),
    );
    setSong(songs.first);
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    _playlist.addAll(
      mediaItems.map((e) => AudioSourceAdapter.fromMediaItem(e).data).toList(),
    );
    final q = queue.value..addAll(mediaItems);
    queue.add(q);
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    _playlist.add(AudioSourceAdapter.fromMediaItem(mediaItem).data);
    final q = queue.value..add(mediaItem);
    queue.add(q);
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> seek(Duration position) => _player.seek(position);
}
