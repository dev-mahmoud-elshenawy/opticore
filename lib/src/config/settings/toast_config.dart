part of '../config_import.dart';

/// [ToastConfig] is a configuration class for customizing the colors used
/// in toast notifications displayed via [ToastHelper].
///
/// It follows the same singleton pattern as other OptiCore configs
/// (e.g., [NoInternetConfig], [MaintenanceConfig]), allowing global runtime
/// overrides without restarting the app.
///
/// **Usage Example:**
/// ```dart
/// ToastConfig.instantiate(
///   ToastConfig(
///     successColor: Colors.green,
///     errorColor: Colors.red,
///     infoColor: Colors.blue,
///     warningColor: Colors.orange,
///     iconColor: Colors.white,
///     textColor: Colors.white,
///   ),
/// );
/// ```
class ToastConfig extends Equatable {
  // ---------------------------------------------------------------------------
  // Private static state (global defaults)
  // ---------------------------------------------------------------------------

  static Color _successColor = CoreColors.success;
  static Color _errorColor = CoreColors.error;
  static Color _infoColor = CoreColors.info;
  static Color _warningColor = CoreColors.warning;
  static Color _iconColor = CoreColors.backgroundColor;
  static Color _textColor = CoreColors.backgroundColor;

  // ---------------------------------------------------------------------------
  // Constructor parameters (used only in [instantiate])
  // ---------------------------------------------------------------------------

  final Color? successColor;
  final Color? errorColor;
  final Color? infoColor;
  final Color? warningColor;

  /// Color applied to the icon inside every toast.
  final Color? iconColor;

  /// Color applied to the message text inside every toast.
  final Color? textColor;

  const ToastConfig({
    this.successColor,
    this.errorColor,
    this.infoColor,
    this.warningColor,
    this.iconColor,
    this.textColor,
  });

  // ---------------------------------------------------------------------------
  // Global instantiation
  // ---------------------------------------------------------------------------

  /// Applies [config] values as the new global toast color defaults.
  ///
  /// Only non-null fields override the current values.
  static void instantiate(ToastConfig config) {
    if (config.successColor != null) _successColor = config.successColor!;
    if (config.errorColor != null) _errorColor = config.errorColor!;
    if (config.infoColor != null) _infoColor = config.infoColor!;
    if (config.warningColor != null) _warningColor = config.warningColor!;
    if (config.iconColor != null) _iconColor = config.iconColor!;
    if (config.textColor != null) _textColor = config.textColor!;
  }

  /// Resets all toast colors back to their original defaults.
  static void reset() {
    _successColor = CoreColors.success;
    _errorColor = CoreColors.error;
    _infoColor = CoreColors.info;
    _warningColor = CoreColors.warning;
    _iconColor = CoreColors.backgroundColor;
    _textColor = CoreColors.backgroundColor;
  }

  // ---------------------------------------------------------------------------
  // Global getters
  // ---------------------------------------------------------------------------

  static Color get successColorValue => _successColor;
  static Color get errorColorValue => _errorColor;
  static Color get infoColorValue => _infoColor;
  static Color get warningColorValue => _warningColor;
  static Color get iconColorValue => _iconColor;
  static Color get textColorValue => _textColor;

  // ---------------------------------------------------------------------------
  // Equatable
  // ---------------------------------------------------------------------------

  @override
  List<Object?> get props => [
        successColor,
        errorColor,
        infoColor,
        warningColor,
        iconColor,
        textColor,
      ];
}
