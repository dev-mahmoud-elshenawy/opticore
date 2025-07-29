part of '../reusable_import.dart';

/// Wraps a scrollable, and paints an overlay behind the status bar
/// whose opacity goes from 0 → 1 as you scroll down up to [maxScrollOffset].
///
/// If [blurSigma] > 0, a blur is applied instead of a solid color.
class ScrollStatusBarOverlay extends StatefulWidget {
  /// The scrollable content. Must emit ScrollNotification (e.g. ListView).
  final Widget child;

  /// Color to fade in behind the status bar.
  final Color overlayColor;

  /// Scroll offset at which opacity caps at 1.0.
  final double maxScrollOffset;

  /// If > 0, apply a blur of this sigma instead of a solid color.
  final double blurSigma;

  /// Any extra height below the status bar to cover (e.g. AppBar height).
  final double extraHeight;

  /// Maximum opacity value for the overlay and do not exceed it more than 1.0.
  final double maxClamp;

  const ScrollStatusBarOverlay({
    super.key,
    required this.child,
    this.overlayColor = Colors.white,
    this.maxScrollOffset = 100,
    this.blurSigma = 0,
    this.maxClamp = 1.0,
    this.extraHeight = 0,
  });

  @override
  _ScrollStatusBarOverlayState createState() => _ScrollStatusBarOverlayState();
}

class _ScrollStatusBarOverlayState extends State<ScrollStatusBarOverlay> {
  double _opacity = 0.0;

  bool _onScroll(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final offset = notification.metrics.pixels;
      setState(() {
        _opacity =
            (offset / widget.maxScrollOffset).clamp(0.0, widget.maxClamp);
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Stack(
      children: [
        // 1) The scrollable content
        NotificationListener<ScrollNotification>(
          onNotification: _onScroll,
          child: widget.child,
        ),

        // 2) The overlay behind the status bar (and optional extra area)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: statusBarHeight + widget.extraHeight,
          child: widget.blurSigma > 0
              ? BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: widget.blurSigma * _opacity,
                    sigmaY: widget.blurSigma * _opacity,
                  ),
                  child: Container(color: Colors.transparent),
                )
              : Container(
                  color: widget.overlayColor.withValues(alpha: _opacity),
                ),
        ),
      ],
    );
  }
}
