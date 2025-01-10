part of '../reusable_import.dart';

/// A custom widget that wraps a [child] widget with a [RefreshIndicator] to provide pull-to-refresh functionality.
///
/// This widget is useful for implementing pull-to-refresh behavior in lists or other scrollable content within a Flutter app.
/// The widget expects a [child] widget (such as a [ListView], [GridView], or any other scrollable widget) and a callback function
/// [onRefresh], which is invoked when the user performs a pull-to-refresh gesture.
///
/// ## Usage
/// ```dart
/// RefreshView(
///   child: YourScrollableWidget(), // The widget you want to wrap with pull-to-refresh behavior
///   onRefresh: () async {
///     // Your custom refresh logic here
///   },
/// )
/// ```
///
/// The [onRefresh] callback will be triggered when the user pulls down to refresh the content.
class RefreshView extends StatefulWidget {
  /// The child widget that will be wrapped with the pull-to-refresh functionality.
  /// This can be any scrollable widget like [ListView], [GridView], etc.
  final Widget? child;

  /// The callback function that is called when the pull-to-refresh gesture is performed.
  /// It is expected to be an asynchronous function, typically used for refreshing the data or performing network requests.
  final Function? onRefresh;

  /// Creates a [RefreshView] widget that wraps a [child] widget with pull-to-refresh functionality.
  ///
  /// - [child] is the widget that will be displayed and refreshed.
  /// - [onRefresh] is the callback function triggered during the refresh action.
  const RefreshView({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  State<RefreshView> createState() => _RefreshViewState();
}

class _RefreshViewState extends State<RefreshView> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      // The child widget wrapped inside the RefreshIndicator, or an empty container if no child is provided.
      child: widget.child ?? Container(),

      // Trigger the refresh callback when the user pulls to refresh.
      onRefresh: () async {
        // Check if the onRefresh callback is provided, then invoke it.
        if (widget.onRefresh != null) {
          widget.onRefresh!();
        }
      },
    );
  }
}
