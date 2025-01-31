part of '../extensions_import.dart';

extension LetExtension<T> on T {
  /// Executes the provided [block] on the current instance (`this`) if it is not `null`.
  ///
  /// If `this` is `null`, the function immediately returns `null` without executing the [block].
  ///
  /// - [block]: A function that takes the current value (`this`) as a parameter and returns a result of type `R`.
  ///
  /// Returns:
  /// - The result of the [block] if `this` is non-null, or `null` if `this` is null.
  ///
  /// Example:
  /// ```dart
  /// String? name = 'Mahmoud';
  /// name.let((it) => 'Hello, $it!'); // Output: 'Hello, Mahmoud!'
  /// ```
  R? let<R>(R Function(T it) block) {
    if (this != null) {
      return block(this);
    }
    return null;
  }

  /// Executes the provided [block] on the current instance (`this`) if it is not `null`.
  ///
  /// If `this` is `null`, the function immediately returns the result of the [orElse] function without executing the [block].
  /// This is useful for providing a default value or fallback behavior when the current value is `null`.
  ///
  /// - [block]: A function that takes the current value (`this`) as a parameter and returns a result of type `R`.
  /// - [orElse]: A function that returns a default value or fallback result of type `R`.
  ///
  /// Returns:
  /// - The result of the [block] if `this` is non-null, or the result of the [orElse] function if `this` is null.
  ///
  /// Example:
  /// ```dart
  /// String? name = null;
  /// name.letOrElse((it) => 'Hello, $it!', () => 'Hello, Guest!'); // Output: 'Hello, Guest!'
  /// ```
  R letOrElse<R>(R Function(T it) block, R Function() orElse) {
    return this != null ? block(this) : orElse();
  }

  /// Executes the provided [block] on the current instance (`this`) if it is not `null`.
  ///
  /// If `this` is `null`, the function immediately returns `null` without executing the [block].
  /// This is useful for performing side effects or operations that do not require a return value.
  ///
  /// - [block]: A function that takes the current value (`this`) as a parameter and returns `void`.
  ///
  /// Returns:
  /// - The current instance (`this`) if it is non-null, or `null` if it is null.
  ///
  /// Example:
  /// ```dart
  /// String? name = 'Mahmoud';
  /// name.also((it) => print('Hello, $it!')); // Output: 'Hello, Mahmoud!'
  /// ```
  T also(void Function(T it) block) {
    if (this != null) block(this);
    return this;
  }

  /// Returns the current instance (`this`) if it satisfies the provided [predicate], otherwise returns `null`.
  /// This is useful for filtering out values that do not meet a certain condition.
  ///
  /// - [predicate]: A function that takes the current value (`this`) as a parameter and returns a `bool`.
  ///
  /// Returns:
  /// - The current instance (`this`) if it satisfies the [predicate], or `null` if it does not.
  ///
  /// Example:
  /// ```dart
  /// String? name = 'Mahmoud';
  /// name.takeIf((it) => it.length > 5); // Output: 'Mahmoud'
  /// ```
  T? takeIf(bool Function(T it) predicate) {
    return (this != null && predicate(this)) ? this : null;
  }
}
