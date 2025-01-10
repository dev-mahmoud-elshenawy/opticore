part of '../reusable_import.dart';

/// A utility class for displaying a customizable Cupertino modal bottom sheet.
///
/// The `CoreSheet` class provides a simple way to show a bottom sheet in Cupertino style with customizable options such as background color, border radius, and drag behavior. It also handles dismiss events using an optional `onDismiss` callback.
///
/// ## Key Features:
/// - **Customizable Appearance**: The bottom sheet's background color, border radius, and content can be customized.
/// - **Drag Support**: Optionally, enable dragging of the bottom sheet for user interaction.
/// - **Dismiss Handling**: An optional callback function to be triggered when the bottom sheet is dismissed.
/// - **Expandable**: The bottom sheet can optionally expand to the entire screen when triggered.
///
/// ## Constructor Parameters:
/// - `child`: The widget to display inside the bottom sheet.
/// - `enableDrag`: A boolean to enable or disable drag functionality. Defaults to `false`.
/// - `expand`: A boolean to control whether the bottom sheet should expand. Defaults to `false`.
/// - `backgroundColor`: The background color of the bottom sheet. Defaults to `CoreColors.backgroundColor`.
/// - `borderRadius`: The border radius for the top corners of the bottom sheet. Defaults to `30.0`.
/// - `onDismiss`: An optional callback function that is triggered when the bottom sheet is dismissed.
///
/// ## How to Use:
/// The `CoreSheet.showCupertino` method is used to display the Cupertino-style modal bottom sheet. You can customize the sheet's appearance, behavior, and content, and also define a callback for when the sheet is dismissed.
///
/// Example usage:
/// ```dart
/// CoreSheet.showCupertino(
///   child: YourWidget(),
///   enableDrag: true,
///   expand: true,
///   backgroundColor: Colors.white,
///   borderRadius: 20.0,
///   onDismiss: () {
///     print('Bottom sheet was dismissed');
///   },
/// );
/// ```
///
/// ### Constructor:
/// - `child`: The widget to display inside the modal bottom sheet.
/// - `enableDrag`: Enables drag functionality (defaults to `false`).
/// - `expand`: If `true`, the bottom sheet will expand to full screen (defaults to `false`).
/// - `backgroundColor`: The background color of the bottom sheet (defaults to `CoreColors.backgroundColor`).
/// - `borderRadius`: The border radius for the sheet's top corners (defaults to `30.0`).
/// - `onDismiss`: Callback function to handle sheet dismissal.
class CoreSheet {
  /// Displays a customizable Cupertino-style modal bottom sheet.
  ///
  /// This method shows a bottom sheet with customizable options such as drag behavior, background color, and border radius. It also supports a dismiss callback to handle actions when the sheet is closed.
  ///
  /// - `child`: The widget to display inside the bottom sheet.
  /// - `enableDrag`: A boolean to enable dragging of the bottom sheet (default is `false`).
  /// - `expand`: A boolean to control whether the bottom sheet should expand to full screen (default is `false`).
  /// - `backgroundColor`: The background color of the bottom sheet (defaults to `CoreColors.backgroundColor`).
  /// - `borderRadius`: The border radius for the top corners (defaults to `30.0`).
  /// - `onDismiss`: Optional callback function that will be called when the bottom sheet is dismissed.
  static Future<void> showCupertino({
    required Widget child,
    bool? enableDrag,
    bool? expand,
    Color? backgroundColor,
    double? borderRadius,
    Function()? onDismiss,
  }) async =>
      await showCupertinoModalBottomSheet(
        context: RouteHelper.navigatorKey.currentContext!,
        expand: expand ?? false,
        topRadius: Radius.circular(borderRadius ?? 30),
        backgroundColor: backgroundColor ?? CoreColors.backgroundColor,
        enableDrag: enableDrag ?? false,
        isDismissible: enableDrag ?? false,
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                10.ph,
                SvgWidget(
                  path: CoreAssets.icDrag,
                  type: SvgType.asset,
                ),
                25.ph,
                Material(
                  color: backgroundColor ?? CoreColors.backgroundColor,
                  child: child,
                )
              ],
            ),
          ),
        ),
      ).whenComplete(() {
        if (onDismiss != null) {
          onDismiss();
        }
      });
}