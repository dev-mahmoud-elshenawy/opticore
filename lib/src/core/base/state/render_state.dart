part of '../import/base_import.dart';

/// Base class for states that trigger UI rendering.
///
/// This abstract class serves as the foundation for states that are directly
/// responsible for updating or rendering the UI. These states typically contain
/// data or conditions that trigger UI updates or transitions, such as loading
/// indicators, data rendering, or error handling.
///
/// ### Usage
/// Extend `RenderState` to define UI-related states that require rendering,
/// such as data being loaded, animations playing, or errors being displayed:
///
/// ```dart
/// class MyCustomRenderState extends RenderState {
///   final String message;
///   MyCustomRenderState(this.message);
/// }
/// ```
///
/// This allows for clean separation of rendering-related states from those
/// that do not involve UI updates.
abstract class RenderState extends BaseState {}

/// State representing a successful data load with generic data.
///
/// This state holds the data that has been successfully loaded and is
/// ready to be rendered in the UI. The data is passed as a generic type [F],
/// allowing flexibility to handle different data types.
///
/// ### Properties
/// - [data]: The loaded data to be rendered in the UI.
///
/// ### Usage
/// Use this state to represent the successful loading of any type of data:
///
/// ```dart
/// RenderDataState<String>('Hello, world!');
/// ```
///
/// This state is useful when loading content that will be displayed to the user.
class RenderDataState<F> extends RenderState {
  /// The loaded data to be rendered.
  final F data;

  /// Creates a state with the provided data.
  RenderDataState(this.data);
}

/// State representing an animation being loaded or played.
///
/// This state is used to represent the process of an animation being
/// loaded or played in the UI. It does not contain any data but acts as
/// an indicator that an animation is in progress.
///
/// ### Usage
/// This state is used when the UI needs to indicate that an animation
/// is being loaded or played:
///
/// ```dart
/// LoadAnimationState();
/// ```
class LoadAnimationState extends RenderState {}

/// State representing an ongoing loading process in the UI.
///
/// This state is used to represent a loading process, often accompanied
/// by a loading spinner or progress bar. It indicates that a process is
/// ongoing and the user should wait for the action to complete.
///
/// ### Usage
/// Use this state when the UI is in a loading state:
///
/// ```dart
/// LoadingStateRender();
/// ```
class LoadingStateRender extends RenderState {}

/// State representing the initial or uninitialized state of the UI.
///
/// This state indicates that the UI is in its initial state and has not
/// yet been set up with any data or interactions. It is typically used
/// when the app or screen is first loaded.
///
/// ### Usage
/// Use this state when the UI is in its initial or default state:
///
/// ```dart
/// InitialState();
/// ```
class InitialState extends RenderState {}

/// State representing an error or warning in the rendering process.
///
/// This state is used when an error or warning occurs during the rendering
/// process. It can contain a message describing the error, along with flags
/// to indicate if the error is a warning, unauthorized, or some other type.
///
/// ### Properties
/// - [errorMessage]: A message describing the error or issue that occurred.
/// - [isWarning]: A flag to indicate if the error is a warning rather than
///   a critical issue (defaults to `false`).
/// - [isUnauthorized]: A flag to indicate if the error is due to unauthorized
///   access (defaults to `false`).
///
/// ### Usage
/// This state is used when an error or warning occurs that affects the UI:
///
/// ```dart
/// ErrorStateRender(
///   errorMessage: 'Unable to load data',
///   isWarning: true,
///   isUnauthorized: false,
/// );
/// ```
///
/// For a default error:
///
/// ```dart
/// ErrorStateRender.exception();
/// ```
class ErrorStateRender extends RenderState {
  /// Optional error message describing the issue.
  final String? errorMessage;

  /// Indicates whether the error is a warning rather than a critical error.
  final bool? isWarning;

  /// Indicates whether the error is due to unauthorized access.
  final bool? isUnauthorized;

  /// Creates an error state with the provided [errorMessage], [isWarning],
  /// and [isUnauthorized] flags.
  ///
  /// This constructor is used when specific error details are available.
  ErrorStateRender({
    required this.errorMessage,
    this.isWarning = false,
    this.isUnauthorized = false,
  });

  /// Creates a default error state with a generic error message and flags set to `false`.
  ///
  /// This constructor is used for a generic error state without specific details.
  ErrorStateRender.exception()
      : errorMessage = "Something went wrong",
        isWarning = false,
        isUnauthorized = false;

  /// Provides a string representation for debugging.
  ///
  /// This method returns a string that includes the [errorMessage], [isWarning],
  /// and [isUnauthorized] flags, making it easier to debug error states.
  @override
  String toString() {
    return 'ErrorStateRender: { '
        'errorMessage: $errorMessage, '
        'isWarning: $isWarning, '
        'isUnauthorized: $isUnauthorized }';
  }
}
