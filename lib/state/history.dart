import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:time_is_money/core/models/entry.dart";
import "package:time_is_money/core/services/file_storage.dart";

part "history.g.dart";

/// - To regenerate code, run:
///   `dart run build_runner build --delete-conflicting-outputs`.
@riverpod
class History extends _$History {
  @override
  Future<List<Entry>> build() async {
    Future.microtask(() async {
      final saved = await FileStorage().readHistory();
      final lines = saved.split("\n");
      final entries = lines.map((line) {
        if (line.isEmpty) return Entry.blank();
        final parts = line.split(",");
        return Entry(date: parts[0], dollars: double.parse(parts[1]));
      }).toList();
      state = AsyncData(entries);
    });
    return List<Entry>.empty();
  }

  void updateWith(List<Entry> data) {
    final newState = List<Entry>.empty(growable: true);
    var inputString = "";
    for (final entry in data) {
      newState.add(entry);
      inputString =
          "$inputString${entry.date.toIso8601String()}, ${entry.dollars.toStringAsFixed(2)}, \n";
    }
    state = AsyncData(newState);
    FileStorage().writeHistory(inputString);
  }
}
