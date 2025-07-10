import "package:flutter/material.dart";

import "package:time_is_money/ui/theme/app_theme.dart";
import "package:time_is_money/ui/views/home_view.dart";
import "package:time_is_money/ui/views/layout.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: appTheme,
      home: const Layout(child: HomeView()),
    );
  }
}
