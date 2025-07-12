import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:time_is_money/state/hourly_rate.dart";

class LayoutViewmodel {
  final WidgetRef _ref;
  final ValueNotifier<bool> _isEditingHourlyRate;
  final FocusNode focusNode;
  final TextEditingController controller;

  LayoutViewmodel({
    required WidgetRef ref,
    required ValueNotifier<bool> isEditingHourlyRate,
  }) : _isEditingHourlyRate = isEditingHourlyRate,
       _ref = ref,
       controller = useTextEditingController(
         text: ref.watch(hourlyRateProvider).toStringAsFixed(2),
       ),
       focusNode = useFocusNode();

  double get hourlyRate => _ref.watch(hourlyRateProvider);
  String get hourlyRateFormatted =>
      _ref.watch(hourlyRateProvider).toStringAsFixed(2);
  bool get isEditingHourlyRate => _isEditingHourlyRate.value;

  void onSubmitted(String value) {
    _ref.read(hourlyRateProvider.notifier).set(double.parse(value));
    _isEditingHourlyRate.value = false;
  }

  void beginEditing() {
    controller.text = hourlyRateFormatted;
    _isEditingHourlyRate.value = true;
  }

  void cancelEditing() {
    onSubmitted(controller.text);
    _isEditingHourlyRate.value = false;
  }

  void handleDrawerChanged(bool isOpened) {
    if (!isOpened) {
      cancelEditing();
    }
  }

  void maybeRequestFocus() {
    useEffect(() {
      if (_isEditingHourlyRate.value) {
        Future.microtask(() => focusNode.requestFocus());
      }
      return null;
    }, [_isEditingHourlyRate.value]);
  }
}
