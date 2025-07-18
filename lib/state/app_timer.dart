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

  late DateTime _lastPausedTime;
  bool _isPaused = false;

  double get _hourlyRate => ref.read(hourlyRateProvider).value ?? 0;
  double get _ratePerSecond => calculateRatePerSecond(_hourlyRate);

  @override
  bool build() {
    return false;
  }

  void start() {
    if (_timer != null) return; // already running
    state = true;

    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      ref.read(currentDollarsProvider.notifier).incrementBy(_ratePerSecond);
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    state = false;
  }

  void onAppPaused() {
    _lastPausedTime = DateTime.now();
    _isPaused = true;
  }

  void onAppResumed() {
    if (!_isPaused) return;

    final now = DateTime.now();
    final pausedDuration = now.difference(_lastPausedTime);
    ref
        .read(currentDollarsProvider.notifier)
        .incrementBy(pausedDuration.inSeconds * _ratePerSecond);
  }
}
