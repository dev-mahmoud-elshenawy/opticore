part of '../../extensions_import.dart';

extension DirectionalityExtension on Widget {
  /// Wraps the current widget in a [Directionality] widget with [TextDirection.ltr].
  ///
  /// Example:
  /// ```dart
  /// Text('Hello Mahmoud').ltr;
  /// ```
  Widget get ltr {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: this,
    );
  }

  /// Wraps the current widget in a [Directionality] widget with [TextDirection.rtl].
  ///
  /// Example:
  /// ```dart
  /// Text('مرحبا محمود').rtl;
  /// ```
  Widget get rtl {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: this,
    );
  }
}
