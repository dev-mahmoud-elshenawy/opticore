part of '../util_import.dart';

/// A custom [ScrollPhysics] implementation for snapping to a fixed size
/// interval during scrolling.
///
/// This physics configuration is particularly useful in scenarios where
/// snapping to specific scroll positions, such as paginated views or grids,
/// is required.
///
/// ### Parameters:
/// - [snapSize]: The interval size to which scrolling snaps. Each snap point
///   is a multiple of this value.
///
/// ### Example Usage:
/// ```dart
/// ListView.builder(
///   physics: const SnapScrollSize(snapSize: 100.0),
///   itemBuilder: (context, index) => ListTile(
///     title: Text('Item $index'),
///   ),
/// )
/// ```
///
/// In the example above, the `SnapScrollSize` ensures the scrolling stops
/// precisely at intervals of 100 pixels.
///
/// ### Implementation Details:
/// - The snapping behavior calculates the nearest "page" based on the scroll
///   position and adjusts the scroll to the nearest snap point.
/// - Supports ballistic simulations to provide smooth snapping animations.
class SnapScrollSize extends ScrollPhysics {
  /// Creates an instance of [SnapScrollSize] with the given [snapSize].
  ///
  /// The [snapSize] parameter specifies the fixed interval size for snapping.
  const SnapScrollSize({super.parent, required this.snapSize});

  /// The size of each snapping interval.
  final double snapSize;

  /// Applies this [ScrollPhysics] to the parent [ScrollPhysics].
  @override
  SnapScrollSize applyTo(ScrollPhysics? ancestor) {
    return SnapScrollSize(parent: buildParent(ancestor), snapSize: snapSize);
  }

  /// Calculates the current "page" based on the scroll position.
  ///
  /// This is determined by dividing the current scroll position by [snapSize].
  double _getPage(ScrollMetrics position) {
    return position.pixels / snapSize;
  }

  /// Calculates the pixel position for the given page.
  ///
  /// Multiplies the page index by [snapSize] to determine the target scroll
  /// position.
  double _getPixels(ScrollMetrics position, double page) {
    return page * snapSize;
  }

  /// Determines the target pixel position based on velocity and snapping rules.
  ///
  /// Adjusts the snapping behavior depending on the scroll velocity and
  /// tolerance values.
  double _getTargetPixels(
      ScrollMetrics position, Tolerance tolerance, double velocity) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    return _getPixels(position, page.roundToDouble());
  }

  /// Creates a ballistic simulation to handle snapping animations.
  ///
  /// If the target position differs from the current position, a
  /// [ScrollSpringSimulation] is used to smoothly animate the scroll.
  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // If the scroll is out of range, defer to the parent physics.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }
    // Retrieve the tolerance for the simulation.
    // ignore: deprecated_member_use
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    }
    return null;
  }

  /// Prevents implicit scrolling during snapping.
  ///
  /// This ensures users have a controlled snapping behavior without unexpected
  /// automatic scroll adjustments.
  @override
  bool get allowImplicitScrolling => false;
}
