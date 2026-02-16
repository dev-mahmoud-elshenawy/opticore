part of '../config_import.dart';

/// [AppConfig] is a configuration class used to define global settings for the app.
/// It holds various properties related to theming, localization, routing, and performance settings.
/// This class is designed to be passed into the `CoreSetup` widget to configure the application
/// at a high level. It allows developers to customize various aspects of the app's appearance,
/// behavior, and debugging settings.
///
/// This configuration class facilitates setting up key app settings such as themes, localization,
/// routing behavior, and debugging tools. It provides a flexible and scalable way to manage app-wide settings
/// by using optional parameters. Each parameter serves a specific purpose, allowing developers to fine-tune
/// the user experience and ensure optimal performance across different app configurations.
///
/// **Constructor Parameters:**
/// - [theme]: The theme data for the app, allowing customization of the app's visual style. If not provided,
///   the app will use the default system theme.
/// - [appTitle]: The title of the app, which is displayed in the `MaterialApp` widget.
/// - [localizationsDelegates]: A list of localization delegates for enabling multi-language support.
/// - [supportedLocales]: A list of locales supported by the app for localization purposes.
/// - [initialRoute]: The initial route to navigate to when the app is launched. If not provided, the app
///   will use the default `/` route.
/// - [onGenerateRoute]: A custom function for generating routes based on the app's needs. Useful for handling
///   dynamic routes or adding route parameters.
/// - [navigatorObservers]: A list of navigator observers that track navigation events in the app. These can
///   be used for logging, analytics, or custom behavior based on navigation.
/// - [color]: The primary color of the app, typically used in app icons and UI elements for branding purposes.
/// - [onUnknownRoute]: A custom handler for unknown routes that do not match any defined routes. Useful for
///   providing a fallback route when the user navigates to an undefined path.
/// - [showPerformanceOverlay]: A flag to enable or disable the performance overlay for debugging. This overlay
///   displays performance metrics such as frame rendering times, helping developers monitor the app's performance.
/// - [showSemanticsDebugger]: A flag to enable or disable the semantics debugger for accessibility testing.
///   This is useful for developers who want to ensure the app is accessible to all users, particularly those
///   using screen readers.
/// - [checkerboardRasterCacheImages]: A flag to enable or disable the checkerboard raster cache images for
///   debugging. This feature helps to identify performance bottlenecks related to rasterization of images.
/// - [checkerboardOffscreenLayers]: A flag to enable or disable the checkerboard offscreen layers for debugging.
/// - [scrollBehavior]: The scroll behavior for the app, allowing customization of the scrolling behavior.
/// - [scaffoldMessengerKey]: The key for the scaffold messenger, which is used to show snack bars and other messages.
///   This helps to detect issues with offscreen rendering layers, such as those involved in animations or scrolling.
class AppConfig extends Equatable {
  /// The app theme, which is customizable.
  /// If not provided, the app will use the default system theme.
  final ThemeData? theme;

  /// The app's title for the `MaterialApp` widget.
  /// This title is displayed in the app bar and other places where the app title is needed.
  final String? appTitle;

  /// Custom localization delegates for multi-language support.
  /// This allows the app to support different languages and regions.
  final List<LocalizationsDelegate>? localizationsDelegates;

  /// Supported locales for localization.
  /// These locales determine the available languages and regions for the app.
  final List<Locale>? supportedLocales;

  /// The initial route to navigate to when the app is launched.
  /// If not provided, the app will use the default `/` route.
  final String? initialRoute;

  /// A function to define custom route generation.
  /// This is useful for handling dynamic routes or adding route parameters.
  final RouteFactory? onGenerateRoute;

  /// The navigator observers for tracking navigation events.
  /// These can be used for logging, analytics, or custom behavior based on navigation.
  final List<NavigatorObserver>? navigatorObservers;

  /// Primary color for the app. This is typically used for branding purposes.
  final Color? color;

  /// A handler for unknown routes.
  /// This function is called when the app encounters a route that doesn't match any predefined routes.
  final RouteFactory? onUnknownRoute;

  /// Flag to show the performance overlay for debugging.
  /// This overlay displays performance metrics such as frame rendering times.
  final bool? showPerformanceOverlay;

  /// Flag to enable the semantics debugger for accessibility.
  /// This is useful for developers who want to ensure the app is accessible to all users.
  final bool? showSemanticsDebugger;

  /// Flag to enable raster cache checkerboard for debugging.
  /// This helps to identify performance bottlenecks related to rasterization.
  final bool? checkerboardRasterCacheImages;

  /// Flag to enable offscreen layer checkerboard for debugging.
  /// This is useful for detecting issues with offscreen rendering layers.
  final bool? checkerboardOffscreenLayers;

  /// The scroll behavior for the app.
  /// This allows customizing the scroll behavior of the app.
  final MaterialScrollBehavior? scrollBehavior;

  /// The key for the scaffold messenger.
  /// This key can be used to show snack bars and other messages.
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  /// The current locale of the app.
  /// This locale determines the language and region settings for the app.
  final Locale? locale;

  /// An optional builder that wraps the widget tree after the internal BotToast
  /// and MediaQuery setup. Use this to inject root-level wrappers such as
  /// providers, overlays, or custom themes.
  final TransitionBuilder? builder;

  /// Constructor for the [AppConfig] class. Initializes the configuration properties.
  const AppConfig({
    this.theme,
    this.appTitle,
    this.localizationsDelegates,
    this.supportedLocales,
    this.initialRoute,
    this.onGenerateRoute,
    this.navigatorObservers,
    this.color,
    this.onUnknownRoute,
    this.showPerformanceOverlay,
    this.showSemanticsDebugger,
    this.checkerboardRasterCacheImages,
    this.checkerboardOffscreenLayers,
    this.scrollBehavior,
    this.scaffoldMessengerKey,
    this.locale,
    this.builder,
  });

  @override
  List<Object?> get props => [
        theme,
        appTitle,
        localizationsDelegates,
        supportedLocales,
        initialRoute,
        onGenerateRoute,
        navigatorObservers,
        color,
        onUnknownRoute,
        showPerformanceOverlay,
        showSemanticsDebugger,
        checkerboardRasterCacheImages,
        checkerboardOffscreenLayers,
        scrollBehavior,
        scaffoldMessengerKey,
        locale,
        builder,
      ];
}
