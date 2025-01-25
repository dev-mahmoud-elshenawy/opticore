part of '../config_import.dart';

/// Configuration class for handling unauthenticated state.
///
/// This class provides a way to configure the logic and route to handle unauthenticated state.
/// It allows setting custom logic and route to navigate to when the user is unauthenticated.
///
/// **Key Features:**
/// - Customize the logic for handling unauthenticated state.
/// - Set a custom route to navigate to when the user is unauthenticated.
/// - Reset the configuration to its default values.
/// - Access the global configuration values for unauthenticated state handling.
class UnAuthenticatedConfig extends Equatable {
  // Private static field for the global unauthenticated logic
  /// Default global function to handle unauthenticated logic.
  static Future<void> Function()? _onUnauthenticated;

  // Instance field for optional custom unauthenticated logic
  /// Custom function to handle unauthenticated logic for specific instances.
  final Future<void> Function()? customOnUnauthenticated;

  // Private constructor to ensure controlled instantiation
  /// Initializes a `UnAuthenticatedConfig` instance with optional custom logic.
  const UnAuthenticatedConfig._({this.customOnUnauthenticated});

  // Static method to instantiate or override global configuration
  /// Allows setting custom global unauthenticated logic.
  ///
  /// **Example:**
  /// ```dart
  /// UnAuthenticatedConfig.instantiate(
  ///   UnAuthenticatedConfig(
  ///     customOnUnauthenticated: () async => print('Custom unauthenticated logic'),
  ///   ),
  /// );
  /// ```
  static Future<void> instantiate(UnAuthenticatedConfig customConfig) async {
    _onUnauthenticated =
        customConfig.customOnUnauthenticated ?? _onUnauthenticated;
  }

  // Static method to reset the global configuration to its default state
  /// Resets the global configuration for unauthenticated logic.
  ///
  /// **Example:**
  /// ```dart
  /// UnAuthenticatedConfig.resetToDefaults();
  /// ```
  static void resetToDefaults() {
    _onUnauthenticated = null;
  }

  // Factory constructor for creating a new instance with custom values
  /// Factory constructor to create an instance of `UnAuthenticatedConfig` with optional custom logic.
  ///
  /// **Parameters:**
  /// - `customOnUnauthenticated`: Custom function for handling unauthenticated logic.
  factory UnAuthenticatedConfig({
    Future<void> Function()? customOnUnauthenticated,
  }) {
    return UnAuthenticatedConfig._(
      customOnUnauthenticated: customOnUnauthenticated,
    );
  }

  // Static method to link with the `handleUnauthenticated` function of another class
  /// Links the `handleUnauthenticated` function from an external class as the fallback global logic.
  ///
  /// **Example:**
  /// ```dart
  /// UnAuthenticatedConfig.linkWithHandler(SomeClass.handleUnauthenticated);
  /// ```
  static void linkWithHandler(void Function() handleUnauthenticated) {
    _onUnauthenticated = () async {
      handleUnauthenticated();
    };
  }

  // Public getter to access the global unauthenticated logic
  /// Getter to access the global unauthenticated logic.
  /// This allows external classes to access the global logic for handling unauthenticated state.
  static Future<void> Function()? get onUnauthenticated => _onUnauthenticated;

  @override
  List<Object?> get props => [
        customOnUnauthenticated,
      ];
}
