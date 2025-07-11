import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:time_is_money/core/services/navigation_service.dart";
import "package:time_is_money/state/app_timer.dart";

class HomeViewmodel {
  void startPressed(WidgetRef ref) {
    ref.read(appTimerProvider.notifier).start();
    NavigationService().navigateTo("/money");
  }
}
