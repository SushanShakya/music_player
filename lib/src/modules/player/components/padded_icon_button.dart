import 'package:flutter/material.dart';
import 'package:music_player/src/modules/common/components/tap_effect.dart';
import 'package:music_player/src/res/colors.dart';

class PaddedIconButton extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;
  final double? size;
  final Color? color;
  const PaddedIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.color,
    this.size,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TapEffect(
      onClick: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Icon(
          icon,
          size: size,
          color: color ?? scaffoldColor,
        ),
      ),
    );
  }
}
