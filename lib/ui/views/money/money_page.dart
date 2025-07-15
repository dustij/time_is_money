import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "package:time_is_money/ui/views/money/money_viewmodel.dart";
import "package:time_is_money/ui/widgets/custom_button.dart";

class MoneyPage extends HookConsumerWidget {
  const MoneyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = MoneyViewmodel(ref);

    final isRunning = useState(true);
    final showDollars = useState(true);
    final showCheckmark = useState(false);
    final dollars = viewmodel.currentDollars();

    CustomButton startStopButton;
    if (isRunning.value) {
      startStopButton = CustomButton(
        text: "Stop",
        color: Variant.red,
        onPressed: () {
          viewmodel.stopPressed();
          isRunning.value = false;
        },
      );
    } else {
      startStopButton = CustomButton(
        text: "Resume",
        color: Variant.blue,
        onPressed: () {
          viewmodel.resumePressed();
          isRunning.value = true;
        },
      );
    }

    return Stack(
      children: [
        Center(
          child: Column(
            children: [
              const Spacer(),
              AnimatedSwitcher(
                duration: Durations.short4,
                child: showDollars.value
                    ? Text(
                        "\$${dollars.toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    : Icon(
                        Icons.check,
                        size: 100,
                        color: Theme.of(context).colorScheme.outline,
                      ),
              ),
              const SizedBox(height: 64),
              const Spacer(),
            ],
          ),
        ),
        Center(
          child: Column(
            children: [
              const Spacer(),
              isRunning.value
                  ? Hero(tag: "start button", child: startStopButton)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 16,
                      children: [
                        startStopButton,
                        Hero(
                          tag: "start button",
                          child: CustomButton(
                            text: "✓",
                            color: Variant.green,
                            width: 100,
                            onPressed: () {
                              showDollars.value = false;
                              showCheckmark.value = true;
                              Future.delayed(
                                (Durations.long4),
                                viewmodel.savePressed,
                              );
                            },
                          ),
                        ),
                      ],
                    ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ],
    );
  }
}
