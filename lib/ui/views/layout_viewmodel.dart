import "package:flutter/material.dart";

import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:time_is_money/core/services/navigation_service.dart";
import "package:time_is_money/state/hourly_rate.dart";

class LayoutViewmodel {
  final WidgetRef ref;
  final ValueNotifier<bool> isEditingHourlyRate;
  final FocusNode focusNode;
  final TextEditingController controller;

  LayoutViewmodel({
    required this.ref,
    required this.isEditingHourlyRate,
    required this.focusNode,
    required this.controller,
  });

  String get formattedRate => ref
      .read(hourlyRateProvider)
      .when(
        data: (rate) => rate.toStringAsFixed(2),
        loading: () => "",
        error: (_, __) => "",
      );

  void onDrawerChanged(bool isOpened) {
    if (!isOpened) {
      finishEditing();
    }
  }

  void onSubmitted(String value) {
    ref.read(hourlyRateProvider.notifier).set(double.parse(value));
    isEditingHourlyRate.value = false;
  }

  void beginEditing() {
    controller.text = formattedRate;
    isEditingHourlyRate.value = true;
  }

  void finishEditing() {
    onSubmitted(controller.text);
  }

  void onHistoryPressed() {
    NavigationService().goBack();
    NavigationService().navigateTo("/history");
  }
}
