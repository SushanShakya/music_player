import 'package:flutter/material.dart';

class RoundedTriangleWidget extends StatelessWidget {
  final double size;
  final Widget? child;
  final Color color;
  const RoundedTriangleWidget({
    Key? key,
    this.size = 50,
    this.child,
    this.color = Colors.white,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: RoundedTriangle(),
      child: Container(
        height: size,
        width: size * 0.7,
        color: color,
        child: child,
      ),
    );
  }
}

class RoundedTriangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final h = size.height;
    final w = size.width;
    final h0 = h * 0.1;
    final w0 = w * 0.1;
    final h1 = h0 * 2;
    final w1 = h0 * 2;
    final p0 = Offset(w1, h0);
    final p1 = Offset(w - w0, (h / 2) - (h0 * 0.7));
    final p2 = Offset(w - w0, (h / 2) + (h0 * 0.7));
    final p3 = Offset(p0.dx, h - p0.dy);
    final p4 = Offset(w0, h - h1);
    final p5 = Offset(w0, h1);
    Path path = Path();
    path.moveTo(p0.dx, p0.dy);
    path.lineTo(p1.dx, p1.dy);
    path.quadraticBezierTo(w, h / 2, p2.dx, p2.dy);
    path.lineTo(p3.dx, p3.dy);
    path.quadraticBezierTo(p4.dx, h, p4.dx, p4.dy);
    path.lineTo(p5.dx, p5.dy);
    path.quadraticBezierTo(p5.dx, 0, p0.dx, p0.dy);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
