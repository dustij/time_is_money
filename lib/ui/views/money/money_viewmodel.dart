import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:time_is_money/core/services/navigation_service.dart";
import "package:time_is_money/state/app_timer.dart";
import "package:time_is_money/state/current_dollars.dart";
import "package:time_is_money/ui/views/home/home_page.dart";
import "package:time_is_money/ui/views/layout.dart";

class MoneyViewmodel {
  double currentDollars(WidgetRef ref) {
    return ref.watch(currentDollarsProvider);
  }

  void stopPressed(WidgetRef ref) {
    ref.read(appTimerProvider.notifier).stop();
  }

  void resumePressed(WidgetRef ref) {
    ref.read(appTimerProvider.notifier).start();
  }

  void savePressed(WidgetRef ref) {
    ref.read(currentDollarsProvider.notifier).reset();
    NavigationService().navigateFade(const Layout(child: HomePage()));
  }
}
