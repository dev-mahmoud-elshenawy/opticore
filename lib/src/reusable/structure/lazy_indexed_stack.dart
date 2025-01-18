import 'package:flutter/widgets.dart';

/// A performance-optimized version of [IndexedStack] that only builds the widget associated with the current index or preloaded indices.
///
/// [LazyIndexedStack] helps improve app performance by deferring the creation of child widgets that are not currently visible.
/// It ensures that only the visible widget (at [index]) and preloaded widgets are built initially, while the other widgets are unloaded
/// and replaced with a placeholder [unloadWidget] until they are needed again.
///
/// This widget is especially useful in scenarios where the stack has a large number of children, but only a few are visible at any
/// given time, making it ideal for scenarios like tab navigation, where only one widget is visible at a time.
///
/// Example:
/// ```dart
/// LazyIndexedStack(
///  index: _currentIndex,
///  preloadIndexes: [0, 1, 2],
///  children: [
///  Tab1(),
///  Tab2(),
///  Tab3(),
///  Tab4(),
///  Tab5(),
///  ],
///  unloadWidget: Container(),
///  )
///  ```
class LazyIndexedStack extends StatefulWidget {
  /// The widget to display in place of unloaded children.
  ///
  /// The [unloadWidget] is shown when a child widget is not visible. By default, it is a [Container].
  final Widget unloadWidget;

  /// A list of indices corresponding to the children that should be preloaded.
  ///
  /// Children at the indices specified here will be built and remain in the widget tree even if they are not visible.
  /// This can be useful for optimizing performance by ensuring that certain children are always available when their index
  /// is selected.
  final List<int> preloadIndexes;

  /// Alignment of the children within the [IndexedStack].
  ///
  /// This property determines how the children are aligned within the stack. The default value is [AlignmentDirectional.topStart].
  final AlignmentGeometry alignment;

  /// The sizing behavior of the stack's children.
  ///
  /// Similar to the [StackFit] property of the original [IndexedStack], this controls how the children inside the stack should
  /// size themselves relative to each other.
  final StackFit sizing;

  /// The text direction in which the children of the stack should be laid out.
  ///
  /// If `null`, the text direction will be inherited from the ambient [Directionality].
  final TextDirection? textDirection;

  /// The index of the currently visible child in the stack.
  ///
  /// Only the child at this index will be built immediately. Other children will either be unloaded or replaced with the
  /// [unloadWidget] unless they are part of the preloaded indices.
  final int index;

  /// The children widgets of the stack.
  ///
  /// These widgets will be displayed in a stack-like manner, but only the widget corresponding to the [index] or preloaded
  /// indices will be built immediately. Other widgets will be replaced with the [unloadWidget] until needed.
  final List<Widget> children;

  /// Creates a [LazyIndexedStack] that wraps a [IndexedStack], deferring the building of non-visible widgets.
  ///
  /// - The widget at the [index] will be built immediately.
  /// - The widgets in the [preloadIndexes] list will also be preloaded and available when needed.
  /// - All other widgets are replaced with [unloadWidget], which defaults to [Container].
  LazyIndexedStack({
    super.key,
    Widget? unloadWidget,
    this.preloadIndexes = const [],
    this.alignment = AlignmentDirectional.topStart,
    this.sizing = StackFit.loose,
    this.textDirection,
    required this.index,
    required this.children,
  }) : unloadWidget = unloadWidget ?? Container();

  @override
  LazyIndexedStackState createState() => LazyIndexedStackState();
}

class LazyIndexedStackState extends State<LazyIndexedStack> {
  late List<Widget> _children;
  final _stackKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _children = _initializeChildren();
  }

  @override
  void didUpdateWidget(final LazyIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Reinitialize children if the number of children changes.
    if (widget.children.length != oldWidget.children.length) {
      _children = _initializeChildren();
    }

    // Update the widget at the current index if it has changed.
    _children[widget.index] = widget.children[widget.index];
  }

  @override
  Widget build(final BuildContext context) {
    return IndexedStack(
      key: _stackKey,
      index: widget.index,
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      sizing: widget.sizing,
      children: _children,
    );
  }

  /// Initializes the list of children by replacing widgets that are not visible with [unloadWidget].
  ///
  /// This method ensures that:
  /// - The child at the [index] is built immediately.
  /// - The children in [preloadIndexes] are built and remain in the widget tree.
  /// - Other children are replaced with [unloadWidget] until they are needed again.
  List<Widget> _initializeChildren() {
    return widget.children.asMap().entries.map((entry) {
      final index = entry.key;
      final childWidget = entry.value;

      // Only build the widget if its index is the current [index] or part of [preloadIndexes].
      if (index == widget.index || widget.preloadIndexes.contains(index)) {
        return childWidget;
      } else {
        return widget.unloadWidget;
      }
    }).toList();
  }
}
