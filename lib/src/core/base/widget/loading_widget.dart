import 'package:flutter/material.dart';

/// A simple loading widget that displays a circular progress indicator.
///
/// The [LoadingWidget] is a minimalistic widget that centers a [CircularProgressIndicator]
/// on the screen. It is commonly used to show that some operation is in progress, such as
/// data fetching, processing, or other background tasks.
///
/// This widget is ideal for displaying a loading state while the application is performing
/// operations like fetching data, making network requests, or processing complex tasks.
///
/// ### Example Usage:
/// ```dart
/// LoadingWidget();
/// ```
///
/// This widget does not require any parameters, and it automatically shows a circular
/// progress indicator in the center of the screen.
class LoadingWidget extends StatelessWidget {
  /// Creates a [LoadingWidget] instance.
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      // Displays a circular progress indicator in the center of the screen
      child: CircularProgressIndicator(),
    );
  }
}