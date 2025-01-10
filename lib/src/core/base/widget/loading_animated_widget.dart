import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:opticore/src/utils/ui/core_assets.dart';

/// A widget that displays a loading animation using Lottie.
///
/// The [LoadingAnimatedWidget] is a simple widget that shows an animated loading
/// indicator in the center of the screen. It uses a Lottie animation from the
/// assets to visually indicate a loading state, offering a smooth and visually
/// appealing way to show progress to the user during long-running operations.
///
/// This widget is especially useful for scenarios where you need to inform the user
/// that the app is processing data or performing tasks in the background, such as
/// during network requests, file downloads, or complex calculations.
///
/// ### Example Usage:
/// ```dart
/// LoadingAnimatedWidget();
/// ```
///
/// The widget does not take any parameters, and simply shows the loading animation.
class LoadingAnimatedWidget extends StatelessWidget {
  /// Creates a [LoadingAnimatedWidget] instance.
  const LoadingAnimatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      // Displays the Lottie animation in the center of the screen
      child: Lottie.asset(CoreAssets.LOADING_ANIM), // Uses the loading animation asset
    );
  }
}