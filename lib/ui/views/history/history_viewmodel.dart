import "package:flutter/foundation.dart";

import "package:hooks_riverpod/hooks_riverpod.dart";

import "package:time_is_money/core/models/entry.dart";
import "package:time_is_money/core/services/navigation_service.dart";
import "package:time_is_money/state/history.dart";

class HistoryViewmodel {
  final WidgetRef ref;
  final ValueNotifier<List<Entry>> selectedRows;
  late List<Entry> rows;

  HistoryViewmodel(this.ref, this.selectedRows);

  AsyncValue<List<Entry>> get asyncData => ref.watch(historyProvider);

  bool get showDeleteButton => selectedRows.value.isNotEmpty;

  void setRows(List<Entry> value) {
    rows = value;
  }

  void goBack() {
    NavigationService().goBack();
  }

  void onRowPressed(List<int> selectedIndexes) {
    final newList = List<Entry>.empty(growable: true);
    if (selectedIndexes.isNotEmpty) {
      for (int i in selectedIndexes) {
        newList.add(rows[i]);
      }
    }
    selectedRows.value = newList;
  }

  void onDeletePressed() {
    ref
        .read(historyProvider.notifier)
        .updateWith(
          rows.where((row) => !selectedRows.value.contains(row)).toList(),
        );
    selectedRows.value = [];
  }
}
