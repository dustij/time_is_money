import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:time_is_money/core/services/file_storage.dart";

part "hourly_rate.g.dart";

/// - To regenerate code, run:
///   `dart run build_runner build --delete-conflicting-outputs`.
@Riverpod(keepAlive: true)
class HourlyRate extends _$HourlyRate {
  @override
  Future<double> build() async {
    Future.microtask(() async {
      final saved = await FileStorage().readHourlyRate();
      state = AsyncData(saved.toDouble());
    });
    return 0;
  }

  void set(double value) {
    state = AsyncData(value);
    Future(() async {
      FileStorage().writeHourlyRate(value);
    });
  }
}
