part of '../import/base_import.dart';

/// Represents the base class for all states within the system.
///
/// This abstract class serves as the foundation for defining states that
/// represent various conditions of the application, such as loaded data or
/// error states. By extending this class, developers can create specific
/// states that will be used to trigger UI updates or business logic actions
/// within the application.
///
/// ### Usage
/// Subclass `BaseState` to define specific states for your application:
///
/// ```dart
/// class LoadingState extends BaseState {}
/// class SuccessState extends DataState<List<String>> {
///   SuccessState(List<String> data) : super(data);
/// }
/// ```
///
/// ### Example Workflow
/// 1. Define a `BaseState` subclass (e.g., `LoadingState`, `SuccessState`).
/// 2. Use these states in the BLoC or other state management solutions to
///    represent different states in your application.
/// 3. Based on the state, update the UI to reflect loading, success, or error
///    conditions.
///
/// ### Key Benefits
/// - Provides a clean and modular approach to manage states in your application.
/// - Facilitates state transitions that are easy to test and maintain.
/// - Ensures separation of concerns between the UI and business logic layers.
abstract class BaseState {}

/// Represents a state containing data of type [M], typically used when the
/// application successfully loads or processes data.
///
/// This class holds the data that has been successfully fetched or processed.
/// It allows the application to represent a successful state with the data
/// available for further use, such as displaying it in the UI.
///
/// ### Usage
/// Subclass `DataState` or use it directly to represent any state that contains
/// data:
///
/// ```dart
/// DataState<List<String>> state = DataState(["Item 1", "Item 2"]);
/// ```
///
/// ### Example Workflow
/// 1. When the data is successfully loaded or processed, return an instance
///    of `DataState<M>`.
/// 2. This state will hold the actual data (e.g., a list of items or an object)
///    that can be used by the UI or other components.
class DataState<M> extends BaseState {
  /// The loaded data of type [M].
  final M data;

  /// Creates a state with the provided [data].
  ///
  /// - [data]: The data that will be made available to the UI or other parts
  ///   of the application.
  ///
  /// Example usage:
  /// ```dart
  /// DataState<List<String>> dataState = DataState(["Item 1", "Item 2"]);
  /// ```
  DataState(this.data);

  /// Provides a string representation of this state for debugging purposes.
  ///
  /// This method returns a formatted string that includes the type of data
  /// and its actual value, making it useful for logging or debugging.
  ///
  /// Example output:
  /// ```dart
  /// 'DataState: { data: [Item 1, Item 2] }'
  /// ```
  @override
  String toString() => 'DataState: { data: $data }';
}

/// Represents an error state, which contains an error message and an optional
/// warning flag indicating the severity of the error.
///
/// This state is used to capture and represent error conditions, such as failed
/// network requests, validation errors, or system malfunctions. The optional
/// `isWarning` flag allows distinguishing between critical errors and non-critical
/// ones that can be treated as warnings.
///
/// ### Usage
/// Create an `ErrorState` instance when an error occurs in the application:
///
/// ```dart
/// ErrorState errorState = ErrorState(errorMessage: "Network timeout", isWarning: true);
/// ```
///
/// ### Example Workflow
/// 1. When an error occurs, instantiate an `ErrorState` to hold the error
///    message and optionally mark the error as a warning.
class ErrorState extends BaseState {
  /// The error message associated with this state, which describes the issue
  /// that occurred (e.g., "Network timeout", "Invalid input", etc.).
  final String errorMessage;

  /// A flag indicating whether the error is a warning or a critical issue.
  /// - `true`: The error is treated as a warning and does not require immediate
  ///   attention.
  /// - `false`: The error is critical and may require user intervention.
  final bool isWarning;

  /// Creates an `ErrorState` with the specified [errorMessage] and optional
  /// [isWarning] flag.
  ///
  /// - [errorMessage]: The error message to be associated with this state.
  /// - [isWarning]: An optional flag that defaults to `false`, indicating
  ///   whether the error should be treated as a warning or a critical issue.
  ///
  /// Example usage:
  /// ```dart
  /// ErrorState errorState = ErrorState(errorMessage: "Invalid login credentials");
  /// ```
  ErrorState({
    required this.errorMessage,
    this.isWarning = false,
  });

  /// Creates a generic error state with a default error message of "Something
  /// went wrong" and a critical error flag (`isWarning = false`).
  /// This constructor can be used when a specific error message is not available.
  ///
  /// Example usage:
  /// ```dart
  /// ErrorState defaultError = ErrorState.exception();
  /// ```
  ErrorState.exception()
      : errorMessage = "Something went wrong",
        isWarning = false;

  /// Provides a string representation of the [ErrorState] for debugging purposes.
  /// This method includes the error message and the `isWarning` flag, providing
  /// a detailed description of the error state for logging or debugging.
  ///
  /// Example output:
  /// ```dart
  /// 'ErrorState: { errorMessage: "Network timeout", isWarning: false }'
  /// ```
  @override
  String toString() =>
      'ErrorState: { errorMessage: "$errorMessage", isWarning: $isWarning }';
}
