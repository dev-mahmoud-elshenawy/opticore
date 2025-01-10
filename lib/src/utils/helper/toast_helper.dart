part of '../util_import.dart';

/// A helper class for displaying custom toast messages using BotToast.
class ToastHelper {
  /// Private constructor for singleton instance.
  ToastHelper._();

  /// Singleton instance of [ToastHelper].
  static final ToastHelper _instance = ToastHelper._();

  /// Provides access to the singleton instance.
  static ToastHelper get instance => _instance;

  /// Default duration for toast messages, in seconds.
  static const int defaultDuration = 2;

  /// Displays a toast message based on the specified [ToastType].
  ///
  /// [message]: The message to display. Ignored if null or empty.
  /// [type]: The type of toast to display. Determines icon and background color.
  /// [duration]: Duration of the toast in seconds. Defaults to [defaultDuration].
  void showToast(
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
  void _displayToast({
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
  _ToastConfig _getToastConfig(ToastType type) {
    switch (type) {
      case ToastType.success:
        return _ToastConfig(
          icon: FontAwesomeIcons.solidCircleCheck,
          color: CoreColors.success,
        );
      case ToastType.error:
        return _ToastConfig(
          icon: FontAwesomeIcons.triangleExclamation,
          color: CoreColors.error,
        );
      case ToastType.info:
        return _ToastConfig(
          icon: FontAwesomeIcons.circleInfo,
          color: CoreColors.info,
        );
      case ToastType.warning:
        return _ToastConfig(
          icon: FontAwesomeIcons.triangleExclamation,
          color: CoreColors.warning,
        );
    }
  }

  /// Builds the toast widget with the specified message, icon, and background color.
  ///
  /// [message]: The message to display.
  /// [icon]: The icon to display in the toast.
  /// [color]: The background color of the toast.
  Widget _buildToast(String message, IconData icon, Color color) {
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
              color: CoreColors.backgroundColor,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                message,
                textAlign: TextAlign.center,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 15,
                  color: CoreColors.backgroundColor,
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
