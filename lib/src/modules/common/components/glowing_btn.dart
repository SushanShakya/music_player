import 'package:flutter/material.dart';
import 'package:music_player/src/modules/common/components/tap_effect.dart';

import '../../../res/colors.dart';

class GlowingBtn extends StatelessWidget {
  final double size;
  final void Function() onTap;
  final Color color;
  final Color inactiveColor;
  final bool isActive;
  final IconData icon;
  const GlowingBtn({
    Key? key,
    this.size = 50,
    required this.onTap,
    this.color = btnColor1,
    this.inactiveColor = Colors.grey,
    required this.icon,
    this.isActive = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final activeColor = isActive ? color : inactiveColor;
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 4,
          )
        ],
        color: activeColor,
      ),
      child: TapEffect(
        onClick: onTap,
        child: Center(
          child: Container(
            height: size * 0.9,
            width: size * 0.9,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: scaffoldColor,
            ),
            child: Center(
              child: Icon(
                icon,
                color: activeColor,
                size: size * 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
