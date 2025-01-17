import 'package:flutter/material.dart';
import 'package:opticore/opticore.dart';

import '../../../../utils/ui/core_colors.dart';

/// A custom widget for the leading (back) button in the app bar.
///
/// The `LeadingWidget` provides a back button for navigation within the application.
/// It is typically used as the leading widget in an `AppBar`. The widget uses the
/// `FontAwesomeIcons.arrowLeft` icon for the back button and allows for customizable
/// navigation based on the `RouteHelper` passed to it. If the route can be popped,
/// it will navigate back to the previous screen.
///
/// ### Example Usage:
/// ```dart
/// LeadingWidget(route: routeHelper),
/// ```
/// In this example, `routeHelper` is used to manage navigation.
///
/// ### Properties:
/// - [route]: The `RouteHelper` instance responsible for managing navigation. This
///   allows the widget to perform route popping if the navigation stack allows it.
/// - [backIcon]: The icon to use for the back button. Default is `FontAwesomeIcons.arrowLeft`.
/// - [iconColor]: The color of the icon. Default is `null`.
/// - [iconBackgroundColor]: The background color of the icon. Default is `null`.
class LeadingWidget extends StatelessWidget {
  /// The route helper used for managing navigation in the app.
  final RouteHelper? route;

  /// The icon to use for the back button. Default is `FontAwesomeIcons.arrowLeft`.
  final Widget? backIcon;

  /// The color of the icon.
  final Color? iconColor;

  /// The background color of the icon.
  final Color? iconBackgroundColor;

  /// Constructor for the `LeadingWidget`.
  ///
  /// - [route]: The `RouteHelper` that provides navigation functionality,
  ///   allowing the widget to perform actions like `pop()` to go back in the navigation stack.
  /// - [backIcon]: The icon to use for the back button. Default is `FontAwesomeIcons.arrowLeft`.
  const LeadingWidget({
    super.key,
    required this.route,
    this.backIcon,
    this.iconColor,
    this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: backIcon ?? FaIcon(FontAwesomeIcons.arrowLeft),
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              foregroundColor: iconColor,
              backgroundColor: iconBackgroundColor,

            ),
            onPressed: () => route?.canPop() ?? false ? route!.pop() : null,
          ),
        ],
      ),
    );
  }
}
