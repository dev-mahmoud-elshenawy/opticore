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
}
