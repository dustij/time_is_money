import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "package:time_is_money/core/models/entry.dart";
import "package:time_is_money/core/utils/time_helpers.dart";
import "package:time_is_money/state/history.dart";

class CustomTable extends HookConsumerWidget {
  final List<String> headers;
  final List<Entry> rows;
  final Function(List<int> selectedIndexes) onRowPressed;

  const CustomTable({
    super.key,
    required this.headers,
    required this.rows,
    required this.onRowPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedIndexes = useState<List<int>>([]);

    useEffect(() {
      selectedIndexes.value = [];
      return null;
    }, [ref.watch(historyProvider)]);

    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _HeaderDelegate(headers),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, i) => _Row(
              data: rows[i],
              isSelected: selectedIndexes.value.contains(i),
              onPressed: (isSelected) {
                final newList = List<int>.from(selectedIndexes.value);
                if (isSelected) {
                  newList.remove(i);
                } else {
                  newList.add(i);
                }
                onRowPressed(newList);
                selectedIndexes.value = newList;
              },
            ),
            childCount: rows.length,
          ),
        ),
      ],
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final List<String> headers;

  _HeaderDelegate(this.headers);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: maxExtent,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: shrinkOffset > 0
            ? [
                BoxShadow(
                  color: Colors.black.withAlpha(60),
                  offset: const Offset(0, 2),
                  blurRadius: 8,
                ),
              ]
            : [],
      ),
      child: Row(
        children: headers.map((header) {
          return Expanded(
            child: Center(
              child: Text(
                header,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  double get maxExtent => kMinInteractiveDimension;

  @override
  double get minExtent => kMinInteractiveDimension;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class _Row extends StatelessWidget {
  final Entry data;
  final bool isSelected;
  final Function(bool isSelected) onPressed;

  const _Row({
    required this.data,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(isSelected),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.error.withAlpha(60)
              : Theme.of(context).colorScheme.surface,
        ),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "${convertWeekday(data.date.weekday)} ${data.date.month}-${data.date.day}-${data.date.year.toInt() - 2000}",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "\$ ${data.dollars.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
