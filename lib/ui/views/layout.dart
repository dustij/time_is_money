import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "package:time_is_money/state/hourly_rate.dart";
import "package:time_is_money/ui/views/history/history.dart";
import "package:time_is_money/ui/views/layout_viewmodel.dart";

class Layout extends HookConsumerWidget {
  final Widget child;
  const Layout({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditingHourlyRate = useState(false);
    final focusNode = useFocusNode();
    final hourlyRateAsync = ref.watch(hourlyRateProvider);
    final initialText = hourlyRateAsync.when(
      data: (rate) => rate.toStringAsFixed(2),
      loading: () => "",
      error: (_, __) => "",
    );
    final controller = useTextEditingController(text: initialText);

    useEffect(() {
      hourlyRateAsync.whenData((rate) {
        controller.text = rate.toStringAsFixed(2);
      });
      return null;
    }, [hourlyRateAsync]);

    final viewmodel = LayoutViewmodel(
      ref: ref,
      isEditingHourlyRate: isEditingHourlyRate,
      focusNode: focusNode,
      controller: controller,
    );

    final themeColors = Theme.of(context).colorScheme;

    final disableDrawer = child is HistoryPage;

    if (isEditingHourlyRate.value) {
      Future.microtask(() => focusNode.requestFocus());
    }

    return Scaffold(
      body: Builder(
        builder: (context) => Stack(
          children: [
            if (!disableDrawer)
              Positioned(
                top: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Hero(
                      tag: "menu button",
                      child: TextButton.icon(
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        label: const Icon(Icons.menu, size: 36),
                        style: TextButton.styleFrom(
                          iconColor: Theme.of(context).colorScheme.outline,
                          overlayColor: Theme.of(
                            context,
                          ).colorScheme.outline.withAlpha(5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            SafeArea(child: child),
          ],
        ),
      ),
      drawer: disableDrawer
          ? null
          : Drawer(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: viewmodel.finishEditing,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 40,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 16,
                          children: [
                            GestureDetector(
                              onTap: viewmodel.beginEditing,
                              child: isEditingHourlyRate.value
                                  ? TextField(
                                      controller: viewmodel.controller,
                                      focusNode: viewmodel.focusNode,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r"^\d*\.?\d{0,2}"),
                                        ),
                                      ],
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            color: themeColors.outline,
                                          ),
                                      onSubmitted: viewmodel.onSubmitted,
                                    )
                                  : Text(
                                      "\$${viewmodel.formattedRate}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            color: themeColors.outline,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: false,
                                    ),
                            ),
                            isEditingHourlyRate.value
                                ? Text(
                                    "Enter a new rate",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.copyWith(
                                          color: themeColors.outline,
                                          fontSize: 14,
                                        ),
                                  )
                                : Text(
                                    "Per Hour",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.copyWith(
                                          color: themeColors.outline,
                                          fontSize: 14,
                                        ),
                                  ),
                          ],
                        ),
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.history, size: 36),
                        label: Text(
                          "History",
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(color: themeColors.outline),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: themeColors.outline,
                        ),
                        onPressed: viewmodel.onHistoryPressed,
                      ),
                    ],
                  ),
                ),
              ),
            ),
      onDrawerChanged: disableDrawer ? null : viewmodel.onDrawerChanged,
    );
  }
}
