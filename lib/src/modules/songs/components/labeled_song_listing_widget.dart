// import 'package:flutter/material.dart';
// import 'package:flutter_sticky_header/flutter_sticky_header.dart';
// import 'package:music_player/src/modules/common/components/tap_effect.dart';
// import 'package:music_player/src/modules/songs/components/song_widget.dart';
// import 'package:music_player/src/modules/songs/models/header_key.dart';

// import 'package:music_player/src/modules/songs/models/song_model.dart';
// import 'package:music_player/src/res/colors.dart';
// import 'package:music_player/src/res/styles.dart';

// import '../models/labelled_songs.dart';

// class LabeledSongListingWidget extends StatefulWidget {
//   final List<SongModel> songs;
//   const LabeledSongListingWidget({
//     Key? key,
//     required this.songs,
//   }) : super(key: key);

//   @override
//   State<LabeledSongListingWidget> createState() =>
//       _LabeledSongListingWidgetState();
// }

// class _LabeledSongListingWidgetState extends State<LabeledSongListingWidget> {
//   static List<String> titles = "#ABCDEFGHIJKLMNOPQRSTUVWXYZ".split('').toList();

//   late List<LabelledSongs> labeledSongs;
//   late List<HeaderKey> keys;

//   List<LabelledSongs> _labelSongs(List<SongModel> songs) {
//     var data = <LabelledSongs>[];
//     for (var title in titles) {
//       late List<SongModel> x;
//       if (title == '#') {
//         x = songs.where((e) {
//           if (e.title.isEmpty) return true;
//           return !titles.skip(1).contains(e.title[0].toUpperCase());
//         }).toList();
//       } else {
//         x = songs
//             .where((e) => e.title.toUpperCase().startsWith(title))
//             .toList();
//       }
//       if (x.isEmpty) continue;

//       data.add(LabelledSongs(title: title, songs: x));
//     }
//     // List<SongModel> y = data.fold([], (a, b) => [...a, ...(b.songs)]);
//     // audioHandler.setPlaylist(y);
//     return data;
//   }

//   @override
//   void initState() {
//     super.initState();
//     init();
//   }

//   void init() {
//     labeledSongs = _labelSongs(widget.songs);
//     keys = List.generate(labeledSongs.length,
//         (i) => HeaderKey(key: GlobalKey(), tag: labeledSongs[i].title));
//   }

//   @override
//   void didUpdateWidget(covariant LabeledSongListingWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.songs.length != oldWidget.songs.length) {
//       init();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SliverList(
//       delegate: SliverChildBuilderDelegate((c, i) {
//         var labeledSong = labeledSongs[i];
//         var songs = labeledSong.songs;
//         return SliverStickyHeader(
//           key: keys[i].key,
//           header: _HeaderWidget(
//             title: labeledSong.title,
//             onTap: () {},
//           ),
//           sliver: SliverPadding(
//             padding: const EdgeInsets.all(16),
//             sliver: SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (c, j) {
//                   var song = songs[j];
//                   return Padding(
//                     padding: j == (songs.length - 1)
//                         ? EdgeInsets.zero
//                         : const EdgeInsets.only(bottom: 10.0),
//                     child: SongWidget(song: song),
//                   );
//                 },
//                 childCount: songs.length,
//               ),
//             ),
//           ),
//         );
//       }, childCount: labeledSongs.length),
//     );
//   }
// }

// class _HeaderWidget extends StatelessWidget {
//   final String title;
//   final void Function() onTap;
//   const _HeaderWidget({
//     Key? key,
//     required this.title,
//     required this.onTap,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return TapEffect(
//       onClick: onTap,
//       child: Container(
//         height: 48,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: bgColor,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 5,
//             ),
//           ],
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: titleStyle,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
