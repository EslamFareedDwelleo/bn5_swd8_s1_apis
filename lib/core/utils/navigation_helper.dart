import 'package:flutter/material.dart';

extension NavigationHelper on BuildContext {
  void goTo(Widget screen) {
    Navigator.push(this, _buildRoute(screen));
  }

  PageRoute _buildRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
        );
      },
    );
  }

  void goOff(Widget screen) {
    Navigator.pushReplacement(this, _buildRoute(screen));
  }

  void goBack() {
    Navigator.pop(this);
  }
}
