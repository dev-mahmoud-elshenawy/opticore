part of '../reusable_import.dart';

/// A customizable button widget for Flutter that can be used throughout the application.
///
/// The `CoreButton` provides flexibility in terms of design, behavior, and interaction. It allows you to customize various aspects such as the button's appearance, border, color, text, and click behavior.
/// Additionally, it supports dimming functionality to disable interactions when needed.
class CoreButton extends StatelessWidget {
  final double? marginHorizontal;
  final Color? backgroundColor;
  final Color? dimmedBackgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? dimmedTextColor;
  final String? title;
  final Widget? child;
  final Function()? onTap;
  final Function()? onTapCancel;
  final Function(TapDownDetails)? onTapDown;
  final Function(TapUpDetails)? onTapUp;
  final ValueNotifier<bool>? isDimmed;
  final bool? withBorder;
  final double? height;
  final double? width;
  final double? borderRadius;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final EdgeInsetsDirectional? margin;
  final Gradient? gradient;

  /// A customizable button widget for Flutter that can be used throughout the application.
  ///
  /// The `CoreButton` provides flexibility in terms of design, behavior, and interaction. It allows you to customize various aspects such as the button's appearance, border, color, text, and click behavior.
  /// Additionally, it supports dimming functionality to disable interactions when needed.
  ///
  /// ## Key Features:
  /// - **Customizable Appearance**: You can customize the button's height, background color, border color, border radius, and text style.
  /// - **Tap Handling**: The button supports an `onTap` callback function to trigger actions when the button is pressed.
  /// - **Dimming**: It includes a dimming effect when the button is disabled (using `ValueNotifier<bool>`).
  /// - **Border Handling**: Optionally, the button can have a border with customizable color and thickness.
  /// - **Margin and Padding**: The button supports custom margin and padding values for better layout control.
  ///
  /// ## Constructor Parameters:
  /// - [marginHorizontal]: Horizontal margin for the button (default is 0).
  /// - [backgroundColor]: Background color for the button (uses the theme's primary color by default).
  /// - [dimmedBackgroundColor]: Background color when the button is dimmed (default is a lighter version of the background color).
  /// - [borderColor]: Border color for the button (uses the theme's primary color by default).
  /// - [textColor]: Text color for the button label (default is white).
  /// - [dimmedTextColor]: Text color when the button is dimmed (default is a lighter version of the text color).
  /// - [title]: The text to display on the button.
  /// - [child]: A custom widget to display inside the button instead of text.
  /// - [onTap]: The callback function to execute when the button is tapped.
  /// - [onTapDown]: The callback function to execute when the button is pressed down.
  /// - [onTapCancel]: The callback function to execute when the button tap is canceled.
  /// - [onTapUp]: The callback function to execute when the button tap is released.
  /// - [isDimmed]: A `ValueNotifier<bool>` used to control whether the button is dimmed or not, making it disabled.
  /// - [withBorder]: A boolean value to specify whether the button should have a border.
  /// - [height]: Height of the button.
  /// - [width]: Width of the button.
  /// - [borderRadius]`: Border radius for the button to give rounded corners.
  /// - [textStyle]: Custom text style for the button's title.
  /// - [padding]: Padding inside the button for the text.
  /// - [margin]: The margin around the button.
  /// - [gradient]: A gradient to apply to the button's background.
  ///
  /// ## How to Use:
  /// The `CoreButton` widget can be used wherever you need a customizable button in your app. It allows you to provide a callback for button presses, along with the ability to customize the appearance and behavior of the button.
  ///
  /// Example usage:
  /// ```dart
  /// CoreButton(
  ///   title: 'Click Me',
  ///   onTap: () {
  ///     print('Button tapped!');
  ///   },
  ///   backgroundColor: Colors.blue,
  ///   textColor: Colors.white,
  ///   borderRadius: 20.0,
  /// ),
  /// ```
  const CoreButton({
    super.key,
    this.marginHorizontal,
    this.backgroundColor,
    this.dimmedBackgroundColor,
    this.borderColor,
    this.textColor,
    this.dimmedTextColor,
    this.title,
    this.child,
    this.onTap,
    this.onTapDown,
    this.onTapCancel,
    this.onTapUp,
    this.isDimmed,
    this.withBorder,
    this.height,
    this.width,
    this.borderRadius,
    this.textStyle,
    this.padding,
    this.margin,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ValueListenableBuilder(
      valueListenable: isDimmed ?? ValueNotifier(false),
      builder: (context, bool dimmed, child) {
        return InkWell(
          splashColor: Colors.transparent,
          onTap: !dimmed ? onTap : null,
          // Only triggers onTap if the button is not dimmed
          onTapDown: !dimmed ? onTapDown : null,
          onTapCancel: !dimmed ? onTapCancel : null,
          onTapUp: !dimmed ? onTapUp : null,
          child: Container(
            height: height ?? 48,
            // Default height if not specified
            width: width ?? double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius ?? 40),
              // Rounded corners
              color: (!dimmed
                      ? backgroundColor
                      : dimmedBackgroundColor ??
                          backgroundColor?.withValues(alpha: 0.5)) ??
                  (!dimmed
                      ? theme
                          .primaryColor // Default background color if not specified
                      : dimmedBackgroundColor ??
                          theme.primaryColor.withValues(alpha: 0.5)),
              // Dimming effect
              border: (withBorder ?? false)
                  ? Border.all(
                      color: (borderColor ??
                          (!dimmed
                              ? theme
                                  .primaryColor // Default border color if not specified
                              : dimmedBackgroundColor ??
                                  theme.primaryColor.withValues(alpha: 0.5))),
                    )
                  : null,
              gradient: gradient,
            ),
            padding: padding ?? const EdgeInsets.all(10),
            // Default padding
            margin: margin ??
                EdgeInsets.symmetric(horizontal: marginHorizontal ?? 0),
            // Default margin
            child: this.child ??
                Center(
                  child: Text(
                    title ?? "", // Text to display
                    style: textStyle ??
                        TextStyle(
                          color: (!dimmed
                                  ? textColor
                                  : dimmedTextColor ?? textColor) ??
                              Colors.white,
                          // Default text color is white
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center, // Centered text
                  ),
                ),
          ),
        );
      },
    );
  }
}
