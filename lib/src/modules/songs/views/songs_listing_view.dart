import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/src/modules/common/views/body_with_indicator.dart';
import 'package:music_player/src/modules/songs/blocs/scroll_bloc.dart';
import 'package:music_player/src/modules/songs/blocs/song_fetch_bloc.dart';
import 'package:music_player/src/modules/songs/components/round_btn.dart';

import '../components/labeled_song_listing_widget.dart';

class SongsListingView extends StatefulWidget {
  @override
  State<SongsListingView> createState() => _SongsListingViewState();
}

class _SongsListingViewState extends State<SongsListingView>
    with AutomaticKeepAliveClientMixin<SongsListingView> {
  late SongScrollBloc bloc;
  late ScrollController controller;

  late Rx<bool> backToTop;

  @override
  void initState() {
    super.initState();
    bloc = Get.put(SongScrollBloc());
    backToTop = false.obs;
    controller = ScrollController()
      ..addListener(() {
        bool shouldGoBack = controller.offset > 100;
        if (shouldGoBack != backToTop.value) {
          backToTop(shouldGoBack);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var ctrl = Get.find<SongFetchBloc>();
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => backToTop.value
                ? TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 200),
                    builder: (c, t, ch) => Opacity(
                      opacity: t,
                      child: RoundIconBtn(
                        icon: FeatherIcons.arrowUp,
                        onTap: () {
                          controller.animateTo(
                            0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.bounceInOut,
                          );
                        },
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
          const SizedBox(height: 10),
          RoundIconBtn(icon: FeatherIcons.search, onTap: () {}),
        ],
      ),
      body: SafeArea(
        child: BodyWithIndicator(
          child: Scrollbar(
            isAlwaysShown: true,
            radius: const Radius.circular(9999),
            thickness: 10,
            controller: bloc.controller,
            hoverThickness: 20,
            child: Obx(
              () => LabeledSongListingWidget(songs: ctrl.songs.value),
            ),
            // child: NestedScrollView(
            //   controller: controller,
            //   headerSliverBuilder: (c, box) => [
            //     SliverOverlapAbsorber(
            //       handle: NestedScrollView.sliverOverlapAbsorberHandleFor(c),
            //       sliver: SliverToBoxAdapter(
            //         child: SizedBox(
            //           height: width,
            //           child: Stack(
            //             children: [
            //               Container(
            //                 decoration: const BoxDecoration(
            //                   image: DecorationImage(
            //                     image: AssetImage(Assets.no_image),
            //                     fit: BoxFit.cover,
            //                   ),
            //                 ),
            //               ),
            //               Container(
            //                 decoration: const BoxDecoration(
            //                   gradient: LinearGradient(
            //                     begin: Alignment.bottomCenter,
            //                     end: Alignment.topCenter,
            //                     colors: [Color(0xffFAFAFA), Colors.transparent],
            //                   ),
            //                 ),
            //               ),
            //               Positioned(
            //                 bottom: 20,
            //                 left: 10,
            //                 child: Padding(
            //                   padding: const EdgeInsets.all(16.0),
            //                   child: Text(
            //                     "All Songs",
            //                     style: headerStyle.copyWith(
            //                       shadows: [
            //                         const Shadow(
            //                           color: Colors.white,
            //                           blurRadius: 15,
            //                           offset: Offset(1, 2),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            //   // body: StickyHeader(
            //   //   header: const Text('Hello'),
            //   //   content: Container(
            //   //     height: 100,
            //   //   ),
            //   // ),
            //   body: Obx(
            //     () => LabeledSongListingWidget(songs: ctrl.songs.value),
            //     // () => SongsListingWidget(songs: ctrl.songs.value),
            //     // () => StickyHeader(
            //     //   header: const Text('Hello'),
            //     //   content: Container(
            //     //     height: 100,
            //     //   ),
            //     // ),
            //   ),
            // ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
