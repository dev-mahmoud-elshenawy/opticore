part of '../reusable_import.dart';

/// A callback type for handling the "scrolls-to-top" event.
///
/// This callback is triggered when a scroll-to-top animation occurs. It receives
/// the [TopScrollerEvent] containing the destination offset, duration, and curve.
typedef TopScrollerCallback = Future<void> Function(TopScrollerEvent event);

/// Represents a scroll-to-top event.
///
/// This event contains the details about the scroll-to-top animation, including
/// the destination offset, duration, and animation curve, as provided by
/// [ScrollController.animateTo].
class TopScrollerEvent {
  /// Creates a new [TopScrollerEvent] from the arguments of [ScrollController.animateTo].
  ///
  /// [to] is the target scroll position, [duration] is the duration of the scroll,
  /// and [curve] is the animation curve for the scroll.
  TopScrollerEvent(
    this.to, {
    required this.duration,
    required this.curve,
  });

  /// The target scroll position (in logical pixels) passed to [ScrollController.animateTo].
  final double to;

  /// The duration of the scroll animation passed to [ScrollController.animateTo].
  final Duration duration;

  /// The curve of the scroll animation passed to [ScrollController.animateTo].
  final Curve curve;
}

/// A widget that listens for and handles the scrolls-to-top event.
///
/// This widget triggers the [onTopScroller] callback whenever a scroll-to-top event
/// is detected in its child widget. It allows handling custom scroll-to-top behavior
/// by specifying a callback that receives the details of the event.
///
/// The [child] widget is the scrollable widget that will be monitored for the scroll-to-top event.
/// The [onTopScroller] callback is called with an instance of [TopScrollerEvent] when the event occurs.
class TopScroller extends StatefulWidget {
  /// Creates a new [TopScroller] widget.
  ///
  /// [child] is the widget that will be scrolled, and [onTopScroller] is the callback
  /// that will be called when the scroll-to-top event occurs.
  ///
  /// ## Example:
  /// ```dart
  /// TopScroller(
  ///  child: ListView.builder(
  ///  itemCount: 100,
  ///  itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
  ///  ),
  ///  onTopScroller: (event) async {
  ///  // Handle the scroll-to-top event
  ///  },
  const TopScroller({
    super.key,
    required this.child,
    required this.onTopScroller,
  });

  /// The widget to be scrolled, for which the scroll-to-top event will be captured.
  final Widget child;

  /// The callback that handles the scroll-to-top event. It is called with an instance of [TopScrollerEvent].
  final TopScrollerCallback onTopScroller;

  @override
  State<TopScroller> createState() => _TopScrollerState();
}

class _TopScrollerState extends State<TopScroller> {
  ScrollController? _primaryScrollController;
  ScrollPositionWithSingleContext? _scrollPositionWithSingleContext;
  bool _attached = false;

  @override
  void dispose() {
    // Detach the scroll position and dispose the resources when the widget is disposed
    _scrollPositionWithSingleContext ??
        _primaryScrollController?.detach(_scrollPositionWithSingleContext!);
    _scrollPositionWithSingleContext?.dispose();
    _scrollPositionWithSingleContext = null;
    _primaryScrollController = null;
    _attached = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_attached) {
      _attach(context);
      _attached = true;
    }
    return widget.child;
  }

  // Attach a custom scroll position to the primary scroll controller
  void _attach(BuildContext context) {
    final primaryScrollController =
        PrimaryScrollController.of(Navigator.of(context).context);

    final scrollPositionWithSingleContext =
        _FakeScrollPositionWithSingleContext(
      context: context,
      callback: widget.onTopScroller,
    );
    primaryScrollController.attach(scrollPositionWithSingleContext);

    _primaryScrollController = primaryScrollController;
    _scrollPositionWithSingleContext = scrollPositionWithSingleContext;
  }
}

/// A fake implementation of [ScrollPositionWithSingleContext] that allows custom
/// handling of the scroll-to-top event.
class _FakeScrollPositionWithSingleContext
    extends ScrollPositionWithSingleContext {
  _FakeScrollPositionWithSingleContext({
    required BuildContext context,
    required TopScrollerCallback callback,
  })  : _callback = callback,
        super(
          physics: const NeverScrollableScrollPhysics(),
          context: _FakeScrollContext(context),
        );

  final TopScrollerCallback _callback;

  @override
  Future<void> animateTo(
    double to, {
    required Duration duration,
    required Curve curve,
  }) {
    // Trigger the callback with the event when animateTo is called
    return _callback(
      TopScrollerEvent(to, duration: duration, curve: curve),
    );
  }
}

/// A fake implementation of [ScrollContext] to provide necessary context for
/// scroll position management.
class _FakeScrollContext extends ScrollContext {
  _FakeScrollContext(this._context);

  final BuildContext _context;

  @override
  AxisDirection get axisDirection => AxisDirection.down;

  @override
  BuildContext get notificationContext => _context;

  @override
  void saveOffset(double offset) {}

  @override
  void setCanDrag(bool value) {}

  @override
  void setIgnorePointer(bool value) {}

  @override
  void setSemanticsActions(Set<SemanticsAction> actions) {}

  @override
  BuildContext get storageContext => _context;

  @override
  TickerProvider get vsync => _FakeTickerProvider();

  @override
  double get devicePixelRatio =>
      MediaQuery.maybeDevicePixelRatioOf(_context) ??
      View.of(_context).devicePixelRatio;
}

/// A fake implementation of [TickerProvider] to provide the necessary vsync for animations.
class _FakeTickerProvider extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
