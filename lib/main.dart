import "package:flutter/material.dart";

import "package:hooks_riverpod/hooks_riverpod.dart";

import "package:time_is_money/core/services/navigation_service.dart";
import "package:time_is_money/state/app_timer.dart";
import "package:time_is_money/ui/theme/app_theme.dart";
import "package:time_is_money/ui/views/history/history.dart";
import "package:time_is_money/ui/views/home/home_page.dart";
import "package:time_is_money/ui/views/layout.dart";
import "package:time_is_money/ui/views/money/money_page.dart";
import "package:time_is_money/ui/widgets/lifecycle_handler.dart";

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LifecycleHandler(
      onChange: (state) {
        switch (state) {
          case AppLifecycleState.paused:
            ref.read(appTimerProvider.notifier).onAppPaused();
          case AppLifecycleState.resumed:
            ref.read(appTimerProvider.notifier).onAppResumed();
          default:
            return;
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Flutter Demo",
        theme: appTheme,
        initialRoute: "/",
        routes: {
          "/": (context) => const Layout(child: HomePage()),
          "/money": (context) => const Layout(child: MoneyPage()),
          "/history": (context) => const Layout(child: HistoryPage()),
        },
        navigatorKey: NavigationService().navigatorKey,
      ),
    );
  }
}
