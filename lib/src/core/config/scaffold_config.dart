part of '../base/import/base_import.dart';

/// A configuration class for the [Scaffold] widget in Flutter.
///
/// This class encapsulates all the properties and configurations typically associated
/// with the `Scaffold` widget, enabling a flexible and reusable approach to creating
/// scaffold layouts. It allows you to specify a wide variety of UI elements, such as
/// app bars, floating action buttons, drawers, bottom sheets, and more.
///
/// Example usage:
/// ```dart
/// ScaffoldConfig(
///   appBar: AppBar(title: Text('Home')),
///   floatingActionButton: FloatingActionButton(onPressed: () {}),
///   drawer: Drawer(child: ListView(...)),
///   backgroundColor: Colors.white,
/// );
/// ```
/// The above code creates a `ScaffoldConfig` that configures the `AppBar`, floating action button, drawer, and background color.
///
/// The [toScaffold] method can be used to convert this configuration into a fully constructed
/// `Scaffold` widget with a specified body content.
///
/// Properties:
/// - [key]: The key associated with the `Scaffold` widget.
/// - [appBar]: The app bar displayed at the top of the `Scaffold`.
/// - [floatingActionButton]: The floating action button displayed above the body.
/// - [floatingActionButtonLocation]: The location of the floating action button.
/// - [floatingActionButtonAnimator]: The animation behavior for the floating action button.
/// - [persistentFooterButtons]: A list of widgets to display as persistent footer buttons.
/// - [drawer]: The drawer displayed to the side of the `Scaffold`.
/// - [onDrawerChanged]: A callback invoked when the drawer is opened or closed.
/// - [endDrawer]: The end drawer displayed on the opposite side of the `Scaffold`.
/// - [onEndDrawerChanged]: A callback invoked when the end drawer is opened or closed.
/// - [bottomNavigationBar]: The bottom navigation bar to display.
/// - [bottomSheet]: The bottom sheet to display.
/// - [backgroundColor]: The background color of the `Scaffold`.
/// - [resizeToAvoidBottomInset]: Whether the `Scaffold` should resize when the keyboard appears.
/// - [primary]: Whether the `Scaffold` is the primary scrollable area of the app.
/// - [drawerDragStartBehavior]: The drag behavior for the drawer.
/// - [extendBody]: Whether the body of the `Scaffold` extends into the floating action button area.
/// - [extendBodyBehindAppBar]: Whether the body of the `Scaffold` extends behind the app bar.
/// - [drawerScrimColor]: The scrim color for the drawer when it is open.
/// - [drawerEdgeDragWidth]: The width of the area that triggers the drawer to open.
/// - [drawerEnableOpenDragGesture]: Whether the drawer can be opened with a drag gesture.
/// - [endDrawerEnableOpenDragGesture]: Whether the end drawer can be opened with a drag gesture.
/// - [restorationId]: The restoration ID for state restoration.
class ScaffoldConfig extends Equatable {
  /// The key associated with the Scaffold widget.
  final Key? key;

  /// The app bar displayed at the top of the Scaffold.
  final PreferredSizeWidget? appBar;

  /// The floating action button displayed above the body.
  final Widget? floatingActionButton;

  /// The location of the floating action button.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// The animation behavior for the floating action button.
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// A list of widgets to display as persistent footer buttons.
  final List<Widget>? persistentFooterButtons;

  /// The drawer displayed to the side of the Scaffold.
  final Widget? drawer;

  /// A callback invoked when the drawer is opened or closed.
  final void Function(bool)? onDrawerChanged;

  /// The end drawer displayed on the opposite side of the Scaffold.
  final Widget? endDrawer;

  /// A callback invoked when the end drawer is opened or closed.
  final void Function(bool)? onEndDrawerChanged;

  /// The bottom navigation bar to display.
  final Widget? bottomNavigationBar;

  /// The bottom sheet to display.
  final Widget? bottomSheet;

  /// The background color of the Scaffold.
  final Color? backgroundColor;

  /// Whether the Scaffold should resize when the keyboard appears.
  final bool resizeToAvoidBottomInset;

  /// Whether the Scaffold is the primary scrollable area of the app.
  final bool primary;

  /// The drag behavior for the drawer.
  final DragStartBehavior drawerDragStartBehavior;

  /// Whether the body of the Scaffold extends into the [Scaffold.floatingActionButton] area.
  final bool extendBody;

  /// Whether the body of the Scaffold extends behind the app bar.
  final bool extendBodyBehindAppBar;

  /// The scrim color for the drawer when it is open.
  final Color? drawerScrimColor;

  /// The width of the area that triggers the drawer to open.
  final double? drawerEdgeDragWidth;

  /// Whether the drawer can be opened with a drag gesture.
  final bool drawerEnableOpenDragGesture;

  /// Whether the end drawer can be opened with a drag gesture.
  final bool endDrawerEnableOpenDragGesture;

  /// The restoration ID for state restoration.
  final String? restorationId;

  /// Constructor for [ScaffoldConfig].
  ///
  /// All parameters are optional and provide default values where appropriate. The configuration
  /// allows you to customize the layout and behavior of the `Scaffold` widget in your app.
  const ScaffoldConfig({
    this.key,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
  });

  /// Creates a copy of the current [ScaffoldConfig] with the provided changes.
  ///
  /// This method allows you to create a new [ScaffoldConfig] based on the current configuration
  /// while selectively updating specific properties. This is useful for making incremental
  /// changes to the configuration without modifying the original object.
  ScaffoldConfig copyWith({
    PreferredSizeWidget? appBar,
    Key? key,
    Widget? floatingActionButton,
    FloatingActionButtonLocation? floatingActionButtonLocation,
    FloatingActionButtonAnimator? floatingActionButtonAnimator,
    List<Widget>? persistentFooterButtons,
    Widget? drawer,
    void Function(bool)? onDrawerChanged,
    Widget? endDrawer,
    void Function(bool)? onEndDrawerChanged,
    Widget? bottomNavigationBar,
    Widget? bottomSheet,
    Color? backgroundColor,
    bool? resizeToAvoidBottomInset,
    bool? primary,
    DragStartBehavior? drawerDragStartBehavior,
    bool? extendBody,
    bool? extendBodyBehindAppBar,
    Color? drawerScrimColor,
    double? drawerEdgeDragWidth,
    bool? drawerEnableOpenDragGesture,
    bool? endDrawerEnableOpenDragGesture,
    String? restorationId,
  }) {
    return ScaffoldConfig(
      key: key ?? this.key,
      appBar: appBar ?? this.appBar,
      floatingActionButton: floatingActionButton ?? this.floatingActionButton,
      floatingActionButtonLocation:
          floatingActionButtonLocation ?? this.floatingActionButtonLocation,
      floatingActionButtonAnimator:
          floatingActionButtonAnimator ?? this.floatingActionButtonAnimator,
      persistentFooterButtons:
          persistentFooterButtons ?? this.persistentFooterButtons,
      drawer: drawer ?? this.drawer,
      onDrawerChanged: onDrawerChanged ?? this.onDrawerChanged,
      endDrawer: endDrawer ?? this.endDrawer,
      onEndDrawerChanged: onEndDrawerChanged ?? this.onEndDrawerChanged,
      bottomNavigationBar: bottomNavigationBar ?? this.bottomNavigationBar,
      bottomSheet: bottomSheet ?? this.bottomSheet,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      resizeToAvoidBottomInset:
          resizeToAvoidBottomInset ?? this.resizeToAvoidBottomInset,
      primary: primary ?? this.primary,
      drawerDragStartBehavior:
          drawerDragStartBehavior ?? this.drawerDragStartBehavior,
      extendBody: extendBody ?? this.extendBody,
      extendBodyBehindAppBar:
          extendBodyBehindAppBar ?? this.extendBodyBehindAppBar,
      drawerScrimColor: drawerScrimColor ?? this.drawerScrimColor,
      drawerEdgeDragWidth: drawerEdgeDragWidth ?? this.drawerEdgeDragWidth,
      drawerEnableOpenDragGesture:
          drawerEnableOpenDragGesture ?? this.drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture:
          endDrawerEnableOpenDragGesture ?? this.endDrawerEnableOpenDragGesture,
      restorationId: restorationId ?? this.restorationId,
    );
  }

  /// Converts the configuration into a fully constructed [Scaffold] widget.
  ///
  /// This method uses the current [ScaffoldConfig] to create a `Scaffold` widget and inject
  /// the provided [body] widget as the main content of the scaffold.
  ///
  /// Returns:
  /// - A `Scaffold` widget based on the provided configuration.
  Scaffold toScaffold(Widget body) {
    return Scaffold(
      key: key,
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      persistentFooterButtons: persistentFooterButtons,
      drawer: drawer,
      onDrawerChanged: onDrawerChanged,
      endDrawer: endDrawer,
      onEndDrawerChanged: onEndDrawerChanged,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      primary: primary,
      drawerDragStartBehavior: drawerDragStartBehavior,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      drawerScrimColor: drawerScrimColor,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
      restorationId: restorationId,
    );
  }

  @override
  List<Object?> get props => [
        key,
        appBar,
        floatingActionButton,
        floatingActionButtonLocation,
        floatingActionButtonAnimator,
        persistentFooterButtons,
        drawer,
        onDrawerChanged,
        endDrawer,
        onEndDrawerChanged,
        bottomNavigationBar,
        bottomSheet,
        backgroundColor,
        resizeToAvoidBottomInset,
        primary,
        drawerDragStartBehavior,
        extendBody,
        extendBodyBehindAppBar,
        drawerScrimColor,
        drawerEdgeDragWidth,
        drawerEnableOpenDragGesture,
        endDrawerEnableOpenDragGesture,
        restorationId,
      ];
}
