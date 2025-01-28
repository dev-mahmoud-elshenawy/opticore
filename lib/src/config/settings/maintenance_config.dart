part of '../config_import.dart';

/// `MaintenanceConfig` is a configuration class responsible for managing global settings
/// related to the maintenance mode of the application. This class allows customization of the
/// messages, button labels, toast notifications, and animations shown to the user when the app is
/// undergoing maintenance. It provides flexibility by supporting both default and custom values.
///
/// **Key Features:**
/// - Customize the maintenance mode message shown to users.
/// - Modify the button label for retrying the operation during maintenance.
/// - Customize the retry toast message shown to users.
/// - Option to change the animation displayed during maintenance periods.
/// - Easily instantiate with custom configuration values or use the default settings.
///
/// **Constructor Parameters:**
/// - `customMessage`: A custom message displayed to users when the app is in maintenance mode.
/// - `customMessageButton`: A custom label for the button allowing users to retry during maintenance.
/// - `customMessageRetryToast`: A custom toast message displayed during retry attempts after maintenance.
/// - `customAnim`: A custom animation asset displayed during maintenance mode. By default, a predefined animation is used.
///
/// **Usage Example:**
/// ```dart
/// // Create a custom MaintenanceConfig instance
/// var customConfig = MaintenanceConfig(
///   customMessage: 'The app is temporarily unavailable, please try again later.',
///   customMessageButton: 'Try Again',
///   customMessageRetryToast: 'Retrying...',
/// );
///
/// // Initialize global settings with custom values
/// MaintenanceConfig.instantiate(customConfig);
///
/// // Access the current global configuration
/// print(MaintenanceConfig.message); // Displays the custom maintenance message
/// ```
class MaintenanceConfig extends Equatable {
  // Private static fields for global default configuration values
  /// The default message displayed to users when the app is in maintenance mode.
  /// This message can be customized via the `instantiate` method.
  static String _message =
      'Maintenance is in progress. Please try again later.';

  /// The default button text displayed on the retry button during maintenance mode.
  /// This label can be overridden by custom values.
  static String _messageButton = 'Retry';

  /// The default toast message shown when a retry attempt is in progress.
  /// This message can be customized by calling the `instantiate` method.
  static String _messageRetryToast = 'Wait for retry';

  /// The default animation asset shown during maintenance mode.
  /// Custom animation can be set via the `instantiate` method.
  static String _anim = CoreAssets.maintenanceAnim;

  // Instance fields for optional custom configuration values
  /// A custom message that is shown when the app is in maintenance mode.
  final String? customMessage;

  /// A custom label for the retry button during maintenance mode.
  final String? customMessageButton;

  /// A custom toast message shown when a retry attempt is in progress.
  final String? customMessageRetryToast;

  /// A custom animation asset shown during maintenance mode.
  final String? customAnim;

  // Private constructor to prevent direct instantiation
  /// The private constructor is used by the factory method to create instances
  /// of `MaintenanceConfig` with optional custom values.
  const MaintenanceConfig._({
    this.customMessage,
    this.customMessageButton,
    this.customMessageRetryToast,
    this.customAnim,
  });

  // Static method to initialize the global configuration with custom values
  /// This method initializes the global maintenance configuration with values from
  /// the provided [customConfig] instance. If a custom value is `null`, the default value will be used.
  ///
  /// **Parameters:**
  /// - `customConfig`: An instance of `MaintenanceConfig` containing the custom settings.
  ///
  /// **Example:**
  /// ```dart
  /// var customConfig = MaintenanceConfig(
  ///   customMessage: 'Maintenance in progress, please wait...',
  /// );
  /// MaintenanceConfig.instantiate(customConfig);
  /// ```
  static Future<void> instantiate(MaintenanceConfig customConfig) async {
    _message = customConfig.customMessage ?? _message;
    _messageButton = customConfig.customMessageButton ?? _messageButton;
    _messageRetryToast =
        customConfig.customMessageRetryToast ?? _messageRetryToast;
    _anim = customConfig.customAnim ?? _anim;
  }

  // Static method to reset the configuration to default values
  /// This method resets all maintenance-related configuration values to their default state,
  /// reverting any customizations made via the `instantiate` method.
  ///
  /// **Usage**: This method is useful for clearing any custom configurations and
  /// restoring the default maintenance settings.
  static void resetToDefaults() {
    _message = 'Maintenance is in progress. Please try again later.';
    _messageButton = 'Retry';
    _messageRetryToast = 'Wait for retry';
    _anim = CoreAssets.maintenanceAnim;
  }

  // Factory constructor to create an instance with custom values
  /// A factory constructor that creates a `MaintenanceConfig` instance with the option
  /// to customize the maintenance message, button label, retry toast, and animation.
  ///
  /// **Parameters:**
  /// - `customMessage`: Custom message to show during maintenance.
  /// - `customMessageButton`: Custom label for the retry button.
  /// - `customMessageRetryToast`: Custom message shown during retry attempts.
  /// - `customAnim`: Custom animation asset shown during maintenance.
  ///
  /// **Example:**
  /// ```dart
  /// var config = MaintenanceConfig(
  ///   customMessage: 'App is temporarily down for maintenance.',
  /// );
  /// ```
  factory MaintenanceConfig({
    String? customMessage,
    String? customMessageButton,
    String? customMessageRetryToast,
    String? customAnim,
  }) {
    return MaintenanceConfig._(
      customMessage: customMessage,
      customMessageButton: customMessageButton,
      customMessageRetryToast: customMessageRetryToast,
      customAnim: customAnim,
    );
  }

  // Public getters to access private static fields
  /// A getter that returns the current maintenance message.
  static String get message => _message;

  /// A getter that returns the text for the retry button during maintenance mode.
  static String get messageButton => _messageButton;

  /// A getter that returns the retry toast message during maintenance mode.
  static String get messageRetryToast => _messageRetryToast;

  /// A getter that returns the animation asset used during maintenance.
  static String get anim => _anim;

  // Override props to include the instance fields you want to compare
  /// This method is used for equality checks in tests or comparison operations.
  /// It ensures that the state of the configuration instance is considered during comparisons.
  @override
  List<Object?> get props => [
        customMessage,
        customMessageButton,
        customMessageRetryToast,
        customAnim,
      ];
}
