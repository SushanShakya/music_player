import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:music_player/src/modules/songs/components/floating_song_indicator.dart';
import 'package:music_player/src/res/colors.dart';
import 'package:music_player/src/res/styles.dart';

import '../../player/enums/repeat_mode.dart';

class AnimatedNotification extends StatefulWidget {
  final Widget child;
  const AnimatedNotification({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AnimatedNotification> createState() => _AnimatedNotificationState();
}

class _AnimatedNotificationState extends State<AnimatedNotification>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..forward();
  }

  Future<void> forward() => controller.forward();

  Future<void> reverse() => controller.reverse();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Material(
      child: AnimatedBuilder(
        animation: controller,
        builder: (c, ch) {
          final t = controller.value;
          const a = FloatingSongIndicator.minHeight;
          final b = width * 0.6;
          return Container(
            height: FloatingSongIndicator.minHeight,
            width: (a * (1 - t)) + (b * t),
            decoration: BoxDecoration(
              color: scaffoldColor,
              borderRadius: BorderRadius.circular(999),
            ),
            child: (t == 1) ? widget.child : null,
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
  final key = GlobalKey<_AnimatedNotificationState>();
  OverlayState? overlayState = Overlay.of(context);
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (c) {
      return Positioned(
        top: 16,
        left: 0,
        right: 0,
        child: Center(
          child: AnimatedNotification(
            key: key,
            child: child,
          ),
        ),
      );
    },
  );
  overlayState?.insert(overlayEntry);
  overlayState?.setState(() {});
  await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
  await key.currentState!.reverse();
  overlayEntry.remove();
}

Future<void> showIconedNotification({
  required BuildContext context,
  required IconData icon,
  required String text,
}) =>
    showAnimatedNotification(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: subtitleStyle.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );

Future<void> showShuffleNotification({
  required BuildContext context,
  required bool shuffle,
}) =>
    showIconedNotification(
      context: context,
      icon: shuffle ? FontAwesomeIcons.shuffle : FontAwesomeIcons.arrowDown19,
      text: shuffle ? "Shuffle On" : "Shuffle Off",
    );

Future<void> showRepeatNotification({
  required BuildContext context,
  required RepeatMode mode,
}) =>
    showIconedNotification(
      context: context,
      icon: mode.icon,
      text: mode.text,
    );
