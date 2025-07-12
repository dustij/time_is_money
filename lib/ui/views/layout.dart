import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "package:time_is_money/ui/views/layout_viewmodel.dart";

class Layout extends HookConsumerWidget {
  final Widget child;
  const Layout({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = LayoutViewmodel(
      ref: ref,
      isEditingHourlyRate: useState(false),
    );
    viewmodel.maybeRequestFocus();

    final themeColors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Builder(
        builder: (context) => Stack(
          children: [
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
      drawer: Drawer(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: viewmodel.cancelEditing,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: [
                      GestureDetector(
                        onTap: viewmodel.beginEditing,
                        child: viewmodel.isEditingHourlyRate
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
                                style: Theme.of(context).textTheme.headlineLarge
                                    ?.copyWith(
                                      color: themeColors.outline,
                                      fontSize: 68,
                                    ),
                                onSubmitted: viewmodel.onSubmitted,
                              )
                            : Text(
                                "\$${viewmodel.hourlyRateFormatted}",
                                style: Theme.of(context).textTheme.headlineLarge
                                    ?.copyWith(
                                      color: themeColors.outline,
                                      fontSize: 68,
                                    ),
                              ),
                      ),
                      viewmodel.isEditingHourlyRate
                          ? Text(
                              "Enter a new rate",
                              style: Theme.of(context).textTheme.headlineLarge
                                  ?.copyWith(
                                    color: themeColors.outline,
                                    fontSize: 14,
                                  ),
                            )
                          : Text(
                              "Per Hour",
                              style: Theme.of(context).textTheme.headlineLarge
                                  ?.copyWith(
                                    color: themeColors.outline,
                                    fontSize: 14,
                                  ),
                            ),
                    ],
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.settings, size: 36),
                  label: Text(
                    "Settings",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: themeColors.outline,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: themeColors.outline,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      onDrawerChanged: viewmodel.handleDrawerChanged,
    );
  }
}
