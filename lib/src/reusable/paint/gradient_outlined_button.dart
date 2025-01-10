part of '../reusable_import.dart';

/// A customizable button with a gradient outline. This button allows you to define a
/// gradient color for the outline, specify the corner radius, and set the stroke width of the outline.
/// It also accepts a child widget that will be displayed inside the button, and a callback function
/// that will be triggered when the button is pressed.
///
/// ## Key Features:
/// - Customizable gradient for the button outline.
/// - Adjustable stroke width for the outline.
/// - Adjustable corner radius for rounded edges.
/// - Supports a wide range of child widgets inside the button.
/// - The button reacts to tap gestures and invokes the provided callback on tap.
///
/// ## How to Use:
/// You can use this button anywhere in your widget tree, passing the required parameters like gradient,
/// corner radius, and a callback function. Below is an example of usage:
///
/// ```dart
/// GradientOutlinedButton(
///   strokeWidth: 3.0, // The width of the outline stroke
///   radius: 12.0,     // The radius of the button's corners
///   gradient: LinearGradient( // Define the gradient colors
///     colors: [Colors.blue, Colors.purple],
///     begin: Alignment.topLeft,
///     end: Alignment.bottomRight,
///   ),
///   child: Text('Click Me', style: TextStyle(color: Colors.black)), // The child widget inside the button
///   onPressed: () { // Define the action when the button is pressed
///     print('Button pressed!');
///   },
/// );
/// ```
///
/// ## Constructor Parameters:
/// - `strokeWidth`: Defines the thickness of the button outline.
/// - `radius`: Defines the corner radius of the button for rounded edges.
/// - `gradient`: The gradient that will be applied to the outline of the button. You can use predefined gradients like [LinearGradient], or create your own.
/// - `child`: The widget inside the button (e.g., text, icon, etc.).
/// - `onPressed`: A callback function that is invoked when the button is tapped.
class GradientOutlinedButton extends StatelessWidget {
  final _GradientPainter _painter;
  final Widget? _child;
  final VoidCallback? _callback;
  final double _radius;

  /// Creates a [GradientOutlinedButton] with the specified parameters.
  ///
  /// [strokeWidth] defines the thickness of the outline around the button.
  /// [radius] defines the radius of the button's corners for rounded corners.
  /// [gradient] defines the gradient applied to the outline of the button.
  /// [child] is the widget displayed inside the button.
  /// [onPressed] is the callback function that will be triggered when the button is pressed.
  GradientOutlinedButton({
    super.key,
    required double strokeWidth,
    required double radius,
    required Gradient gradient,
    required Widget child,
    required VoidCallback onPressed,
  })  : _painter = _GradientPainter(
    strokeWidth: strokeWidth,
    radius: radius,
    gradient: gradient,
  ),
        _child = child,
        _callback = onPressed,
        _radius = radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,  // Paint the gradient outline
      child: GestureDetector(
        behavior: HitTestBehavior.translucent, // Ensure the tap detection is translucent over the area
        onTap: _callback, // Trigger the callback when the button is tapped
        child: InkWell(
          borderRadius: BorderRadius.circular(_radius), // Apply rounded corners
          onTap: _callback, // Tap detection callback
          child: Container(
            constraints: const BoxConstraints(minWidth: 88, minHeight: 48), // Minimum button size
            child: Row(
              mainAxisSize: MainAxisSize.min, // Ensure the child widget is centered
              mainAxisAlignment: MainAxisAlignment.center, // Align the child widget in the center
              children: <Widget>[
                _child!, // The child widget inside the button
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A custom painter that draws the gradient outline around the button.
///
/// This painter is responsible for rendering the outer and inner rectangles that form the gradient outline.
/// It handles the drawing of the difference between the outer and inner rectangles to create a button with
/// an outlined gradient. The stroke width and corner radius are applied to both the outer and inner rectangles,
/// and a gradient shader is applied to the outer path to render the colorful outline.
///
/// ## How It Works:
/// - The painter first creates an outer rectangle to match the size of the button.
/// - It then creates an inner rectangle smaller by the stroke width.
/// - The painter applies a gradient shader to the outer rectangle, using the provided gradient parameter.
/// - The painter creates two paths (outer and inner) and combines them to create the outline effect.
/// - Finally, the resulting path is drawn on the canvas to produce the desired gradient outline.

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  /// Creates a [_GradientPainter] to paint the gradient outline on the button.
  ///
  /// [strokeWidth] defines the thickness of the outline stroke.
  /// [radius] defines the corner radius of the outline.
  /// [gradient] is the gradient color applied to the outline of the button.
  _GradientPainter({
    required this.strokeWidth,
    required this.radius,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Create the outer rectangle (same size as the button)
    Rect outerRect = Offset.zero & size;
    var outerRRect = RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // Create the inner rectangle, smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    // Apply the gradient shader to the outer rectangle
    _paint.shader = gradient.createShader(outerRect);

    // Create the difference between the outer and inner paths
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);

    // Draw the gradient outline path
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}