import 'dart:math';

import 'package:flutter/material.dart';

import '../../../res/colors.dart';

class VolumeBtn extends StatelessWidget {
  final double size;
  final double percentage;
  const VolumeBtn({
    Key? key,
    this.size = 100,
    required this.percentage,
  })  : assert(percentage >= 0 && percentage <= 1),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return _Body(
      size: size,
      percentage: percentage,
    );
  }
}

class _Body extends StatelessWidget {
  final double size;
  final double percentage;
  const _Body({
    Key? key,
    required this.size,
    required this.percentage,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const firstAngle = -(pi * 0.75);
    const lastAngle = pi * 0.75;
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            blurRadius: 4,
          ),
        ],
        gradient: LinearGradient(
          colors: [
            const Color(0xffABABAB),
            const Color(0xffA5A5A5),
            Colors.black.withOpacity(0.5)
          ],
        ),
      ),
      child: Transform.rotate(
        angle: (firstAngle * (1 - percentage)) + (lastAngle * percentage),
        child: Center(
          child: Stack(
            children: [
              Container(
                height: size * 0.87,
                width: size * 0.87,
                decoration: const BoxDecoration(
                  color: volumeColor,
                  shape: BoxShape.circle,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Icon(
                  Icons.change_history_rounded,
                  color: Colors.white,
                  size: size * 0.17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VolumeArcPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.arcTo(
      const Offset(0, 0) & size,
      0,
      10,
      false,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
