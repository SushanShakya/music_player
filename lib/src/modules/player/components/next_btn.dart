import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music_player/src/modules/common/components/tap_effect.dart';
import 'package:music_player/src/modules/player/components/rounded_triangle.dart';
import 'package:music_player/src/res/colors.dart';

class NextBtn extends StatelessWidget {
  final double size;
  final void Function() onTap;
  final bool isActive;
  const NextBtn({
    Key? key,
    this.size = 50,
    required this.onTap,
    this.isActive = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RoundedTriangleWidget(
      size: size,
      color: isActive ? btnColor1 : Colors.grey,
      child: TapEffect(
        onClick: onTap,
        child: Center(
          child: RoundedTriangleWidget(
            size: size * 0.7,
            color: scaffoldColor,
          ),
        ),
      ),
    );
  }
}

class PreviousBtn extends StatelessWidget {
  final double size;
  final void Function() onTap;
  final bool isActive;
  const PreviousBtn({
    Key? key,
    this.size = 50,
    required this.onTap,
    this.isActive = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi,
      child: NextBtn(
        isActive: isActive,
        size: size,
        onTap: onTap,
      ),
    );
  }
}
