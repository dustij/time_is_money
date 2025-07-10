import "package:flutter/material.dart";
import "package:time_is_money/ui/theme/tailwind_colors.dart";

class Layout extends StatelessWidget {
  final Widget child;
  const Layout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                    onPressed: () {},
                    label: const Icon(Icons.menu, size: 36),
                    style: TextButton.styleFrom(
                      iconColor: TailwindColors.neutral800,
                      overlayColor: TailwindColors.neutral500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Drawer(child: Text("Settings go here")),
          SafeArea(child: child),
        ],
      ),
    );
  }
}
