import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/src/modules/player/adapters/just_audio_repeat_adapter.dart';
import 'package:music_player/src/modules/player/adapters/repeat_mode_adapter.dart';
import 'package:music_player/src/modules/songs/adapters/audio_source_adapter.dart';
import 'package:music_player/src/modules/songs/adapters/media_item_adapter.dart';
import 'package:music_player/src/modules/songs/adapters/song_model_adapter.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';

import '../../modules/player/enums/repeat_mode.dart';

class SoundHandler extends BaseAudioHandler with SeekHandler {
  late AudioPlayer _player;
  late StreamController<SongModel> currentSong;
  late StreamController<Duration> duration;
  late StreamController<RepeatMode> repeatMode;
  late StreamController<bool> shuffleMode;

  late RepeatMode mode;

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
      systemActions: MediaAction.values.toSet(),
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
      shuffleMode: AudioServiceShuffleModeUtil.fromBool(
        _player.shuffleModeEnabled,
      ),
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
    mode = RepeatMode.off;
    playlist = [];
    currentSong = StreamController.broadcast();
    duration = StreamController.broadcast();
    repeatMode = StreamController.broadcast();
    shuffleMode = StreamController.broadcast();
    _player = AudioPlayer()
      ..playbackEventStream.listen(_broadcastState)
      ..processingStateStream.listen((e) {
        if (e == ProcessingState.completed) skipToNext();
      })
      ..shuffleModeEnabledStream.listen(shuffleMode.sink.add)
      ..loopModeStream.listen((mode) {
        this.mode = RepeatModeAdapter.fromLoopMode(mode).data;
        repeatMode.sink.add(this.mode);
      })
      ..currentIndexStream.listen((i) {
        if (i == null) return;
        final playlist = queue.value;
        if (playlist.isEmpty) return;
        if (_player.shuffleModeEnabled) {
          i = _player.shuffleIndices![i];
        }
        addToMediaItem(playlist[i]);
      })
      ..sequenceStateStream.listen((SequenceState? state) {
        final seq = state?.effectiveSequence;
        if (seq == null || seq.isEmpty) return;
        final items = seq.map((e) => e.tag as MediaItem);
        queue.add(items.toList());
      });
    mediaItem.listen((item) {
      if (item == null) return;
      currentSong.sink.add(SongModelAdapter.fromMediaItem(item).data);
    });
    _loadEmptyPlaylist();
  }

  Future<void> addToMediaItem(MediaItem song) async {
    MediaItem cur = await MediaItemAdapter.createFromMediaItem(song);
    mediaItem.add(cur);
  }

  Future<void> playSong(SongModel song) async {}

  Future<void> setSong(SongModel song) async {
    List<MediaItem> songs = queue.value;
    int i = songs.indexWhere((e) => e.id == song.id);
    await addToMediaItem(songs[i]);
    _player.setAudioSource(_playlist, initialIndex: i);
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
  Future<void> stop() async {
    await _player.stop();
    return super.stop();
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToNext() async {
    super.skipToNext();
    LoopMode mode = _player.loopMode;
    if (mode == LoopMode.one) {
      await setRepeatMode(AudioServiceRepeatMode.none);
    }
    await _player.seekToNext();
    if (mode == LoopMode.one) {
      await setRepeatMode(AudioServiceRepeatMode.one);
    }
  }

  @override
  Future<void> skipToPrevious() async {
    super.skipToPrevious();
    LoopMode mode = _player.loopMode;
    if (mode == LoopMode.one) {
      await setRepeatMode(AudioServiceRepeatMode.none);
    }
    await _player.seekToPrevious();
    if (mode == LoopMode.one) {
      await setRepeatMode(AudioServiceRepeatMode.one);
    }
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) => _player
      .setLoopMode(JustAudioRepeatAdapter.fromAudioService(repeatMode).data);

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) =>
      _player.setShuffleModeEnabled(shuffleMode.boolean);
}

extension AudioServiceShuffleModeUtil on AudioServiceShuffleMode {
  bool get boolean {
    switch (this) {
      case AudioServiceShuffleMode.none:
        return false;
      default:
        return true;
    }
  }

  static AudioServiceShuffleMode fromBool(bool value) {
    if (!value) {
      return AudioServiceShuffleMode.none;
    } else {
      return AudioServiceShuffleMode.all;
    }
  }
}
