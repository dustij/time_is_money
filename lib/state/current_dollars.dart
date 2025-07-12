import "package:riverpod_annotation/riverpod_annotation.dart";

part "current_dollars.g.dart";

/// - To regenerate code, run:
///   `dart run build_runner build --delete-conflicting-outputs`.
@riverpod
class CurrentDollars extends _$CurrentDollars {
  @override
  double build() {
    return 0;
  }

  void set(double dollars) {
    state = dollars;
  }

  void incrementBy(double amount) {
    state += amount;
  }

  void reset() {
    state = 0;
  }
}
