part of '../base/import/base_import.dart';

/// A configuration class for customizing the `AppBar` widget.
///
/// This class allows you to configure the appearance and behavior of the `AppBar`
/// widget in a Flutter application. It provides various properties to control the title,
/// actions, colors, and other UI elements of the `AppBar`. You can customize the standard
/// back, share, filter, and search buttons, or replace them with custom widgets.
///
/// **Example usage:**
/// ```dart
/// AppBarConfig(
///   title: 'Home',
///   centerTitle: true,
///   hasBack: true,
///   actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
///   shareAction: () => print('Share pressed!'),
///   backgroundColor: Colors.blue,
/// )
/// ```
/// This example configures an `AppBar` with a title, a back button, a search action, and a custom background color.
///
/// **Constructor Parameters:**
/// - [title]: The title to display in the `AppBar`. If not provided, the title is not set.
/// - [titleStyle]: The style to apply to the title text. If not provided, the default style is used.
/// - [iconTheme]: Customizes the icons in the `AppBar`. If not provided, the default icon theme is used.
/// - [centerTitle]: Whether to center the title. Default is `false`.
/// - [hasBack]: If true, displays a back button in the leading section of the `AppBar`. Default is `false`.
/// - [hasShare]: If true, shows a share button. Default is `false`.
/// - [hasFilter]: If true, shows a filter button. Default is `false`.
/// - [hasSearch]: If true, shows a search button. Default is `false`.
/// - [automaticallyImplyLeading]: If true, implies a leading widget (back button). Default is `false`.
/// - [customShare]: Custom widget to replace the default share button. Default is `null`.
/// - [customFilter]: Custom widget to replace the default filter button. Default is `null`.
/// - [customSearch]: Custom widget to replace the default search button. Default is `null`.
/// - [actions]: A list of additional actions to show in the `AppBar`. These will appear on the right side of the `AppBar`. Default is `null`.
/// - [backgroundColor]: The background color of the `AppBar`. If not provided, the default color is used.
/// - [surfaceTintColor]: A tint color applied to the surface of the `AppBar`. If not provided, the default color is used.
/// - [shareAction]: A callback to execute when the share button is pressed. Default is `null`.
/// - [filterAction]: A callback to execute when the filter button is pressed. Default is `null`.
/// - [searchAction]: A callback to execute when the search button is pressed. Default is `null`.
/// - [customBack]: A custom widget to replace the default back button. Default is `null`.
/// - [customIconBack]: A custom widget to replace the default back icon. Default is `null`.
/// - [iconColor]: The color of the icon. If not provided, the default color is used.
/// - [iconBackgroundColor]: The background color of the icon. If not provided, the default color is used.
class AppBarConfig extends Equatable {
  /// The title displayed in the `AppBar`.
  ///
  /// If null, the title will not be set. The default value is null.
  final String? title;

  /// The text style applied to the `title`.
  ///
  /// If null, the default style will be used. The default value is null.
  final TextStyle? titleStyle;

  /// The icon theme to apply to the icons in the `AppBar`.
  ///
  /// If null, the default icon theme will be used. The default value is null.
  final IconThemeData? iconTheme;

  /// Whether the `AppBar`'s title should be centered.
  ///
  /// If true, the title will be centered. The default value is null (false).
  final bool? centerTitle;

  /// Whether to show the back button in the leading section.
  ///
  /// If true, a back button will be displayed. The default value is null (false).
  final bool? hasBack;

  /// Whether to show the share button in the `AppBar`.
  ///
  /// If true, a share button will be displayed. The default value is null (false).
  final bool? hasShare;

  /// Whether to show the filter button in the `AppBar`.
  ///
  /// If true, a filter button will be displayed. The default value is null (false).
  final bool? hasFilter;

  /// Whether to show a search button in the `AppBar`.
  ///
  /// If true, a search button will be displayed. The default value is null (false).
  final bool? hasSearch;

  /// Whether to automatically imply a leading widget (such as a back button).
  ///
  /// If true, the leading widget is implied. The default value is null (false).
  final bool? automaticallyImplyLeading;

  /// A custom widget to replace the default share button in the `AppBar`.
  ///
  /// If null, the default share button will be used. The default value is null.
  final Widget? customShare;

  /// A custom widget to replace only the default back icon in the `AppBar`.
  ///
  /// If null, the default back icon will be used. The default value is null.
  final Widget? customIconBack;

  /// A custom widget to replace the whole back button in the `AppBar`.
  ///
  /// If null, the default back button will be used. The default value is null.
  final Widget? customBack;

  /// A custom widget to replace the default filter button in the `AppBar`.
  ///
  /// If null, the default filter button will be used. The default value is null.
  final Widget? customFilter;

  /// A custom widget to replace the default search button in the `AppBar`.
  ///
  /// If null, the default search button will be used. The default value is null.
  final Widget? customSearch;

  /// A list of custom actions to display in the `AppBar`.
  ///
  /// The actions will be shown on the right side of the `AppBar`. The default value is null.
  final List<Widget>? actions;

  /// The background color of the `AppBar`.
  ///
  /// If null, the default background color will be used. The default value is null.
  final Color? backgroundColor;

  /// The color of the icon.
  ///
  /// If null, the default icon color will be used. The default value is null.
  final Color? iconColor;

  /// The background color of the icon.
  ///
  /// If null, the default icon background color will be used. The default value is null.
  final Color? iconBackgroundColor;

  /// The surface tint color applied to the `AppBar`.
  ///
  /// If null, the default surface tint color will be used. The default value is null.
  final Color? surfaceTintColor;

  /// A callback function to execute when the share button is pressed.
  ///
  /// If null, no action will be performed. The default value is null.
  final Function()? shareAction;

  /// A callback function to execute when the filter button is pressed.
  ///
  /// If null, no action will be performed. The default value is null.
  final Function()? filterAction;

  /// A callback function to execute when the search button is pressed.
  ///
  /// If null, no action will be performed. The default value is null.
  final Function()? searchAction;

  /// Constructor for [AppBarConfig].
  ///
  /// Allows the configuration of all properties of the `AppBar`.
  ///
  /// [title] → The title displayed in the `AppBar`. Default is null.
  ///
  /// [titleStyle] → The text style for the title. Default is null.
  ///
  /// [iconTheme] → The icon theme for icons in the `AppBar`. Default is null.
  ///
  /// [centerTitle] → Whether to center the title. Default is null (false).
  ///
  /// [hasBack] → Whether to show a back button in the leading section. Default is null (false).
  ///
  /// [hasShare] → Whether to show a share button. Default is null (false).
  ///
  /// [hasFilter] → Whether to show a filter button. Default is null (false).
  ///
  /// [hasSearch] → Whether to show a search button. Default is null (false).
  ///
  /// [automaticallyImplyLeading] → Whether to automatically imply a leading widget. Default is null (false).
  ///
  /// [customBack] -> A custom widget for the back button. Default is null.
  ///
  /// [customBack] -> A custom widget for the back icon. Default is null.
  ///
  /// [customShare] → A custom widget for the share button. Default is null.
  ///
  /// [customFilter] → A custom widget for the filter button. Default is null.
  ///
  /// [customSearch] → A custom widget for the search button. Default is null.
  ///
  /// [actions] → A list of custom actions to display in the `AppBar`. Default is null.
  ///
  /// [backgroundColor] → The background color of the `AppBar`. Default is null.
  ///
  /// [iconColor] → The color of the icon. Default is null.
  ///
  /// [iconBackgroundColor] → The background color of the icon. Default is null.
  ///
  /// [surfaceTintColor] → The surface tint color of the `AppBar`. Default is null.
  ///
  /// [shareAction] → A callback for the share button action. Default is null.
  ///
  /// [filterAction] → A callback for the filter button action. Default is null.
  ///
  /// [searchAction] → A callback for the search button action. Default is null.
  const AppBarConfig({
    this.title,
    this.titleStyle,
    this.iconTheme,
    this.centerTitle,
    this.hasBack,
    this.hasShare,
    this.hasFilter,
    this.hasSearch,
    this.automaticallyImplyLeading,
    this.customBack,
    this.customIconBack,
    this.customShare,
    this.customFilter,
    this.customSearch,
    this.actions,
    this.backgroundColor,
    this.surfaceTintColor,
    this.shareAction,
    this.filterAction,
    this.searchAction,
    this.iconColor,
    this.iconBackgroundColor,
  });

  @override
  List<Object?> get props => [
        title,
        titleStyle,
        iconTheme,
        centerTitle,
        hasBack,
        hasShare,
        hasFilter,
        hasSearch,
        automaticallyImplyLeading,
        customBack,
        customShare,
        customFilter,
        customSearch,
        actions,
        backgroundColor,
        surfaceTintColor,
        shareAction,
        customIconBack,
        filterAction,
        searchAction,
        iconColor,
        iconBackgroundColor,
      ];
}
