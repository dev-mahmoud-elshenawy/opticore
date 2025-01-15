part of '../util_import.dart';

/// A helper class for handling lifecycle events.
///
/// This class provides a convenient way to listen for app lifecycle events, such as `resumed` and `suspending`.
/// It can be used to trigger specific actions when the app is resumed or suspended.
///
/// **Usage Example:**
/// ```dart
/// LifecycleEventHelper(
///  resumeCallBack: () async {
///  // Perform actions when the app is resumed
///  },
///  suspendingCallBack: () async {
///  // Perform actions when the app is suspended
///  },
///  );
///  ```
///
/// **Note:** This class must be used in a widget that extends `StatefulWidget` and implements `WidgetsBindingObserver`.
class LifecycleEventHelper extends WidgetsBindingObserver {
  final AsyncCallback? resumeCallBack;
  final AsyncCallback? suspendingCallBack;

  LifecycleEventHelper({
    this.resumeCallBack,
    this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) {
          await resumeCallBack!();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        if (suspendingCallBack != null) {
          await suspendingCallBack!();
        }
        break;
    }
  }
}
