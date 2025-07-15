import "dart:async";

import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:time_is_money/core/utils/time_helpers.dart";
import "package:time_is_money/state/current_dollars.dart";
import "package:time_is_money/state/hourly_rate.dart";

part "app_timer.g.dart";

/// - To regenerate code, run:
///   `dart run build_runner build --delete-conflicting-outputs`.
@Riverpod(keepAlive: true)
class AppTimer extends _$AppTimer {
  Timer? _timer;

  @override
  bool build() {
    return false;
  }

  void start() {
    if (_timer != null) return; // already running
    state = true;

    final hourlyRate = ref.read(hourlyRateProvider).value ?? 0;

    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      final amount = calculateRatePerSecond(hourlyRate);
      ref.read(currentDollarsProvider.notifier).incrementBy(amount);
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    state = false;
  }
}
