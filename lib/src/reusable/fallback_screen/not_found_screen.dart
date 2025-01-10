part of '../reusable_import.dart';

/// A screen widget that displays a "Not Found" page.
///
/// This widget is typically used to show when a requested route or resource is not found.
/// It includes a custom animation (via Lottie) and is wrapped in a `PopScope` to prevent navigation pop attempts.
///
/// ## Key Features:
/// - Displays a "Not Found" screen with a custom animation.
//// - Prevents popping the current screen using `PopScope` by setting `canPop` to `false`.
/// - The animation used is configured via the `NotFoundConfig.anim` path.
///
/// ## How to Use:
/// You can use this screen when a user navigates to a non-existing route or when a resource is not found.
/// Typically, this can be shown as part of a 404 page or error handling flow.
///
/// Example usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => const NotFoundScreen()),
/// );
/// ```
///
/// ## Constructor Parameters:
/// - `key`: The optional `Key` used for widget identification.
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevents the screen from being popped
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Lottie.asset(
              NotFoundConfig.anim, // Custom animation from config
              width: 300,
              height: 300,
            ),
          ),
        ),
      ),
    );
  }
}
