import 'package:flutter/material.dart';

import '../../../res/dimens.dart';

class CurvedScaffold extends StatelessWidget {
  final Widget child;
  const CurvedScaffold({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(appBorderRadius),
      child: child,
    );
  }
}
