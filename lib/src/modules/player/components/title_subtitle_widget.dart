import 'package:flutter/material.dart';

import '../../../res/styles.dart';

class TitleSubtitleWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const TitleSubtitleWidget({
    Key? key,
    this.title,
    this.subtitle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title ?? "No Song Selected",
          maxLines: 1,
          textAlign: TextAlign.center,
          style: titleStyle,
        ),
        Text(
          subtitle ?? "-",
          style: subtitleStyle,
          textAlign: TextAlign.center,
          maxLines: 2,
        )
      ],
    );
  }
}
