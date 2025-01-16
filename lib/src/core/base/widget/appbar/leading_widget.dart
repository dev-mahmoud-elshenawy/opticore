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
class LeadingWidget extends StatelessWidget {
  /// The route helper used for managing navigation in the app.
  final RouteHelper? route;

  /// Constructor for the `LeadingWidget`.
  ///
  /// - [route]: The `RouteHelper` that provides navigation functionality,
  ///   allowing the widget to perform actions like `pop()` to go back in the navigation stack.
  const LeadingWidget({
    super.key,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.arrowLeft),
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: CoreColors.black,
            ),
            onPressed: () => route?.canPop() ?? false ? route!.pop() : null,
          ),
        ],
      ),
    );
  }
}
