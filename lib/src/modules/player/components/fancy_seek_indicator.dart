import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music_player/src/res/colors.dart';

enum SeekItemSize { small, medium, large }

extension SeekItemSizeUtil on SeekItemSize {
  double get sizePercent {
    switch (this) {
      case SeekItemSize.small:
        return 0.5;
      case SeekItemSize.medium:
        return 0.7;
      default:
        return 1;
    }
  }
}

class FancySeekIndicator extends StatefulWidget {
  final int count;
  final double percentage;
  final void Function(double) onChange;
  const FancySeekIndicator({
    Key? key,
    this.count = 30,
    required this.onChange,
    required this.percentage,
  })  : assert(percentage >= 0 && percentage <= 1),
        super(key: key);
  @override
  State<FancySeekIndicator> createState() => _FancySeekIndicatorState();
}

class _FancySeekIndicatorState extends State<FancySeekIndicator> {
  static Color activeColor = scaffoldColor;

  late List<SeekItemSize> _items;

  late double scrollTouchPosition;

  @override
  void initState() {
    super.initState();
    scrollTouchPosition = 0;
    _items = List.generate(widget.count, (i) {
      if (i == 0) return SeekItemSize.small;
      if (i == (widget.count - 1)) return SeekItemSize.small;
      Random r = Random();
      var x = r.nextInt(3);
      return SeekItemSize.values[x];
    });
  }

  double _getPercent(double maxWidth, double dx) {
    return (dx / maxWidth).clamp(0, 1);
  }

  @override
  Widget build(BuildContext context) {
    const height = 30;
    int includedIndex = (widget.percentage * widget.count).floor();
    return LayoutBuilder(
      builder: (c, box) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        // onPanStart: (dat) {
        //   print('-- on pan start');
        //   print(dat.localPosition);
        // },
        // onPanUpdate: (dat) {
        //   print('-- on pan Update');
        //   print(dat.localPosition);
        // },
        // onPanEnd: (dat) {},
        // onPanDown: (dat) {
        //   print('--- on pan down ');
        //   print(dat.localPosition);
        // },
        onHorizontalDragStart: (dat) {
          double p = _getPercent(box.maxWidth, dat.localPosition.dx);
          print(p);
          widget.onChange(p);
        },
        onHorizontalDragUpdate: (dat) {
          double p = _getPercent(box.maxWidth, dat.localPosition.dx);
          print(p);
          widget.onChange(p);
        },

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            _items.length,
            (i) {
              var cur = _items[i];
              bool active = i < includedIndex;
              double totalPercent = 1 / _items.length;
              double startPercent = (i * totalPercent);
              double endPercent = startPercent + totalPercent;
              bool percentInRange = widget.percentage >= startPercent &&
                  widget.percentage <= endPercent;
              double percent = widget.percentage - startPercent;
              double widthPercent = percent / totalPercent;
              return Stack(
                children: [
                  Container(
                    height: cur.sizePercent * height,
                    width: 5,
                    decoration: BoxDecoration(
                      color: active ? activeColor : inactiveColor,
                      // color: Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  if ((!active) && percentInRange)
                    SizedBox(
                      width: 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        clipBehavior: Clip.hardEdge,
                        child: Row(
                          children: [
                            Container(
                              height: cur.sizePercent * height,
                              width: 5 * widthPercent,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                // color: activeColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
