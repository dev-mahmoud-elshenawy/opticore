part of '../reusable_import.dart';

/// A widget that displays a stack of pages, with lazy loading, fade transitions, and preloading support.
///
/// This widget provides an efficient way to display a stack of pages where only the currently
/// selected page is built, and optionally preloaded pages are kept in the widget tree.
/// Pages that are not visible are replaced with a placeholder widget to reduce unnecessary rebuilds.
///
/// It also includes a fade transition between page switches, adding a smooth and professional animation effect.
///
/// ### Key Features:
/// - **Lazy Loading**: Only the selected page and preloaded pages are built. Non-visible pages are replaced with a placeholder widget (`unloadWidget`).
/// - **Fade Transition**: A fade effect is applied when switching between pages, making the transition smooth.
/// - **Preloading Support**: You can specify a list of indices (`preloadIndexes`) to preload pages that are likely to be needed soon.
/// - **Efficient Rebuilding**: Pages that are not in the current index or preloaded are not rebuilt, saving resources and improving performance.
///
/// ### Parameters:
/// - [index]: The current index of the page to be displayed. If not provided, defaults to `0`.
/// - [length]: The total number of pages.
/// - [duration]: The duration of the fade transition animation (defaults to 800ms).
/// - [pageBuilder]: A function that takes an index and returns the widget to be displayed at that index.
/// - [unloadWidget]: A widget that replaces non-visible pages in the widget tree (default is `SizedBox.shrink()`).
class LazyIndexedStack extends StatefulWidget {
  /// The index of the currently visible page. Defaults to `0`.
  final int? index;

  /// The total number of pages.
  final int? length;

  /// The duration of the fade transition animation. Defaults to 800 milliseconds.
  final Duration? duration;

  /// A function that returns the widget for a given index.
  final Widget? Function(int pageIndex)? pageBuilder;

  /// The widget that replaces unloaded pages. Defaults to an empty container (`SizedBox.shrink()`).
  final Widget unloadWidget;

  /// Creates a new [LazyIndexedStack] widget.
  ///
  /// - The [index] and [length] parameters are required, while the rest are optional.
  /// - The [pageBuilder] function is required to return a widget for each page index.
  /// - The [unloadWidget] parameter is optional and defaults to an empty container.
  /// - The [duration] parameter is optional and defaults to 800 milliseconds.
  ///
  /// ### Example Usage:
  /// ```dart
  /// LazyIndexedStack(
  ///   index: selectedIndex,
  ///   length: 5,
  ///   duration: const Duration(milliseconds: 400),
  ///   preloadIndexes: [0, 2], // Preload pages 0 and 2
  ///   unloadWidget: const SizedBox.shrink(), // Placeholder for unloaded pages
  ///   pageBuilder: (index) {
  ///     switch (index) {
  ///       case 0:
  ///         return Text('Page 1').center;
  ///       case 1:
  ///         return Text('Page 2').center;
  ///       case 2:
  ///         return HomeScreen(bloc: HomeBloc());
  ///       case 3:
  ///         return Text('Page 4').center;
  ///       case 4:
  ///         return Text('Page 5').center;
  ///       default:
  ///         return const SizedBox.shrink(); // Fallback
  ///     }
  ///   },
  /// )
  /// ```
  /// In this example:
  /// - The `selectedIndex` will determine which page is shown.
  /// - Non-visible pages will be replaced with an empty `SizedBox`.
  /// - The `pageBuilder` is used to define custom widgets for each page.
  const LazyIndexedStack({
    super.key,
    this.index,
    this.length,
    this.duration = const Duration(milliseconds: 200),
    this.pageBuilder,
    this.unloadWidget = const SizedBox.shrink(),
  });

  @override
  _LazyIndexedStackState createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  PageController? _pageController;

  @override
  void didUpdateWidget(LazyIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Animate and change page only if the index changes
    if (widget.index != oldWidget.index) {
      _controller!.forward(from: 0.0);
      _pageController!.animateToPage(
        widget.index!,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInToLinear,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller and page controller
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();
    // Initialize the page controller
    _pageController = PageController(initialPage: widget.index ?? 0);
  }

  @override
  void dispose() {
    // Dispose the controllers
    _controller!.dispose();
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller!,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int itemIndex) {
          // Build only the selected page and preloaded pages
          if (itemIndex == widget.index) {
            return widget.pageBuilder!(itemIndex)!;
          } else {
            return widget
                .unloadWidget; // Replace unloaded pages with placeholder
          }
        },
      ),
    );
  }
}
