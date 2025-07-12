import "package:riverpod_annotation/riverpod_annotation.dart";

part "hourly_rate.g.dart";

/// - To regenerate code, run:
///   `dart run build_runner build --delete-conflicting-outputs`.
@Riverpod(keepAlive: true)
class HourlyRate extends _$HourlyRate {
  @override
  double build() {
    return 0;
  }

  void set(double newRate) {
    state = newRate;
  }
}
