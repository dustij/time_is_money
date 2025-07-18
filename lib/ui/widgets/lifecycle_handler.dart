import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

/// A widget that listens to app lifecycle changes and triggers a callback
/// when the app's lifecycle state changes.
///
/// This widget uses [HookWidget] to manage the lifecycle observer and
/// automatically adds/removes it as needed. The [onChange] callback is
/// invoked with the new [AppLifecycleState] whenever the app's lifecycle
/// state changes.
///
/// Example usage:
/// ```dart
/// LifecycleHandler(
///   onChange: (state) {
///     // Handle lifecycle state change
///   },
///   child: MyApp(),
/// )
/// ```
class LifecycleHandler extends HookWidget {
  /// The widget below this handler in the widget tree.
  final Widget child;

  /// Callback invoked when the app's lifecycle state changes.
  final void Function(AppLifecycleState state) onChange;

  /// Creates a [LifecycleHandler].
  ///
  /// The [child] and [onChange] parameters are required.
  const LifecycleHandler({
    super.key,
    required this.child,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    // Memoize the observer so it is not recreated on every build.
    final observer = useMemoized(() => _Observer(onChange), const []);

    // Add the observer when the widget is mounted, and remove it on dispose.
    useEffect(() {
      WidgetsBinding.instance.addObserver(observer);

      return () => WidgetsBinding.instance.removeObserver(observer);
    }, const []);

    return child;
  }
}

/// Internal observer that listens to app lifecycle changes and
/// delegates them to the provided [onChange] callback.
class _Observer extends WidgetsBindingObserver {
  /// Callback to invoke when the app's lifecycle state changes.
  final void Function(AppLifecycleState state) onChange;

  /// Creates an [_Observer] with the given [onChange] callback.
  _Observer(this.onChange);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) => onChange(state);
}
