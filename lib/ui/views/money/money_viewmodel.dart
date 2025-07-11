import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:time_is_money/state/app_timer.dart";
import "package:time_is_money/state/current_dollars.dart";

class MoneyViewmodel {
  double currentDollars(WidgetRef ref) {
    return ref.watch(currentDollarsProvider);
  }

  void stopPressed(WidgetRef ref) {
    ref.read(appTimerProvider.notifier).stop();
  }
}
