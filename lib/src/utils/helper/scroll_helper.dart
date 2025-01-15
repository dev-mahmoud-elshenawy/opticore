part of '../util_import.dart';

/// A custom scroll behavior helper that defines platform-specific scroll physics and drag strategies.
///
/// This class extends the [MaterialScrollBehavior] to customize the scrolling behavior based on the platform.
/// It ensures a consistent user experience across platforms like iOS, Android, and desktop environments.
///
/// ### Key Features:
/// - **Platform-Specific Scroll Physics:**
///   - Uses [ClampingScrollPhysics] for platforms like iOS, macOS, and Android.
///   - Uses [BouncingScrollPhysics] for platforms like Windows, Linux, and Fuchsia.
/// - **Custom Drag Strategy:**
///   - Implements a multitouch drag strategy using [MultitouchDragStrategy.sumAllPointers].
///
/// ### Example Usage:
/// ```dart
/// MaterialApp(
///   scrollBehavior: ScrollBehaviorHelper(),
///   home: MyHomePage(),
/// );
/// ```
///
/// ### Why Use This Helper?
/// - Ensures a more natural and native scrolling experience for users.
/// - Provides seamless multitouch drag handling.
///
/// ### Platforms and Their Behaviors:
/// | Platform           | Scroll Physics           |
/// |--------------------|--------------------------|
/// | iOS, macOS, Android | ClampingScrollPhysics    |
/// | Windows, Linux, Fuchsia | BouncingScrollPhysics    |
class ScrollBehaviorHelper extends MaterialScrollBehavior {
  /// Provides platform-specific scroll physics.
  ///
  /// Depending on the platform, it returns either [ClampingScrollPhysics]
  /// or [BouncingScrollPhysics] to deliver a natural scrolling experience.
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return const ClampingScrollPhysics();
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const BouncingScrollPhysics();
    }
  }
}
