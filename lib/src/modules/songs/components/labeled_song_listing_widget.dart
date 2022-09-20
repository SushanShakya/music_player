import 'package:flutter/material.dart';
import 'package:music_player/src/res/colors.dart';
import 'package:music_player/src/res/styles.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'package:music_player/src/modules/songs/blocs/small_song_listing_widget.dart';
import 'package:music_player/src/modules/songs/models/song_model.dart';

import '../models/labelled_songs.dart';

class LabeledSongListingWidget extends StatefulWidget {
  final List<SongModel> songs;
  const LabeledSongListingWidget({
    Key? key,
    required this.songs,
  }) : super(key: key);

  @override
  State<LabeledSongListingWidget> createState() =>
      _LabeledSongListingWidgetState();
}

class _LabeledSongListingWidgetState extends State<LabeledSongListingWidget> {
  static List<String> titles = "#ABCDEFGHIJKLMNOPQRSTUVWXYZ".split('').toList();

  late List<LabelledSongs> labeledSongs;

  List<LabelledSongs> _labelSongs(List<SongModel> songs) {
    var data = <LabelledSongs>[];
    for (var title in titles) {
      late List<SongModel> x;
      if (title == '#') {
        x = songs.where((e) {
          if (e.title.isEmpty) return true;
          return !titles.skip(1).contains(e.title[0].toUpperCase());
        }).toList();
      } else {
        x = songs
            .where((e) => e.title.toUpperCase().startsWith(title))
            .toList();
      }
      if (x.isEmpty) continue;
      data.add(LabelledSongs(title: title, songs: x));
    }
    return data;
  }

  @override
  void initState() {
    super.initState();
    labeledSongs = _labelSongs(widget.songs);
  }

  @override
  void didUpdateWidget(covariant LabeledSongListingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.songs.length != oldWidget.songs.length) {
      labeledSongs = _labelSongs(widget.songs);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (c, i) {
              var labeledSong = labeledSongs[i];
              // return SmallSongListingWidget(songs: labeledSong.songs);
              return StickyHeader(
                header: Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: bgColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        labeledSong.title,
                        style: titleStyle,
                      ),
                    ],
                  ),
                ),
                content: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: SmallSongListingWidget(songs: labeledSong.songs),
                ),
              );
            },
            childCount: labeledSongs.length,
          ),
        ),
      ],
    );
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: labeledSongs.length,
      separatorBuilder: (c, i) => const SizedBox(height: 10),
      itemBuilder: (c, i) {
        var labeledSong = labeledSongs[i];
        // return SmallSongListingWidget(songs: labeledSong.songs);
        return StickyHeader(
          header: Container(
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              color: bgColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  labeledSong.title,
                  style: titleStyle,
                ),
              ],
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SmallSongListingWidget(songs: labeledSong.songs),
          ),
        );
      },
    );
  }
}
