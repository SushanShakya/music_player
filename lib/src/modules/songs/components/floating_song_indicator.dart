import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_player/constants/assets.dart';
import 'package:music_player/src/modules/common/components/squircle_widget.dart';
import 'package:music_player/src/modules/home/components/padded_icon_button.dart';
import 'package:music_player/src/modules/home/components/waveform_widget.dart';
import 'package:music_player/src/res/colors.dart';
import 'package:music_player/src/res/dimens.dart';
import 'package:music_player/src/res/styles.dart';

class FloatingSongIndicator extends StatefulWidget {
  static const minHeight = 48.0;
  static const tag = 'song_indicator.img';
  @override
  State<FloatingSongIndicator> createState() => _FloatingSongIndicatorState();
}

class _FloatingSongIndicatorState extends State<FloatingSongIndicator>
    with TickerProviderStateMixin {
  late AnimationController controller;
  static const expandedRadius = appBorderRadius * 0.8;
  static const contractedRadius = 999.0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }

  void toggle() {
    if (controller.isCompleted) {
      controller.reverse();
    } else if (controller.isDismissed) {
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final a = w * 0.6;
    final b = w;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, c) {
        bool done = controller.isCompleted;
        final t = controller.value;
        return GestureDetector(
          onTap: toggle,
          onVerticalDragStart: (dat) {
            print('---- Drag Start');
            print('-- GLOBAL Position ');
            print(dat.globalPosition);
            print('-- LOCAL Position ');
            print(dat.localPosition);
          },
          onVerticalDragUpdate: (dat) {
            print('------------Drag Update');
            print(dat.localPosition.direction);
            if (dat.localPosition.dy > FloatingSongIndicator.minHeight) {
              controller.fling();
            }
          },
          onVerticalDragEnd: (dat) {
            if (dat.primaryVelocity != null) {
              if (dat.primaryVelocity! > 0.0) {
                controller.forward();
              }
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: scaffoldColor,
              borderRadius: BorderRadius.circular(
                controller.isAnimating
                    ? expandedRadius
                    : done
                        ? expandedRadius
                        : contractedRadius,
              ),
            ),
            constraints: const BoxConstraints(
              minHeight: FloatingSongIndicator.minHeight,
            ),
            height: done ? null : 150 * t,
            width: (a * (1 - t)) + (b * t),
            margin: const EdgeInsets.all(10),
            child: controller.isAnimating
                ? Container()
                : done
                    ? _ExpandedBody()
                    : _ContractedBody(),
          ),
        );
      },
    );
  }
}

class _ContractedBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const spacing = 8.0;
    return Padding(
      padding: const EdgeInsets.all(spacing),
      child: Row(
        children: [
          Hero(
            tag: FloatingSongIndicator.tag,
            child: Container(
              height: FloatingSongIndicator.minHeight - spacing,
              width: FloatingSongIndicator.minHeight - spacing,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(Assets.no_image),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const Spacer(),
          const WaveformWidget(
            maxHeight: FloatingSongIndicator.minHeight * 0.7,
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}

class _ExpandedBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Hero(
                tag: FloatingSongIndicator.tag,
                child: SquircleWidget(
                  size: 70,
                  child: Image.asset(Assets.no_image),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Om Shanti Om',
                      maxLines: 1,
                      style: smalltitleStyle.copyWith(color: Colors.white),
                    ),
                    Text(
                      'Deja Vu',
                      maxLines: 1,
                      style: subtitleStyle.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PaddedIconButton(
                icon: FontAwesomeIcons.backward,
                color: Colors.white,
                size: 30,
                onTap: () {},
              ),
              const SizedBox(width: 10),
              PaddedIconButton(
                icon: FontAwesomeIcons.pause,
                color: Colors.white,
                size: 40,
                onTap: () {},
              ),
              const SizedBox(width: 10),
              PaddedIconButton(
                icon: FontAwesomeIcons.forward,
                color: Colors.white,
                size: 30,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
