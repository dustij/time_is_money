import "package:flutter/material.dart";

import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:time_is_money/state/current_dollars.dart";

import "package:time_is_money/ui/views/money/money_viewmodel.dart";
import "package:time_is_money/ui/widgets/custom_button.dart";

class MoneyPage extends ConsumerWidget {
  const MoneyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = MoneyViewmodel();
    final dollars = viewmodel.currentDollars(ref);
    return Stack(
      children: [
        Center(
          child: Column(
            children: [
              const Spacer(),
              Text(
                "\$${dollars.toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 64),
              const Spacer(),
            ],
          ),
        ),
        Center(
          child: Column(
            children: [
              // TODO: when stop is pressed change it to start button and place blue button next that can save it
              const Spacer(),
              Hero(
                tag: "start button",
                child: CustomButton(
                  text: "Stop",
                  isVariant: true,
                  onPressed: () => viewmodel.stopPressed(ref),
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ],
    );
  }
}
