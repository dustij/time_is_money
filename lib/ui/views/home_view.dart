import "package:flutter/material.dart";
import "package:time_is_money/ui/views/layout.dart";
import "package:time_is_money/ui/views/live_view.dart";

import "package:time_is_money/ui/widgets/custom_button.dart";

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: "start button",
        child: CustomButton(
          text: "Start",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => Layout(child: const LiveView()),
              ),
            );
          },
        ),
      ),
    );
  }
}
