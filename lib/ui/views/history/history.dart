import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "package:time_is_money/core/models/entry.dart";
import "package:time_is_money/ui/views/history/history_viewmodel.dart";
import "package:time_is_money/ui/widgets/custom_button.dart";
import "package:time_is_money/ui/widgets/custom_table.dart";

class HistoryPage extends HookConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = HistoryViewmodel(ref, useState<List<Entry>>([]));
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              onPressed: viewmodel.goBack,
              icon: const Icon(Icons.arrow_back_ios, size: 32),
            ),
          ),
        ),
        viewmodel.asyncData.when(
          data: (data) {
            final rows = data
                .where((e) => e.date != DateTime.fromMillisecondsSinceEpoch(0))
                .toList();
            viewmodel.setRows(rows);
            return Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: CustomTable(
                      headers: ["Date", "Amount"],
                      rows: rows,
                      onRowPressed: viewmodel.onRowPressed,
                    ),
                  ),
                  if (viewmodel.showDeleteButton)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        border: Border(
                          top: BorderSide(
                            color: Theme.of(context).colorScheme.outlineVariant,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            text: "Delete",
                            color: Variant.red,
                            onPressed: viewmodel.onDeletePressed,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text("Error: $e"),
        ),
      ],
    );
  }
}
