part of '../reusable_import.dart';

/// A widget that allows you to restart a part of the widget tree by resetting its key.
///
/// This widget is useful for situations where you need to "reset" a subtree of the widget tree,
/// which is commonly needed when performing state resets or refreshing certain parts of the UI.
/// The widget achieves this by generating a new `Key` each time it's triggered, forcing the subtree to be rebuilt from scratch.
///
/// ## Key Features:
/// - Allows "restarting" a widget by generating a new unique key for the subtree.
/// - Can be triggered programmatically via the `restartApp()` method.
/// - The widget rebuilds itself from scratch when restarted, which can be useful in scenarios like login state reset,
///   refreshing UI components, or handling dynamic state changes.
///
/// ## How to Use:
/// Wrap the part of the widget tree you want to be able to restart with the `RestartWidget`.
/// You can then call `RestartWidget.restartApp(context)` to trigger a restart of the widget subtree,
/// which will cause the widget to rebuild itself from scratch.
///
/// Example usage:
/// ```dart
/// RestartWidget(
///   child: MyWidget(), // Wrap the widget you want to restart
/// );
/// ```
///
/// To trigger a restart programmatically, use:
/// ```dart
/// RestartWidget.restartApp(context);
/// ```
///
/// ## Constructor Parameters:
/// - `child`: The widget that will be wrapped inside the `RestartWidget`. This is the widget that will be "restarted" when triggered. If not provided, it defaults to an empty widget (`SizedBox.shrink()`).
///
/// ## Method:
/// - `restartApp(BuildContext context)`: This static method can be called to trigger a restart of the widget subtree. It searches for the nearest `RestartWidget` ancestor and calls its `restartApp` method to trigger the rebuild.
class RestartWidget extends StatefulWidget {
  final Widget? child;

  /// Creates a [RestartWidget] that allows you to restart its child widget subtree by resetting its key.
  ///
  /// The [child] widget will be the subtree that gets rebuilt when the `restartApp()` method is called.
  const RestartWidget({
    super.key,
    this.child,
  });

  /// Restarts the widget subtree wrapped by [RestartWidget].
  ///
  /// This method triggers the `restartApp()` method on the nearest [RestartWidget] ancestor
  /// in the widget tree, causing it to rebuild by generating a new unique key.
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  /// Restarts the widget by generating a new [UniqueKey].
  ///
  /// This triggers a rebuild of the entire widget subtree wrapped by the [RestartWidget],
  /// effectively resetting the state and UI.
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    // The widget rebuilds by using KeyedSubtree to trigger a new key when restartApp is called
    return KeyedSubtree(
      key: key,
      child: widget.child ?? const SizedBox.shrink(),
    );
  }
}
