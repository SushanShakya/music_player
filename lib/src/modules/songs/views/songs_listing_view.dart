import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/constants/assets.dart';
import 'package:music_player/src/modules/songs/blocs/song_fetch_bloc.dart';
import 'package:music_player/src/res/styles.dart';

import '../components/labeled_song_listing_widget.dart';

class SongsListingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var ctrl = Get.find<SongFetchBloc>();
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragUpdate: (det) {
            print(det.primaryDelta);
            if ((det.primaryDelta ?? 0) > 5) {
              Navigator.of(context).pop();
            }
          },
          child: NestedScrollView(
            headerSliverBuilder: (c, box) => [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(c),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: width,
                    child: Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Assets.no_image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Color(0xffFAFAFA), Colors.transparent],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "All Songs",
                              style: headerStyle.copyWith(
                                shadows: [
                                  const Shadow(
                                    color: Colors.white,
                                    blurRadius: 15,
                                    offset: Offset(1, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            // body: StickyHeader(
            //   header: const Text('Hello'),
            //   content: Container(
            //     height: 100,
            //   ),
            // ),
            body: Obx(
              () => LabeledSongListingWidget(songs: ctrl.songs.value),
              // () => SongsListingWidget(songs: ctrl.songs.value),
              // () => StickyHeader(
              //   header: const Text('Hello'),
              //   content: Container(
              //     height: 100,
              //   ),
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
