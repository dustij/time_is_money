import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:time_is_money/core/services/navigation_service.dart";
import "package:time_is_money/state/app_timer.dart";
import "package:time_is_money/ui/views/layout.dart";
import "package:time_is_money/ui/views/money/money_page.dart";

class HomeViewmodel {
  final WidgetRef ref;

  HomeViewmodel(this.ref);

  void startPressed() {
    ref.read(appTimerProvider.notifier).start();
    NavigationService().navigateFade(const Layout(child: MoneyPage()));
  }
}
