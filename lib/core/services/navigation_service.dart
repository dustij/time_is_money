import "package:flutter/material.dart";

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();

  factory NavigationService() => _instance;

  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> navigateFade(Widget page) {
    return navigatorKey.currentState!.push(
      PageRouteBuilder(
        transitionDuration: Durations.medium1,
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          );

          return FadeTransition(opacity: curvedAnimation, child: child);
        },
      ),
    );
  }

  void goBack() {
    navigatorKey.currentState!.pop();
  }
}
