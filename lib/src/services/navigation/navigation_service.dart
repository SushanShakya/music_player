import 'package:flutter/material.dart';
import 'package:music_player/src/modules/common/views/curved_scaffold.dart';

class NavigationService {
  final BuildContext context;

  NavigationService(this.context);

  Future push(Widget screen,
      {bool rootNavigator = false, bool fullscreendialog = false}) {
    return Navigator.of(context, rootNavigator: rootNavigator).push(
      MaterialPageRoute(
          builder: (c) => screen, fullscreenDialog: fullscreendialog),
    );
  }

  Future pushReplacement(Widget screen,
      {bool rootNavigator = false, bool fullscreendialog = false}) {
    return Navigator.of(context, rootNavigator: rootNavigator).pushReplacement(
      MaterialPageRoute(
          builder: (c) => screen, fullscreenDialog: fullscreendialog),
    );
  }

  pushSlideUp(Widget screen,
      {bool rootNavigator = false, bool fullScreenDialog = false}) {
    return Navigator.of(
      context,
      rootNavigator: rootNavigator,
    ).push(SlideRoute(child: screen, fullscreenDialog: fullScreenDialog));
  }

  pushSlideLeft(Widget screen,
      {bool rootNavigator = false, bool fullScreenDialog = false}) {
    return Navigator.of(
      context,
      rootNavigator: rootNavigator,
    ).push(SlideRoute(
      child: screen,
      fullscreenDialog: fullScreenDialog,
      offset: const Offset(1, 0),
    ));
  }
}

class SlideRoute extends PageRouteBuilder {
  final Widget child;
  final Offset? offset;
  SlideRoute({required this.child, bool fullscreenDialog = false, this.offset})
      : super(
            fullscreenDialog: fullscreenDialog,
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (a, b, c) => child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      transformHitTests: false,
      position: Tween<Offset>(
        begin: offset ?? const Offset(0, 1),
        end: Offset.zero,
      ).animate(animation),
      child: CurvedScaffold(child: child),
    );
  }
}
