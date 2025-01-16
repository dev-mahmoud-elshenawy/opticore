part of '../config_import.dart';

/// `NoInternetConfig` is a configuration class designed specifically to manage
/// settings related to displaying the "No Internet" screen in an application.
/// This class provides customizable options for the message, button text,
/// and animation used when the user is offline. It also allows you to reset
/// the configuration to its default values and access the current settings
/// globally throughout the app.
///
/// **Key Features:**
/// - Customize the no-internet message, button text, and animation to match the app's design and user experience.
/// - Update these settings globally for consistent behavior across the app.
/// - Reset the configuration to default values, ensuring uniformity across sessions.
/// - Provides getters for easy access to the current configuration values at any time.
///
/// **Usage Example:**
/// ```dart
/// // Instantiate with default values
/// NoInternetConfig config = NoInternetConfig();
/// // Customize the configuration
/// NoInternetConfig.instantiate(
///   NoInternetConfig(customMessage: 'No internet connection!', customMessageButton: 'Retry'),
/// );
/// // Access the current configuration
/// print(NoInternetConfig.message); // Outputs: 'No internet connection!'
/// ```
class NoInternetConfig extends Equatable {
  // Private static fields to store the global default configuration values
  /// The default message displayed when the user has no internet connection.
  /// This is shown on the "No Internet" screen.
  static String _message = 'No Internet, Please Check Your Internet Connection';

  /// The default text displayed on the button in the "No Internet" screen.
  /// This button is used to trigger an action like retrying the connection.
  static String _messageButton = 'Refresh';

  /// The default animation asset shown when the user is offline.
  /// This animation is displayed on the "No Internet" screen.
  static String _anim = CoreAssets.noInternetAnim;

  // Instance fields for optional custom configuration values
  /// The custom message to be displayed on the "No Internet" screen.
  /// If not provided, the default message will be used.
  final String? customMessage;

  /// The custom text for the button on the "No Internet" screen.
  /// If not provided, the default button text will be used.
  final String? customMessageButton;

  /// The custom animation asset for the "No Internet" screen.
  /// If not provided, the default animation will be used.
  final String? customAnim;

  // Private constructor to ensure the class is instantiated only through the factory method
  /// Private constructor to initialize a `NoInternetConfig` instance with optional custom values.
  const NoInternetConfig._({
    this.customMessage,
    this.customMessageButton,
    this.customAnim,
  });

  // Static method to update the global configuration with custom values
  /// This method allows setting custom values for the "No Internet" configuration globally.
  /// Any of the configuration values (message, button text, or animation) can be customized.
  ///
  /// **Parameters:**
  /// - `customConfig`: An instance of `NoInternetConfig` containing custom values.
  ///
  /// **Example:**
  /// ```dart
  /// NoInternetConfig.instantiate(
  ///   NoInternetConfig(customMessage: 'Unable to connect', customMessageButton: 'Try Again'),
  /// );
  /// ```
  static Future<void> instantiate(NoInternetConfig customConfig) async {
    _message = customConfig.customMessage ?? _message;
    _messageButton = customConfig.customMessageButton ?? _messageButton;
    _anim = customConfig.customAnim ?? _anim;
  }

  // Static method to reset the configuration to the default state
  /// Resets the configuration to its default values, which include the default message,
  /// button text, and animation asset.
  ///
  /// **Example:**
  /// ```dart
  /// NoInternetConfig.resetToDefaults();
  /// ```
  static void resetToDefaults() {
    _message = 'No Internet, Please Check Your Internet Connection';
    _messageButton = 'Refresh';
    _anim = CoreAssets.noInternetAnim;
  }

  // Factory constructor for creating a new `NoInternetConfig` instance with custom values
  /// A factory constructor to create an instance of `NoInternetConfig` with optional custom values.
  ///
  /// **Parameters:**
  /// - `customMessage`: The custom message displayed on the "No Internet" screen.
  /// - `customMessageButton`: The custom button text on the "No Internet" screen.
  /// - `customAnim`: The custom animation asset for the "No Internet" screen.
  factory NoInternetConfig({
    String? customMessage,
    String? customMessageButton,
    String? customAnim,
  }) {
    return NoInternetConfig._(
      customMessage: customMessage,
      customMessageButton: customMessageButton,
      customAnim: customAnim,
    );
  }

  // Public getter to access the current message value
  /// Getter for the message displayed on the "No Internet" screen.
  /// Returns the currently configured message, or the default message if no custom value is set.
  static String get message => _message;

  // Public getter to access the current button text value
  /// Getter for the button text on the "No Internet" screen.
  /// Returns the currently configured button text, or the default button text if no custom value is set.
  static String get messageButton => _messageButton;

  // Public getter to access the current animation asset value
  /// Getter for the animation asset on the "No Internet" screen.
  /// Returns the currently configured animation asset, or the default animation asset if no custom value is set.
  static String get anim => _anim;

  // Override Equatable's props to enable comparison based on instance fields
  @override
  List<Object?> get props => [
        customMessage,
        customMessageButton,
        customAnim,
      ];
}
