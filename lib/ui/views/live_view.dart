import "package:flutter/material.dart";
import "package:time_is_money/ui/widgets/custom_button.dart";

class LiveView extends StatelessWidget {
  const LiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            children: [
              const Spacer(),
              Text("\$1000.99", style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 64),
              const Spacer(),
            ],
          ),
        ),
        Center(
          child: Column(
            children: [
              const Spacer(),
              Hero(
                tag: "start button",
                child: CustomButton(
                  text: "Stop",
                  isVariant: true,
                  onPressed: () {},
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
