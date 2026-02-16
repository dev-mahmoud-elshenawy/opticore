part of '../util_import.dart';

/// A helper class for displaying custom toast messages using BotToast.
///
/// This class provides a simple interface for displaying toast messages with
/// different types (success, error, info, warning) and durations. It abstracts
///
/// the complexity of creating custom toast widgets and managing their display.
///
/// **Main Features:**
/// - Display toast messages with different types (success, error, info, warning).
/// - Set custom durations for toast messages.
/// - Automatically handle the display of toast messages using BotToast.
///
/// ## included Methods:
/// - [showToast]: Displays a toast message with the specified type and duration.
/// enum [ToastType] { success, error, info, warning }
///
/// ### Example Usage:
/// ```dart
/// ToastHelper.showToast('Success message', type: ToastType.success);
/// ```
class ToastHelper {
  /// Private constructor to prevent instantiation of the class.
  ToastHelper._();

  /// Factory constructor to return a new instance of the [ToastHelper] class.
  factory ToastHelper({
    String? customMessage,
    int? customDuration,
  }) {
    return ToastHelper._();
  }

  /// Default duration for toast messages, in seconds.
  static const int defaultDuration = 2;

  /// Displays a toast message based on the specified [ToastType].
  ///
  /// [message]: The message to display. Ignored if null or empty.
  /// [type]: The type of toast to display. Determines icon and background color.
  /// [duration]: Duration of the toast in seconds. Defaults to [defaultDuration].
  static void showToast(
    String? message, {
    required ToastType type,
    int? duration,
  }) {
    if (message == null || message.trim().isEmpty) return;

    final config = _getToastConfig(type);

    _displayToast(
      message: message,
      icon: config.icon,
      color: config.color,
      duration: duration ?? defaultDuration,
    );
  }

  /// Internal method to display a toast with the specified icon, color, and duration.
  ///
  /// [message]: The message to display.
  /// [icon]: The icon to show in the toast.
  /// [color]: The background color of the toast.
  /// [duration]: The duration of the toast in seconds.
  static void _displayToast({
    required String message,
    required IconData icon,
    required Color color,
    required int duration,
  }) {
    BotToast.showCustomText(
      duration: Duration(seconds: duration),
      onlyOne: true,
      align: const Alignment(0, 0.8),
      toastBuilder: (_) => _buildToast(message, icon, color),
    );
  }

  /// Determines the configuration for the specified [ToastType].
  ///
  /// Returns a [_ToastConfig] containing the icon and color for the toast.
  static _ToastConfig _getToastConfig(ToastType type) {
    switch (type) {
      case ToastType.success:
        return _ToastConfig(
          icon: FontAwesomeIcons.solidCircleCheck,
          color: ToastConfig.successColorValue,
        );
      case ToastType.error:
        return _ToastConfig(
          icon: FontAwesomeIcons.triangleExclamation,
          color: ToastConfig.errorColorValue,
        );
      case ToastType.info:
        return _ToastConfig(
          icon: FontAwesomeIcons.circleInfo,
          color: ToastConfig.infoColorValue,
        );
      case ToastType.warning:
        return _ToastConfig(
          icon: FontAwesomeIcons.triangleExclamation,
          color: ToastConfig.warningColorValue,
        );
    }
  }

  /// Builds the toast widget with the specified message, icon, and background color.
  ///
  /// [message]: The message to display.
  /// [icon]: The icon to display in the toast.
  /// [color]: The background color of the toast.
  static Widget _buildToast(String message, IconData icon, Color color) {
    return Card(
      color: color,
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              icon,
              color: ToastConfig.iconColorValue,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                message,
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                  fontSize: 15,
                  color: ToastConfig.textColorValue,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A private class to encapsulate toast configuration.
class _ToastConfig {
  final IconData icon;
  final Color color;

  _ToastConfig({required this.icon, required this.color});
}
