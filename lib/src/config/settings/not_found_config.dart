part of '../config_import.dart';

/// `NotFoundConfig` is a configuration class that manages settings for
/// the "Page Not Found" screen in the application. It provides a way to
/// customize the animation displayed when a user navigates to a non-existent
/// page, ensuring that the user experience is consistent and adaptable.
///
/// **Constructor Parameters:**
/// - [customAnim]: A custom animation asset to be displayed when the "Page Not Found"
///   screen is shown. If no custom animation is provided, a default animation will be used.
///
/// **Key Features:**
/// - Customize the animation shown on the "Page Not Found" screen, allowing for a tailored
///   user experience when a page cannot be found.
/// - Update the global configuration with custom animation settings, affecting the entire app.
/// - Reset the configuration to the default animation if needed, restoring consistency across sessions.
///
/// **Methods:**
/// - [instantiate]: Sets the global configuration to custom values. This method can be used
///   to globally update the animation displayed on the "Page Not Found" screen.
/// - [resetToDefaults]: Resets the configuration to the default animation, ensuring the
///   original animation is used across the app.
///
/// **Usage Example:**
/// ```dart
/// // Instantiate with default values
/// NotFoundConfig config = NotFoundConfig();
/// // Customize the configuration with a new animation
/// NotFoundConfig.instantiate(
///   NotFoundConfig(customAnim: 'assets/animations/custom_not_found.json'),
/// );
/// // Access the current animation configuration
/// print(NotFoundConfig.anim); // Outputs: 'assets/animations/custom_not_found.json'
/// ```
class NotFoundConfig extends Equatable {
  // Private static field for storing the global default configuration value
  /// The default animation asset used for the "Page Not Found" screen.
  /// This is the animation that will be shown when a user navigates to a page that doesn't exist.
  static String _anim = CoreAssets.PAGE_NOT_FOUND_ANIM;

  // Instance field for holding a custom animation (if provided)
  /// A custom animation asset to display on the "Page Not Found" screen.
  /// If no custom animation is provided, the default animation will be used.
  final String? customAnim;

  // Private constructor to ensure instances are created only through the factory method
  /// Private constructor used by the factory method to create instances of `NotFoundConfig`.
  const NotFoundConfig._({this.customAnim});

  // Static method to set the global configuration with custom values
  /// This method allows you to initialize the global "Page Not Found" configuration
  /// with custom values. If a custom value is not provided, the default value will be used.
  ///
  /// **Parameters:**
  /// - `customConfig`: An instance of `NotFoundConfig` containing the custom animation value.
  ///
  /// **Example:**
  /// ```dart
  /// NotFoundConfig.instantiate(
  ///   NotFoundConfig(customAnim: 'assets/animations/custom_not_found.json'),
  /// );
  /// ```
  static void instantiate(NotFoundConfig customConfig) {
    _anim = customConfig.customAnim ?? _anim;
  }

  // Method to reset the configuration to default values
  /// Resets the animation to the default "Page Not Found" animation, ensuring consistency
  /// across the app. This method can be used if you want to revert any custom changes made.
  ///
  /// **Example:**
  /// ```dart
  /// NotFoundConfig.resetToDefaults();
  /// ```
  static void resetToDefaults() {
    _anim = CoreAssets.PAGE_NOT_FOUND_ANIM;
  }

  // Factory constructor to create an instance with optional custom values
  /// A factory constructor that creates an instance of `NotFoundConfig` with custom animation settings.
  /// This constructor allows for easy customization of the animation to be used on the "Page Not Found" screen.
  ///
  /// **Parameters:**
  /// - `customAnim`: The custom animation asset to display on the "Page Not Found" screen.
  ///
  /// **Example:**
  /// ```dart
  /// NotFoundConfig(configAnim: 'assets/animations/my_custom_animation.json');
  /// ```
  factory NotFoundConfig({
    String? customAnim,
  }) {
    return NotFoundConfig._(customAnim: customAnim);
  }

  // Public getter to retrieve the current animation configuration
  /// Getter that provides access to the current animation asset used for the "Page Not Found" screen.
  /// This will return either the custom animation (if set) or the default animation.
  ///
  /// **Example:**
  /// ```dart
  /// String currentAnim = NotFoundConfig.anim;
  /// ```
  static String get anim => _anim;

  // Override Equatable's props to enable value-based comparison of instances
  @override
  List<Object?> get props => [customAnim];
}