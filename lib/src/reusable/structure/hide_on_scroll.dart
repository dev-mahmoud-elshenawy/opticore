import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A widget that animates the visibility of its child based on the user's scroll direction.
/// This widget hides the child when the user scrolls down and shows it again when the user scrolls up.
/// It is often used for hiding UI elements like a bottom navigation bar to enhance the user experience by providing more space for content.
///
/// The widget supports both vertical and horizontal hiding behaviors. The animation duration and initial size can be customized.
///
/// To use this widget, provide a [child] widget, a [scrollController] linked to the scrollable widget, a [hideDirection] (vertical or horizontal),
/// and a [duration] for the animation. You can also set the initial [width] and [height] of the child widget.
class HideOnScroll extends StatefulWidget {
  /// Creates a `HideOnScroll` widget that hides or shows its child based on scroll direction.
  ///
  /// The [child], [scrollController], [hideDirection], and [duration] are required parameters.
  /// [width] and [height] are optional parameters for setting the initial dimensions of the child widget.
  ///
  /// The [child] is the widget that will be hidden or shown depending on the scroll direction.
  /// The [scrollController] is linked to the scrollable widget (like a `ListView` or `SingleChildScrollView`) and is used to detect scroll events.
  /// The [duration] defines the length of the animation when the child widget is shown or hidden (defaults to 300 milliseconds).
  /// The [hideDirection] determines whether the child will hide vertically or horizontally.
  ///
  /// ## Example:
  /// ```dart
  /// HideOnScroll(
  ///  child: BottomNavigationBar(
  ///  items: const [
  ///  BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
  ///  BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
  ///  BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ///  ],
  ///  ),
  ///  scrollController: _scrollController,
  ///  hideDirection: Axis.vertical,
  ///  duration: const Duration(milliseconds: 500),
  ///  height: 56.0,
  ///  )
  ///  ```
  const HideOnScroll({
    super.key,
    required this.child,
    required this.scrollController,
    this.duration = const Duration(milliseconds: 300),
    required this.hideDirection,
    this.width,
    this.height,
  });

  /// The widget to be hidden or shown based on scroll direction.
  final Widget child;

  /// The `ScrollController` used to track the scroll position.
  final ScrollController scrollController;

  /// The duration of the animation when showing or hiding the child widget.
  final Duration duration;

  /// The initial height of the child widget. The height animates to 0 when hidden, if [hideDirection] is vertical.
  final double? height;

  /// The initial width of the child widget. The width animates to 0 when hidden, if [hideDirection] is horizontal.
  final double? width;

  /// The direction in which the child widget will hide.
  /// Use `Axis.vertical` for vertical hiding (height change) or `Axis.horizontal` for horizontal hiding (width change).
  final Axis hideDirection;

  @override
  _HideOnScrollState createState() => _HideOnScrollState();
}

class _HideOnScrollState extends State<HideOnScroll> {
  bool isShown = true;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: widget.duration,
      opacity: isShown ? 1.0 : 0.0,
      child: AnimatedContainer(
        duration: widget.duration,
        height: widget.hideDirection == Axis.vertical
            ? (isShown ? widget.height : 0)
            : widget.height,
        width: widget.hideDirection == Axis.horizontal
            ? (isShown ? widget.width : 0)
            : widget.width,
        curve: Curves.linear,
        clipBehavior: Clip.none,
        child: Wrap(
          children: [
            widget.child,
          ],
        ),
      ),
    );
  }

  /// Shows the child widget if it is currently hidden.
  void _showChild() {
    if (!isShown && mounted) {
      setState(() => isShown = true);
    }
  }

  /// Hides the child widget if it is currently visible.
  void _hideChild() {
    if (isShown && mounted) {
      setState(() => isShown = false);
    }
  }

  /// Handles the scroll events to determine whether to show or hide the child.
  ///
  /// When the user scrolls forward (down), the child is shown. When the user scrolls backward (up), the child is hidden.
  void _onScroll() {
    final direction = widget.scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      _showChild();
    } else if (direction == ScrollDirection.reverse) {
      _hideChild();
    }
  }
}
