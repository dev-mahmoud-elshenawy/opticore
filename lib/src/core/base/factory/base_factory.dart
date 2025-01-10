part of '../import/base_import.dart';

/// Abstract class for a state factory that determines and provides a state
/// based on the input data.
///
/// This class defines a generic method `getState` that accepts data of type `M`
/// and returns a corresponding state. It is designed to allow dynamic and
/// flexible state generation in the BLoC architecture, promoting a clear
/// separation of logic for state creation.
///
/// ### Key Responsibilities
/// - Define the contract for generating states.
/// - Serve as the foundation for implementing custom state factories.
///
/// ### Example Usage
/// ```dart
/// class CustomFactory extends BaseFactory {
///   @override
///   BaseState getState<M>(M data) {
///     if (data is SomeModel) {
///       return CustomState(data);
///     }
///     return DefaultState();
///   }
/// }
/// ```
abstract class BaseFactory {
  /// Returns a state based on the provided data of type `M`.
  ///
  /// If no valid state can be determined, the implementation should return a
  /// fallback state, such as `DefaultState`.
  ///
  /// - [data]: The input data used to determine the state.
  /// - Returns: An instance of `BaseState` representing the determined state.
  BaseState getState<M>(M data);
}

/// Represents the default fallback state used when no specific state can
/// be determined.
///
/// This class provides a safe, neutral state that can be used as a fallback
/// in scenarios where the input data does not match any specific state logic.
///
/// ### Example
/// ```dart
/// final state = DefaultState();
/// print(state.description); // Outputs: DefaultState: Used as fallback.
/// ```
class DefaultState extends BaseState {
  /// A human-readable description of the `DefaultState`.
  String get description => 'DefaultState: Used as fallback.';
}

/// A concrete implementation of [BaseFactory] that provides a default state
/// when no specific state can be determined.
///
/// The `DefaultFactory` serves as a basic implementation of the [BaseFactory],
/// offering a straightforward mechanism to generate states. If the provided
/// data is `null`, it returns a [DefaultState]. Otherwise, it assumes the
/// presence of a valid `data` state.
///
/// ### Example
/// ```dart
/// final factory = DefaultFactory();
/// final state = factory.getState(null); // Returns DefaultState.
/// ```
class DefaultFactory extends BaseFactory {
  /// Returns a [BaseState] based on the provided [data].
  ///
  /// - If [data] is `null`, returns a [DefaultState].
  /// - Otherwise, assumes the input represents a valid data state and wraps
  ///   it in a [DataState].
  ///
  /// - [data]: The input data used to determine the state.
  /// - Returns: An instance of [BaseState], either [DefaultState] or a data-specific state.
  @override
  BaseState getState<M>(M? data) {
    if (data == null) {
      return DefaultState();
    } else {
      // Returning a data-specific state (assuming `DataState` exists and `data` is valid).
      return DataState(data);
    }
  }
}
