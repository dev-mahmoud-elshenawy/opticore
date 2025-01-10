part of '../reusable_import.dart';

/// An abstract class representing a line, which can be used for custom drawing in the [AdvancedLine] widget.
abstract class Line {}

/// A solid line type, extending [Line]. It represents a simple continuous line.
class SolidLine extends Line {}

/// A dotted line type, extending [Line]. It represents a line made up of dots with a customizable gap size between them.
class DottedLine extends Line {
  final double? gapSize;

  /// Creates a [DottedLine] with an optional [gapSize] parameter.
  ///
  /// [gapSize] controls the distance between the dots.
  /// If not provided, the default gap size is 10.0.
  DottedLine({
    this.gapSize,
  });
}

/// A widget that renders a customizable line, which can be solid or dotted, in either horizontal or vertical orientation.
///
/// It can render a line with a custom [Paint] definition and direction [Axis].
/// The line type (either [SolidLine] or [DottedLine]) can be passed to the widget to control the appearance of the line.
///
/// ## Usage Example:
/// ```dart
/// AdvancedLine(
///   direction: Axis.horizontal, // Direction of the line (horizontal or vertical)
///   line: SolidLine(),          // Use SolidLine for a continuous line
///   paintDef: Paint()           // Customize the line's appearance (color, width, etc.)
/// );
///
/// AdvancedLine(
///   direction: Axis.vertical,  // Direction of the line (horizontal or vertical)
///   line: DottedLine(gapSize: 5.0), // Use DottedLine with a custom gap size
///   paintDef: Paint()           // Customize the dotted line's appearance (color, width, etc.)
/// );
/// ```
class AdvancedLine extends StatelessWidget {
  final Axis? direction;
  final Line? line;
  final Paint? paintDef;

  /// Creates an [AdvancedLine] widget with customizable line type and direction.
  ///
  /// [direction] defines whether the line is horizontal or vertical.
  /// [line] specifies the type of line (solid or dotted).
  /// [paintDef] provides customization for the paint (e.g., color, stroke width).
  const AdvancedLine({
    super.key,
    required this.direction,
    required this.line,
    this.paintDef,
  });

  @override
  Widget build(BuildContext context) {
    Paint paint = paintDef ?? Paint();
    Row lineWrapper = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            height: paint.strokeWidth,
            child: CustomPaint(
              painter: LinePainter(
                line: line!,
                paintDef: paint,
              ),
            ),
          ),
        ),
      ],
    );

    // Rotate the line if it's vertical
    if (direction == Axis.horizontal) {
      return lineWrapper;
    } else {
      return RotatedBox(
        quarterTurns: 1,
        child: lineWrapper,
      );
    }
  }
}

/// A [CustomPainter] class that draws a line (solid or dotted) on a canvas.
///
/// The [LinePainter] class handles the logic for drawing the line based on the type (solid or dotted) and the paint definition.
///
/// ## Usage:
/// This class is used internally by the [AdvancedLine] widget to render the line on the screen.
class LinePainter extends CustomPainter {
  final Line? line;
  final Paint? paintDef;

  const LinePainter({
    required this.line,
    this.paintDef,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (paintDef == null || paintDef!.strokeWidth < 0.0) return;

    double width = size.width;

    // Determine which line type to draw: solid or dotted
    switch (line.runtimeType) {
      case SolidLine:
        {
          _drawSolidLine(canvas, width, paintDef!);
          break;
        }
      case DottedLine:
        {
          if (paintDef!.strokeWidth <= 0.0) paintDef!.strokeWidth = 1.0;
          if (paintDef!.strokeWidth >= width) {
            return _drawSolidLine(canvas, width, paintDef!);
          }

          double gapSize = (line as DottedLine).gapSize ?? 10.0;
          if (gapSize >= width) return;

          _drawDottedLine(canvas, width, paintDef!, gapSize);
          break;
        }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  /// Draws a solid line.
  void _drawSolidLine(Canvas canvas, double width, Paint paintDef) {
    double strokeVerticalOverflow = paintDef.strokeWidth / 2;
    double strokeHorizontalOverflow =
        paintDef.strokeCap == StrokeCap.butt ? 0.0 : strokeVerticalOverflow;

    // Draw the solid line
    canvas.drawLine(
      Offset(strokeHorizontalOverflow, strokeVerticalOverflow),
      Offset(width - strokeHorizontalOverflow, strokeVerticalOverflow),
      paintDef,
    );
  }

  /// Draws a dotted line.
  void _drawDottedLine(
    Canvas canvas,
    double width,
    Paint paintDef,
    double gapSize,
  ) {
    double pointSize = paintDef.strokeWidth;
    double strokeVerticalOverflow = pointSize / 2;

    double jointSize = pointSize + gapSize;
    double leapSize = (width + gapSize) % jointSize;

    double position = strokeVerticalOverflow + leapSize / 2;
    List<Offset> points = [];

    // Create the dotted line by adding points at intervals
    do {
      points.add(Offset(position, strokeVerticalOverflow));
    } while ((position += jointSize) <= width);

    // Draw the points
    canvas.drawPoints(PointMode.lines, points, paintDef);
  }
}
