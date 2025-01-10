part of '../import/base_import.dart';

/// A custom `BlocObserver` implementation to globally observe and log
/// lifecycle events of Blocs and Cubits in the application.
///
/// The `GlobalBlocListener` provides a centralized mechanism for monitoring
/// and logging events such as the creation, closure, state changes,
/// transitions, errors, and emitted events of Blocs and Cubits.
/// It aids in debugging and tracking Bloc behavior in real-time.
///
/// ### Key Features
/// - Logs detailed information for lifecycle events of Blocs and Cubits.
/// - Formats error messages and stack traces for improved readability.
/// - Provides a consistent tagging system for easier filtering in logs.
///
/// ### Example Usage
/// To use the `GlobalBlocListener`, set it as the global observer in your
/// application's `main` function:
///
/// ```dart
/// void main() {
///   Bloc.observer = GlobalBlocListener();
///   runApp(MyApp());
/// }
/// ```
class GlobalBlocListener extends BlocObserver {
  /// Generates a tag string for a specific event type and Bloc/Cubit instance.
  ///
  /// - [eventType]: The type of event (e.g., CREATE, CLOSE).
  /// - [bloc]: The Bloc or Cubit instance associated with the event.
  /// - Returns: A formatted string containing the event type and Bloc type.
  String _createTag(String eventType, BlocBase bloc) =>
      "GLOBAL $eventType: ${bloc.runtimeType}";

  /// Formats error messages with the associated stack trace for logging.
  ///
  /// - [error]: The error object thrown by the Bloc/Cubit.
  /// - [stackTrace]: The stack trace generated during the error.
  /// - Returns: A formatted string containing the error and stack trace.
  String _formatError(Object error, StackTrace stackTrace) =>
      "$error\nStackTrace:\n${stackTrace.toString()}";

  // Constants defining event tags for easier identification in logs.
  static const String CREATE_TAG = "CREATE";
  static const String CLOSE_TAG = "CLOSE";
  static const String ERROR_TAG = "ERROR";
  static const String TRANSITION_TAG = "TRANSITION";
  static const String CHANGE_TAG = "CHANGE";
  static const String EVENT_TAG = "EVENT";

  /// Called when a Bloc or Cubit is created.
  ///
  /// Logs the creation event with the Bloc/Cubit type.
  ///
  /// - [bloc]: The Bloc or Cubit instance being created.
  @override
  void onCreate(BlocBase bloc) {
    Logger.info(_createTag(CREATE_TAG, bloc));
    super.onCreate(bloc);
  }

  /// Called when a Bloc or Cubit is closed.
  ///
  /// Logs the closure event with the Bloc/Cubit type.
  ///
  /// - [bloc]: The Bloc or Cubit instance being closed.
  @override
  void onClose(BlocBase bloc) {
    Logger.info(_createTag(CLOSE_TAG, bloc));
    super.onClose(bloc);
  }

  /// Called when an error occurs in a Bloc or Cubit.
  ///
  /// Logs the error with its stack trace for debugging purposes.
  ///
  /// - [bloc]: The Bloc or Cubit instance where the error occurred.
  /// - [error]: The error object thrown by the Bloc/Cubit.
  /// - [stackTrace]: The stack trace associated with the error.
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    Logger.error(
      "${_createTag(ERROR_TAG, bloc)} | ${_formatError(error, stackTrace)}",
    );
    super.onError(bloc, error, stackTrace);
  }

  /// Called during a state transition in a Bloc.
  ///
  /// Logs the transition details, including the current state, event,
  /// and next state.
  ///
  /// - [bloc]: The Bloc instance where the transition occurred.
  /// - [transition]: The transition object containing state change details.
  @override
  void onTransition(Bloc bloc, Transition transition) {
    Logger.debug("${_createTag(TRANSITION_TAG, bloc)} | $transition");
    super.onTransition(bloc, transition);
  }

  /// Called when a state change occurs in a Bloc or Cubit.
  ///
  /// Logs the details of the state change, including the current and
  /// next states.
  ///
  /// - [bloc]: The Bloc or Cubit instance where the change occurred.
  /// - [change]: The change object containing details of the state update.
  @override
  void onChange(BlocBase bloc, Change change) {
    Logger.debug("${_createTag(CHANGE_TAG, bloc)} | $change");
    super.onChange(bloc, change);
  }

  /// Called when an event is added to a Bloc.
  ///
  /// Logs the event details for monitoring Bloc activity.
  ///
  /// - [bloc]: The Bloc instance where the event was added.
  /// - [event]: The event object added to the Bloc.
  @override
  void onEvent(Bloc bloc, Object? event) {
    Logger.info("${_createTag(EVENT_TAG, bloc)} | $event");
    super.onEvent(bloc, event);
  }
}
