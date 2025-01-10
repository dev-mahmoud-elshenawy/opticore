part of '../import/base_import.dart';

/// Base class for states that do not trigger UI rendering.
///
/// This abstract class serves as the foundation for states that are primarily
/// used for managing internal business logic and data processing, where
/// the state does not directly affect the UI. It is typically used for
/// handling states related to background tasks, loading, or errors that
/// are not immediately visible in the UI.
///
/// ### Usage
/// Extend `NonRenderState` to define states that are intended for
/// non-UI rendering purposes. For example:
///
/// ```dart
/// class CustomErrorState extends NonRenderState {
///   final String errorMessage;
///   CustomErrorState(this.errorMessage);
/// }
/// ```
///
/// This allows for handling business logic states without involving UI updates.
class NonRenderState extends BaseState {}

/// State representing an ongoing loading process.
///
/// This state indicates that a background process or task is currently
/// in progress. It does not trigger UI rendering directly but can be used
/// to manage internal logic like showing a loading spinner or tracking
/// the state of the loading process.
///
/// ### Usage
/// This state can be used to signify when a task is loading in the background:
///
/// ```dart
/// LoadingStateNonRender();
/// ```
class LoadingStateNonRender extends NonRenderState {}

/// State representing the end of a loading process.
///
/// This state signifies that a background task or loading process has
/// finished. It can be used to handle transitions or trigger events after
/// the loading process has completed, without affecting the UI directly.
///
/// ### Usage
/// This state can be used to signal the end of a loading process:
///
/// ```dart
/// EndLoadingStateNonRender();
/// ```
class EndLoadingStateNonRender extends NonRenderState {}

/// State representing an error or warning scenario.
///
/// This state is used to handle error or warning conditions that do not
/// require immediate UI rendering but are important for internal business
/// logic. It allows developers to classify and manage errors without
/// directly affecting the UI.
///
/// ### Properties
/// - [type]: The type of error, represented by [ApiResponseType].
/// - [errorMessage]: The detailed error message describing the issue.
///
/// ### Usage
/// You can use this class to represent an error or warning condition:
///
/// ```dart
/// ErrorStateNonRender(type: ApiResponseType.RENDER, errorMessage: 'An error occurred');
/// ```
///
/// For a default error state:
///
/// ```dart
/// ErrorStateNonRender.exception();
/// ```
class ErrorStateNonRender extends NonRenderState {
  /// The type of error, represented by [ApiResponseType].
  final ApiResponseType type;

  /// Detailed error message to describe the issue.
  final String errorMessage;

  /// Creates an error state with the given [type] and [errorMessage].
  ///
  /// This constructor is used when you have specific error information
  /// to pass, such as an error type and a message describing the error.
  ErrorStateNonRender({
    required this.type,
    required this.errorMessage,
  });

  /// Creates a default error state with a standard error message and exception type.
  ///
  /// This constructor is used when a generic error state needs to be created
  /// without specific error details. It defaults to a general error message
  /// and an undefined error type.
  ErrorStateNonRender.exception()
      : type = ApiResponseType.none,
        errorMessage = 'Sorry, an error occurred';

  /// Provides a string representation of the error state for debugging purposes.
  ///
  /// The string includes the [type] of error and the [errorMessage] for easy
  /// debugging and understanding of the error state.
  @override
  String toString() {
    return 'ErrorStateNonRender: { '
        'type: $type, '
        'errorMessage: $errorMessage }';
  }
}