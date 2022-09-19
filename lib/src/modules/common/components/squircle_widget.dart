import 'package:flutter/material.dart';

import 'package:music_player/src/modules/common/components/squircle_border.dart';

import '../../../res/colors.dart';

class SquircleWidget extends StatelessWidget {
  final double size;
  final Widget child;
  const SquircleWidget({
    Key? key,
    required this.size,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Material(
        shape: const SquircleBorder(
          side: BorderSide(
            color: scaffoldColor,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: child,
      ),
    );
  }
}
