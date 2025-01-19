part of '../reusable_import.dart';

/// A [GridView] that dynamically adjusts to the height of its children.
///
/// This widget behaves similarly to [GridView.count], but allows for flexible row heights.
/// It ensures that each row's height is determined by its children, providing a more adaptable
/// layout compared to fixed-height grids.
///
class FlexibleGridView extends StatelessWidget {
  /// Creates a [FlexibleGridView].
  ///
  /// [builder] is a function to build each grid item. It receives the context and index of the
  /// item and returns the corresponding widget.
  ///
  /// [itemCount] is the total number of items in the grid.
  ///
  /// [crossAxisCount] is the number of items to display per row.
  ///
  /// [crossAxisSpacing] is the horizontal spacing between items in the same row. Defaults to 8.
  ///
  /// [mainAxisSpacing] is the vertical spacing between rows. Defaults to 8.
  ///
  /// [rowCrossAxisAlignment] defines the alignment of items within the row. Defaults to
  /// [CrossAxisAlignment.start].
  ///
  /// [controller] is an optional [ScrollController] to control the scrolling behavior of the
  /// list view.
  ///
  /// [shrinkWrap] if true, the grid will occupy only as much space as needed by its children.
  /// Defaults to false.
  ///
  /// [physics] is the scroll physics that controls the scroll behavior (e.g., [BouncingScrollPhysics],
  /// [ClampingScrollPhysics], etc.).
  ///
  /// Example usage:
  /// ```dart
  /// FlexibleGridView(
  ///   builder: (context, index) => MyCustomGridItem(index: index),
  ///   itemCount: 20,
  ///   crossAxisCount: 3,
  ///   crossAxisSpacing: 10.0,
  ///   mainAxisSpacing: 10.0,
  ///   shrinkWrap: true,
  /// )
  /// ```
  const FlexibleGridView({
    super.key,
    required this.builder,
    required this.itemCount,
    required this.crossAxisCount,
    this.crossAxisSpacing = 8,
    this.mainAxisSpacing = 8,
    this.rowCrossAxisAlignment = CrossAxisAlignment.start,
    this.controller,
    this.shrinkWrap = false,
    this.physics,
  });

  /// A function to build each grid item.
  final IndexedWidgetBuilder builder;

  /// The total number of items in the grid.
  final int itemCount;

  /// The number of items to display per row.
  final int crossAxisCount;

  /// The horizontal spacing between items in the same row. Defaults to 8.
  final double crossAxisSpacing;

  /// The vertical spacing between rows. Defaults to 8.
  final double mainAxisSpacing;

  /// Defines the alignment of items in the row. Defaults to [CrossAxisAlignment.start].
  final CrossAxisAlignment rowCrossAxisAlignment;

  /// The scroll physics to control the scroll behavior.
  final ScrollPhysics? physics;

  /// A [ScrollController] to control the scrolling of the list view.
  final ScrollController? controller;

  /// If true, the grid will occupy only as much space as needed by its children.
  final bool shrinkWrap;

  /// Calculates the number of rows required for the grid based on the number of columns.
  int get columnLength => (itemCount / crossAxisCount).ceil();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: columnLength,
      // Number of rows
      itemBuilder: (ctx, columnIndex) {
        return _GridRow(
          columnIndex: columnIndex,
          builder: builder,
          itemCount: itemCount,
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisAlignment: rowCrossAxisAlignment,
        );
      },
    );
  }
}

/// A sliver version of [FlexibleGridView] for use with [CustomScrollView].
///
/// This provides the same dynamic grid layout as the original, but is optimized for use inside
/// a [CustomScrollView] with other sliver widgets.
///
/// Example usage:
/// ```dart
/// CustomScrollView(
///   slivers: [
///     SliverFlexibleGridView(
///       builder: (context, index) => MyCustomGridItem(index: index),
///       itemCount: 20,
///       crossAxisCount: 3,
///       crossAxisSpacing: 10.0,
///       mainAxisSpacing: 10.0,
///     ),
///   ],
/// )
/// ```
class SliverFlexibleGridView extends StatelessWidget {
  /// Creates a [SliverFlexibleGridView].
  ///
  /// All parameters are the same as in [FlexibleGridView].
  const SliverFlexibleGridView({
    super.key,
    required this.builder,
    required this.itemCount,
    required this.crossAxisCount,
    this.crossAxisSpacing = 8,
    this.mainAxisSpacing = 8,
    this.rowCrossAxisAlignment = CrossAxisAlignment.start,
    this.controller,
  });

  /// A function to build each grid item.
  final IndexedWidgetBuilder builder;

  /// The total number of items in the grid.
  final int itemCount;

  /// The number of items to display per row.
  final int crossAxisCount;

  /// The horizontal spacing between items in the same row. Defaults to 8.
  final double crossAxisSpacing;

  /// The vertical spacing between rows. Defaults to 8.
  final double mainAxisSpacing;

  /// Defines the alignment of items in the row. Defaults to [CrossAxisAlignment.start].
  final CrossAxisAlignment rowCrossAxisAlignment;

  /// A [ScrollController] to control the scrolling behavior of the list view.
  final ScrollController? controller;

  /// Calculates the number of rows required for the grid based on the number of columns.
  int get columnLength => (itemCount / crossAxisCount).ceil();

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, columnIndex) {
          return _GridRow(
            columnIndex: columnIndex,
            builder: builder,
            itemCount: itemCount,
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisAlignment: rowCrossAxisAlignment,
          );
        },
        childCount: columnLength, // Number of rows
      ),
    );
  }
}

/// Internal widget that displays grid items in a row.
///
/// This widget renders a single row in the grid, alternating between grid items and spacing.
/// It calculates the placement of items and spacing between them.
class _GridRow extends StatelessWidget {
  /// Creates a [GridRow].
  ///
  /// [columnIndex] is the index of the current row.
  ///
  /// [builder] is a function to build each item in the grid.
  ///
  /// [itemCount] is the total number of items in the grid.
  ///
  /// [crossAxisCount] is the number of items per row.
  ///
  /// [crossAxisSpacing] is the horizontal spacing between items in the same row.
  ///
  /// [mainAxisSpacing] is the vertical spacing between rows.
  ///
  /// [crossAxisAlignment] defines the alignment of items in the row.
  const _GridRow({
    required this.columnIndex,
    required this.builder,
    required this.itemCount,
    required this.crossAxisCount,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    required this.crossAxisAlignment,
  });

  /// The builder function to create each grid item.
  final IndexedWidgetBuilder builder;

  /// The total number of items in the grid.
  final int itemCount;

  /// The number of items per row.
  final int crossAxisCount;

  /// The horizontal spacing between items in the same row.
  final double crossAxisSpacing;

  /// The vertical spacing between rows.
  final double mainAxisSpacing;

  /// Defines the alignment of items in the row.
  final CrossAxisAlignment crossAxisAlignment;

  /// The index of the current row.
  final int columnIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: (columnIndex == 0) ? 0 : mainAxisSpacing),
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        children: List.generate(
          crossAxisCount * 2 - 1, // Alternating between items and spacing
          (rowIndex) {
            // For spacing between columns
            if (rowIndex % 2 != 0) return SizedBox(width: crossAxisSpacing);

            final itemIndex = columnIndex * crossAxisCount + rowIndex ~/ 2;

            // If index exceeds itemCount, return empty space
            if (itemIndex >= itemCount) {
              return const Expanded(child: SizedBox());
            }

            // Display the grid item
            return Expanded(child: builder(context, itemIndex));
          },
        ),
      ),
    );
  }
}
