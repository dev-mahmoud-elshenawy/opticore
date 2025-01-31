part of '../reusable_import.dart';

/// A widget that provides the functionality to close the app by double-tapping the back button.
///
/// This widget displays a [SnackBar] when the user presses the back button for the first time. If the user presses the back button again within a short time frame, the app will be closed. If no second tap occurs, the [SnackBar] will be dismissed automatically.
///
/// **Note**: This behavior is applicable only on Android. On other platforms, this widget has no effect, and the [child] widget is displayed as is.
///
/// To use this widget, wrap it around the relevant widget tree and provide a [SnackBar] to be shown when the back button is pressed.
///
/// Example usage:
/// ```dart
/// DoubleBackExit(
///   snackBar: SnackBar(content: Text('Press back again to exit')),
///   child: YourChildWidget(),
/// );
/// ```
class DoubleBackExit extends StatefulWidget {
  /// The [SnackBar] displayed when the user taps the back button.
  final SnackBar snackBar;

  /// The widget displayed below this widget in the tree.
  final Widget child;

  /// Creates a widget that enables the user to close the app by double-tapping the back button.
  const DoubleBackExit({
    super.key,
    required this.snackBar,
    required this.child,
  });

  @override
  _DoubleBackExitState createState() => _DoubleBackExitState();
}

class _DoubleBackExitState extends State<DoubleBackExit> {
  /// A [Completer] that tracks whether the current [SnackBar] has been closed.
  var _closedCompleter = Completer<SnackBarClosedReason>()
    ..complete(SnackBarClosedReason.remove);

  /// Checks if the current platform is Android.
  bool get _isAndroid => Theme.of(context).platform == TargetPlatform.android;

  /// Checks if the [SnackBar] is currently visible.
  bool get _isSnackBarVisible => !_closedCompleter.isCompleted;

  /// Checks if the back navigation for this route is handled internally.
  ///
  /// This returns true when a widget like [Drawer] modifies the back button behavior.
  bool get _willHandlePopInternally =>
      ModalRoute.of(context)?.willHandlePopInternally ?? false;

  @override
  Widget build(BuildContext context) {
    assert(() {
      _ensureThatContextContainsScaffold();
      return true;
    }());

    // Only applies back-button functionality on Android
    if (_isAndroid) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: _handlePopInvokedWithResult,
        child: widget.child,
      );
    } else {
      return widget.child;
    }
  }

  /// Handles the logic when the pop is invoked, using [onPopInvokedWithResult].
  ///
  /// This is called after the back navigation happens. It shows the Snackbar
  /// and prevents the pop if necessary.
  void _handlePopInvokedWithResult(bool didPop, SnackBarClosedReason? result) {
    if (_isSnackBarVisible || _willHandlePopInternally) {
      SystemNavigator.pop();
      return;
    } else {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.hideCurrentSnackBar();
      _closedCompleter = scaffoldMessenger
          .showSnackBar(widget.snackBar)
          .closed
          .wrapInCompleter();
    }
  }

  /// Throws a [FlutterError] if the widget is not wrapped in a [Scaffold].
  void _ensureThatContextContainsScaffold() {
    if (Scaffold.maybeOf(context) == null) {
      throw FlutterError(
        '`DoubleBackExit` must be wrapped in a `Scaffold`.',
      );
    }
  }
}

extension<T> on Future<T> {
  /// Returns a [Completer] that tracks the completion status of this [Future].
  ///
  /// This extension allows for better control over the completion state of the [Future].
  ///
  /// **Example:**
  /// ```dart
  /// Future<int> fetchNumber() async {
  ///  await Future.delayed(Duration(seconds: 2));
  ///  return 42;
  ///  }
  ///
  /// void main() {
  /// fetchNumber().wrapInCompleter().future.then((value) {
  ///  print('Number: $value');
  ///  });
  ///  print('Fetching number...');
  ///  }
  ///  ```
  Completer<T> wrapInCompleter() {
    final completer = Completer<T>();
    then(completer.complete).catchError(completer.completeError);
    return completer;
  }
}
