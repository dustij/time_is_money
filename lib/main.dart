import "package:flutter/material.dart";

import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:time_is_money/core/services/navigation_service.dart";
import "package:time_is_money/ui/theme/app_theme.dart";
import "package:time_is_money/ui/views/history/history.dart";
import "package:time_is_money/ui/views/home/home_page.dart";
import "package:time_is_money/ui/views/layout.dart";
import "package:time_is_money/ui/views/money/money_page.dart";

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: appTheme,
      initialRoute: "/",
      routes: {
        "/": (context) => const Layout(child: HomePage()),
        "/money": (context) => const Layout(child: MoneyPage()),
        "/history": (context) => const Layout(child: HistoryPage()),
      },
      navigatorKey: NavigationService().navigatorKey,
    );
  }
}
