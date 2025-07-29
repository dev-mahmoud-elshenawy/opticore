part of '../../extensions_import.dart';

extension TextUnderLine on Text {
  /// Adds an underline to the text.
  /// Fix issue especially with arabic text as the line is not connected correctly.
  ///
  /// You can customize the width and color of the underline using the [width] and [underLineColor] parameters.
  ///
  /// Example:
  /// ```dart
  /// Text("Hello").withUnderLine(); // Adds a default underline.
  /// Text("Mahmoud!").withUnderLine(width: 2.0, underLineColor: Colors.red); // Adds a red underline with a width of 2.0.
  /// ```
  Container withUnderLine({
    double width = 1.0,
    Color underLineColor = CoreColors.black,
    void Function()? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: underLineColor,
            width: width,
          ),
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: this,
      ),
    );
  }
}

extension TextSpanUnderLine on TextSpan {
  /// Adds an underline to the text span.
  /// Fix issue especially with arabic text as the line is not connected correctly.
  ///
  /// You can customize the width and color of the underline using the [width] and [underLineColor] parameters.
  ///
  /// Example:
  /// ```dart
  /// TextSpan(text: "Hello").withUnderLine(); // Adds a default underline.
  /// TextSpan(text: "Mahmoud!").withUnderLine(width: 2.0, underLineColor: Colors.red); // Adds a red underline with a width of 2.0.
  /// ```
  WidgetSpan withUnderLine(
      {double width = 1.0,
      Color underLineColor = CoreColors.black,
      void Function()? onTap,
      PlaceholderAlignment? alignment}) {
    return WidgetSpan(
      alignment: alignment ?? PlaceholderAlignment.middle,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: underLineColor,
              width: width,
            ),
          ),
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            text ?? '',
            style: style,
          ),
        ),
      ),
    );
  }
}
