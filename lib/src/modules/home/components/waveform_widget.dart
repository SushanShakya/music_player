import 'package:flutter/material.dart';

class WaveformWidget extends StatefulWidget {
  final double maxHeight;
  const WaveformWidget({
    Key? key,
    required this.maxHeight,
  }) : super(key: key);
  @override
  State<WaveformWidget> createState() => _WaveformWidgetState();
}

class _WaveformWidgetState extends State<WaveformWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const count = 6;
    return AnimatedBuilder(
      animation: controller,
      builder: (c, child) => Row(
        children: List.generate(count, (i) {
          int maxExtent = (controller.value * count).floor();
          bool inRange =
              [(maxExtent - 1), maxExtent, maxExtent + 1].contains(i);
          bool inPeriferi =
              [maxExtent - 1, maxExtent + 1].map((e) => e).contains(i);
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(right: 3),
            height: inRange
                ? inPeriferi
                    ? widget.maxHeight * 0.8
                    : widget.maxHeight
                : 10,
            width: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              color: Colors.white,
            ),
          );
        }),
      ),
    );
  }
}
