import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:time_is_money/core/services/navigation_service.dart";
import "package:time_is_money/state/app_timer.dart";
import "package:time_is_money/state/current_dollars.dart";
import "package:time_is_money/ui/views/home/home_page.dart";
import "package:time_is_money/ui/views/layout.dart";

class MoneyViewmodel {
  final WidgetRef _ref;

  MoneyViewmodel(this._ref);

  double currentDollars() {
    return _ref.watch(currentDollarsProvider);
  }

  void stopPressed() {
    _ref.read(appTimerProvider.notifier).stop();
  }

  void resumePressed() {
    _ref.read(appTimerProvider.notifier).start();
  }

  void savePressed() {
    _ref.read(currentDollarsProvider.notifier).save();
    _ref.read(currentDollarsProvider.notifier).reset();
    NavigationService().navigateFade(const Layout(child: HomePage()));
  }
}
