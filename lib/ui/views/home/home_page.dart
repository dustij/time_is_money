import "package:flutter/material.dart";

import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:time_is_money/ui/views/home/home_viewmodel.dart";
import "package:time_is_money/ui/widgets/custom_button.dart";

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = HomeViewmodel(ref);
    return Center(
      child: Hero(
        tag: "start button",
        child: CustomButton(text: "Start", onPressed: viewmodel.startPressed),
      ),
    );
  }
}
