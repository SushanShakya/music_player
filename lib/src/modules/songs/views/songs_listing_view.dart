import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:music_player/src/modules/player/enums/playlist_mode.dart';
import 'package:music_player/src/modules/songs/blocs/song_fetch_bloc.dart';
import 'package:music_player/src/modules/songs/blocs/song_play_bloc.dart';
import 'package:music_player/src/modules/songs/views/base_song_listing_view.dart';

import '../../../res/colors.dart';
import '../../../res/styles.dart';
import '../../common/components/tap_effect.dart';
import '../components/song_widget.dart';

// class SongsListingView extends StatefulWidget {
//   @override
//   State<SongsListingView> createState() => _SongsListingViewState();
// }

// class _SongsListingViewState extends State<SongsListingView>
//     with AutomaticKeepAliveClientMixin<SongsListingView> {
//   late SongScrollBloc bloc;
//   late ScrollController controller;

//   late Rx<bool> backToTop;

//   @override
//   void initState() {
//     super.initState();
//     bloc = Get.put(SongScrollBloc());
//     backToTop = false.obs;
//     controller = ScrollController()
//       ..addListener(() {
//         bool shouldGoBack = controller.offset > 100;
//         if (shouldGoBack != backToTop.value) {
//           backToTop(shouldGoBack);
//         }
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     var ctrl = Get.find<SongFetchBloc>();
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       floatingActionButton: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Obx(
//             () => backToTop.value
//                 ? TweenAnimationBuilder<double>(
//                     tween: Tween<double>(begin: 0, end: 1),
//                     duration: const Duration(milliseconds: 200),
//                     builder: (c, t, ch) => Opacity(
//                       opacity: t,
//                       child: RoundIconBtn(
//                         icon: FeatherIcons.arrowUp,
//                         onTap: () {
//                           controller.animateTo(
//                             0,
//                             duration: const Duration(milliseconds: 200),
//                             curve: Curves.bounceInOut,
//                           );
//                         },
//                       ),
//                     ),
//                   )
//                 : const SizedBox(),
//           ),
//           const SizedBox(height: 10),
//           RoundIconBtn(icon: FeatherIcons.search, onTap: () {}),
//         ],
//       ),
//       body: SafeArea(
//         child: BodyWithIndicator(
//           child: Scrollbar(
//             isAlwaysShown: true,
//             radius: const Radius.circular(9999),
//             thickness: 10,
//             controller: bloc.controller,
//             hoverThickness: 20,
//             child: Obx(
//               () => LabeledSongListingWidget(songs: ctrl.songs.value),
//             ),
//             // child: NestedScrollView(
//             //   controller: controller,
//             //   headerSliverBuilder: (c, box) => [
//             //     SliverOverlapAbsorber(
//             //       handle: NestedScrollView.sliverOverlapAbsorberHandleFor(c),
//             //       sliver: SliverToBoxAdapter(
//             //         child: SizedBox(
//             //           height: width,
//             //           child: Stack(
//             //             children: [
//             //               Container(
//             //                 decoration: const BoxDecoration(
//             //                   image: DecorationImage(
//             //                     image: AssetImage(Assets.no_image),
//             //                     fit: BoxFit.cover,
//             //                   ),
//             //                 ),
//             //               ),
//             //               Container(
//             //                 decoration: const BoxDecoration(
//             //                   gradient: LinearGradient(
//             //                     begin: Alignment.bottomCenter,
//             //                     end: Alignment.topCenter,
//             //                     colors: [Color(0xffFAFAFA), Colors.transparent],
//             //                   ),
//             //                 ),
//             //               ),
//             //               Positioned(
//             //                 bottom: 20,
//             //                 left: 10,
//             //                 child: Padding(
//             //                   padding: const EdgeInsets.all(16.0),
//             //                   child: Text(
//             //                     "All Songs",
//             //                     style: headerStyle.copyWith(
//             //                       shadows: [
//             //                         const Shadow(
//             //                           color: Colors.white,
//             //                           blurRadius: 15,
//             //                           offset: Offset(1, 2),
//             //                         ),
//             //                       ],
//             //                     ),
//             //                   ),
//             //                 ),
//             //               ),
//             //             ],
//             //           ),
//             //         ),
//             //       ),
//             //     ),
//             //   ],
//             //   // body: StickyHeader(
//             //   //   header: const Text('Hello'),
//             //   //   content: Container(
//             //   //     height: 100,
//             //   //   ),
//             //   // ),
//             //   body: Obx(
//             //     () => LabeledSongListingWidget(songs: ctrl.songs.value),
//             //     // () => SongsListingWidget(songs: ctrl.songs.value),
//             //     // () => StickyHeader(
//             //     //   header: const Text('Hello'),
//             //     //   content: Container(
//             //     //     height: 100,
//             //     //   ),
//             //     // ),
//             //   ),
//             // ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;
// }
class SongsListingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<SongFetchBloc>();
    final ctrl2 = Get.find<SongPlayBloc>();
    return BaseSongListingView(
      builder: (c) {
        var labeledSongs = ctrl.labelledsongs.value;

        return List.generate(labeledSongs.length, (i) {
          var labeledSong = labeledSongs[i];
          var songs = labeledSong.songs;
          return SliverStickyHeader(
            header: _HeaderWidget(
              title: labeledSong.title,
              onTap: () {},
            ),
            sliver: SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (c, j) {
                    var song = songs[j];
                    return Padding(
                      padding: j == (songs.length - 1)
                          ? EdgeInsets.zero
                          : const EdgeInsets.only(bottom: 10.0),
                      child: SongWidget(
                        song: song,
                        onTap: () {
                          ctrl2
                              .setPlaylist(
                                  labeledSongs.fold(
                                    [],
                                    (a, b) => [...a, ...b.songs],
                                  ),
                                  PlaylistMode.all)
                              .then((value) => ctrl2.playSong(song));
                        },
                      ),
                    );
                  },
                  childCount: songs.length,
                ),
              ),
            ),
          );
        });
      },
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  final String title;
  final void Function() onTap;
  const _HeaderWidget({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TapEffect(
      onClick: onTap,
      child: Container(
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
              title,
              style: titleStyle,
            ),
          ],
        ),
      ),
    );
  }
}
