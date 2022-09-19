import 'package:flutter/material.dart';
import 'package:music_player/src/modules/common/components/glowing_btn.dart';
import 'package:music_player/src/res/colors.dart';

class PowerBtn extends StatelessWidget {
  final double size;
  final void Function() onTap;
  final Color color;
  final Color inactiveColor;
  final bool isActive;
  const PowerBtn({
    Key? key,
    this.size = 50,
    required this.onTap,
    this.color = btnColor1,
    this.inactiveColor = Colors.grey,
    this.isActive = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final activeColor = isActive ? color : inactiveColor;
    return GlowingBtn(
      size: size,
      onTap: onTap,
      color: color,
      inactiveColor: inactiveColor,
      isActive: isActive,
      icon: Icons.power_settings_new_rounded,
    );
  }
}
