part of '../reusable_import.dart';

/// A widget that ensures a child widget becomes visible when it gains focus,
/// such as when a [TextFormField] becomes focused and the keyboard appears.
///
/// This widget is useful when you want to make sure that the focused element
/// is visible in the viewport, especially when the keyboard is open. It can
/// automatically scroll the focused element into view when necessary, ensuring
/// a seamless user experience.
///
/// Usage example:
///
/// In your form class, instantiate a [FocusNode] to monitor focus changes:
/// ```dart
/// FocusNode _focusNode = FocusNode();
/// ```
///
/// Then wrap your [TextFormField] (or any other widget) with the
/// [AutoScrollWhenFocused] widget:
/// ```dart
/// AutoScrollWhenFocused(
///   focusNode: _focusNode,
///   child: TextFormField(
///     focusNode: _focusNode,
///     // Additional properties...
///   ),
/// )
/// ```
///
/// The [AutoScrollWhenFocused] widget ensures that the [TextFormField] or
/// any other child widget becomes fully visible when it receives focus. This
/// is especially useful when the keyboard appears, preventing the field from
/// being hidden behind the keyboard.
///
/// It also provides the option to always align the child widget, even when
/// it's already visible, ensuring that it remains at the top or bottom of the
/// viewport based on your preference.
///
/// Written by Collin Jackson and extended to cover cases where the keyboard
/// is dismissed, and the user taps the focused widget again.
///
/// **Parameters:**
/// - [focusNode]: The [FocusNode] to monitor the focus state.
/// - [child]: The widget that should be scrolled into view when focused.
/// - [curve]: The curve used for scrolling (default is [Curves.easeIn]).
/// - [duration]: The duration for the scrolling animation (default is 100 ms).
/// - [alignment]: Alignment of the child widget when scrolling it into view.
/// - [alwaysAlign]: Whether to always align the child, even if visible.
class AutoScrollWhenFocused extends StatefulWidget {
  const AutoScrollWhenFocused({
    super.key,
    required this.child,
    required this.focusNode,
    this.curve = Curves.easeIn,
    this.duration = const Duration(milliseconds: 100),
    this.alignment,
    this.alwaysAlign = false,
  });

  /// The node to monitor to determine if the child is focused.
  final FocusNode focusNode;

  /// The child widget that should be scrolled into view when focused.
  final Widget child;

  /// The curve used for scrolling.
  final Curve curve;

  /// The duration for scrolling the child into view.
  final Duration duration;

  /// The alignment to apply when scrolling the child into view.
  final double? alignment;

  /// Whether to always align the child, even when visible.
  final bool alwaysAlign;

  @override
  _AutoScrollWhenFocusedState createState() => _AutoScrollWhenFocusedState();
}

/// The internal state that listens for focus changes and handles scrolling.
class _AutoScrollWhenFocusedState extends State<AutoScrollWhenFocused>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_ensureVisible);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.focusNode.removeListener(_ensureVisible);
    super.dispose();
  }

  /// This method is triggered when window metrics change (e.g., when the
  /// keyboard is displayed or dismissed). It ensures the focused widget
  /// becomes visible in the viewport.
  @override
  void didChangeMetrics() {
    if (widget.focusNode.hasFocus) {
      _ensureVisible();
    }
  }

  /// Waits for the keyboard to come into view before ensuring the focused
  /// widget is fully visible in the viewport.
  Future<void> _keyboardToggled() async {
    if (mounted) {
      final edgeInsets = MediaQuery.of(context).viewInsets;
      while (mounted && MediaQuery.of(context).viewInsets == edgeInsets) {
        await Future.delayed(const Duration(milliseconds: 10));
      }
    }
  }

  /// Ensures the focused widget is fully visible, scrolling it if necessary.
  Future<void> _ensureVisible() async {
    // Wait for the keyboard to come into view
    await Future.any([
      Future.delayed(const Duration(milliseconds: 300)),
      _keyboardToggled()
    ]);

    // If the focus has changed, no need to proceed further
    if (!widget.focusNode.hasFocus) {
      return;
    }

    // Find the widget's render object and the viewport for scrolling.
    final object = context.findRenderObject()!;
    final viewport = RenderAbstractViewport.of(object);

    // Retrieve the scrollable state and its position (offset).
    final scrollableState = Scrollable.of(context);
    final position = scrollableState.position;
    late double alignment;

    if (widget.alwaysAlign) {
      // Align the child even if it's already visible
      alignment = 0.0;
    } else if (position.pixels >
        viewport.getOffsetToReveal(object, 0.0).offset) {
      // Scroll down to the top of the viewport if it's out of view
      alignment = 0.0;
    } else if (position.pixels <
        viewport.getOffsetToReveal(object, 1.0).offset) {
      // Scroll up to the bottom of the viewport if needed
      alignment = 1.0;
    } else {
      // No need to scroll if the widget is already visible
      return;
    }

    // Ensure the widget is visible with the specified alignment and animation.
    position.ensureVisible(
      object,
      alignment: widget.alignment ?? alignment,
      duration: widget.duration,
      curve: widget.curve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
