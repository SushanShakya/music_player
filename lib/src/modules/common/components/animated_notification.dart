import 'package:flutter/material.dart';

import 'package:music_player/src/modules/songs/components/floating_song_indicator.dart';
import 'package:music_player/src/res/colors.dart';
import 'package:music_player/src/res/styles.dart';

import '../../player/enums/repeat_mode.dart';

class AnimatedNotification extends StatelessWidget {
  final Widget child;
  const AnimatedNotification({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Material(
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 200),
        builder: (c, t, ch) {
          const a = FloatingSongIndicator.minHeight;
          final b = width * 0.6;
          return Container(
            height: FloatingSongIndicator.minHeight,
            width: (a * (1 - t)) + (b * t),
            decoration: BoxDecoration(
              color: scaffoldColor,
              borderRadius: BorderRadius.circular(999),
            ),
            child: (t == 1) ? child : null,
          );
        },
      ),
    );
  }
}

Future<void> showAnimatedNotification({
  required BuildContext context,
  required Widget child,
}) async {
  OverlayState? overlayState = Overlay.of(context);
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (c) {
      return Positioned(
        top: 16,
        left: 0,
        right: 0,
        child: Center(
          child: AnimatedNotification(
            child: child,
          ),
        ),
      );
    },
  );
  overlayState?.insert(overlayEntry);
  overlayState?.setState(() {});
  await Future.delayed(const Duration(seconds: 2));
  overlayEntry.remove();
}

Future<void> showRepeatNotification({
  required BuildContext context,
  required RepeatMode mode,
}) =>
    showAnimatedNotification(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              mode.icon,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                mode.text,
                textAlign: TextAlign.center,
                style: subtitleStyle.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
