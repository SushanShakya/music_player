import 'package:flutter/material.dart';

import '../../../res/colors.dart';
import '../../common/components/tap_effect.dart';

class RoundIconBtn extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;
  const RoundIconBtn({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TapEffect(
      onClick: onTap,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: scaffoldColor,
          boxShadow: [
            BoxShadow(
              color: scaffoldColor.withOpacity(0.6),
              blurRadius: 2,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
