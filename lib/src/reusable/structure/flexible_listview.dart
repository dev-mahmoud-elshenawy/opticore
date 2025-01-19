part of '../reusable_import.dart';

/// Enum to define the scroll direction for [FlexibleListView].
///
/// - [horizontal]: Scrolls horizontally.
enum ScrollDirection { horizontal, vertical }

/// A widget that displays a list of items with dynamic heights in a scrollable view.
///
/// This widget allows for displaying items in a list with the ability to specify
/// dynamic scroll direction (horizontal or vertical) and includes padding options
/// for both the entire list and individual items. It supports custom scroll
/// physics and an optional [ScrollController] to control the scroll behavior.
class FlexibleListView<T> extends StatelessWidget {
  /// Padding for the entire list view.
  ///
  /// The padding applied to the entire list, around the scrollable area.
  final EdgeInsets? padding;

  /// Padding for each individual item.
  ///
  /// The padding applied to each individual item in the list. By default, the
  /// padding is applied only to the right side of each item.
  final EdgeInsetsGeometry itemPadding;

  /// List of items to be displayed.
  ///
  /// The list of items of type [T] that will be rendered in the scrollable view.
  final List<T> items;

  /// Builder function to create widgets for each item.
  ///
  /// This function is called for each item in the list to build a widget
  /// representation of the item. It takes [BuildContext] and the item as parameters.
  final Widget Function(BuildContext context, T item, int? index) itemBuilder;

  /// Optional controller for the scroll view.
  ///
  /// A [ScrollController] can be provided to control the scroll behavior
  /// programmatically.
  final ScrollController? controller;

  /// Scroll direction of the list view.
  ///
  /// Determines whether the list scrolls horizontally or vertically. Defaults
  /// to [ScrollDirection.horizontal].
  final ScrollDirection scrollDirection;

  /// Optional physics for the scroll view.
  ///
  /// Customizes the scroll behavior (e.g., `BouncingScrollPhysics`, `ClampingScrollPhysics`).
  final ScrollPhysics? physics;

  /// Creates a [FlexibleListView] widget.
  ///
  /// The widget is initialized with the following parameters:
  ///
  /// - [items]: A list of items to be displayed.
  /// - [itemBuilder]: A function to build each item widget.
  /// - [padding]: Optional padding for the entire list.
  /// - [itemPadding]: Padding for each individual item in the list.
  /// - [controller]: Optional [ScrollController] to manage scroll position.
  /// - [scrollDirection]: The scroll direction, either horizontal or vertical.
  /// - [physics]: Optional scroll physics to control scrolling behavior.
  ///
  /// ## Example:
  /// ```dart
  /// FlexibleListView<String>(
  ///  items: ['Item 1', 'Item 2', 'Item 3'],
  ///  itemBuilder: (context, item) => Text(item),
  ///  padding: const EdgeInsets.all(8.0),
  ///  itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
  ///  controller: _scrollController,
  ///  scrollDirection: ScrollDirection.vertical,
  ///  physics: const BouncingScrollPhysics(),
  ///  )
  ///  ```
  const FlexibleListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.padding,
    this.itemPadding = const EdgeInsetsDirectional.only(end: 20.0),
    this.controller,
    this.scrollDirection = ScrollDirection.horizontal,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    final cards = <Widget>[];

    if (items.isNotEmpty) {
      // Builds the individual items using the provided itemBuilder.
      for (int i = 0; i < items.length; i++) {
        cards.add(Padding(
          padding: itemPadding,
          child: itemBuilder(context, items[i], i),
        ));
      }

      // Returns a scrollable view based on the specified scroll direction.
      return SingleChildScrollView(
        controller: controller,
        padding: padding,
        physics: physics,
        scrollDirection: scrollDirection == ScrollDirection.horizontal
            ? Axis.horizontal
            : Axis.vertical,
        child: scrollDirection == ScrollDirection.horizontal
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: cards,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: cards,
              ),
      );
    } else {
      // Returns an empty container if no items are provided.
      return Container();
    }
  }
}
