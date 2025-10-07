part of '../config_import.dart';

/// [CoreSetup] is a widget responsible for initializing and configuring essential global settings for the application.
/// It manages core aspects such as the theme, localization, routing, and screens for handling errors like Maintenance,
/// No Internet, and Not Found pages. This widget is typically used as the root widget to ensure the application is set up
/// with the correct configurations and runs smoothly with the desired settings.
///
/// The [CoreSetup] widget facilitates customization for error screens, allowing developers to display custom content or
/// behaviors when the app encounters maintenance mode, no internet connection, or missing pages.
///
/// **Constructor Parameters:**
/// - [appConfig]: The configuration object that contains the global settings for the app. This includes theme data,
///   localization delegates, initial routes, and more. This parameter is **required** and ensures the app is initialized
///   with consistent settings.
///   Example:
///   ```dart
///   AppConfig(
///     theme: lightTheme,
///     appTitle: 'My App',
///     initialRoute: '/home',
///   )
///   ```
///   - [prepConfig] (optional): A callback function that runs before applying the configurations. This can be used
///   to perform any necessary setup or initialization tasks before the app configurations are applied.
///   Example:
///   ```dart
///   onBeforeConfigApply: () async {
///   await Firebase.initializeApp();
///   },
///   ```
class CoreSetup extends StatefulWidget {
  /// The configuration object that holds the global settings for the application.
  /// This includes theme, localization, supported locales, and route settings.
  ///
  /// This parameter is **required** to set up the app properly.
  final AppConfig appConfig;

  /// A callback to handle Firebase or other initialization before configurations are applied.
  final Future<void> Function()? prepConfig;

  /// Constructor for initializing the `CoreSetup` widget with app configurations.
  const CoreSetup({
    super.key,
    required this.appConfig,
    this.prepConfig,
  });

  @override
  State<CoreSetup> createState() => _CoreSetupState();
}

class _CoreSetupState extends State<CoreSetup> with AfterLayoutMixin {
  /// Function to initialize BotToast for displaying toast notifications in the app.
  ///
  /// This builder wraps widgets in the app and allows toast notifications to appear.
  final Function(BuildContext, Widget?) defaultBotToastBuilder = BotToastInit();

  /// Initializes the configurations for the app, including custom error screens.
  ///
  /// This method is called after the first layout to ensure the app is fully initialized.
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _initializeConfigurations();
      }
    });
  }

  /// Initializes Firebase or other resources and then applies custom configurations.
  Future<void> _initializeConfigurations() async {
    if (widget.prepConfig != null) {
      await widget.prepConfig!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside the text fields.
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp(
        theme: widget.appConfig.theme,
        scrollBehavior:
            widget.appConfig.scrollBehavior ?? ScrollBehaviorHelper(),
        scaffoldMessengerKey: widget.appConfig.scaffoldMessengerKey,
        title: widget.appConfig.appTitle ?? 'OptiCore',
        locale: widget.appConfig.locale,
        builder: (context, child) {
          // Apply the BotToast builder for toast notifications, if provided.
          child = defaultBotToastBuilder(context, child);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0),
            ),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          ...?widget.appConfig.localizationsDelegates,
        ],
        supportedLocales: [
          ...?widget.appConfig.supportedLocales,
        ],
        initialRoute: widget.appConfig.initialRoute ?? '/',
        // Default to '/' if no initial route is provided.
        onGenerateRoute: (settings) {
          // Use custom route generation logic, if provided.
          final customRoute = widget.appConfig.onGenerateRoute?.call(settings);

          if (customRoute != null) {
            return customRoute;
          }

          // Return null to fall back to the default route handler.
          return null;
        },
        navigatorKey: RouteHelper.navigatorKey,
        navigatorObservers: [
          ...?widget.appConfig.navigatorObservers,
          // Include custom observers like RouteObserver, BotToastNavigatorObserver and LoggerRouterObserver.
          RouteHelper.routeObserver,
          BotToastNavigatorObserver(),
          LoggerRouterObserver(),
        ],
        onUnknownRoute:
            widget.appConfig.onUnknownRoute ?? _defaultRouteGenerator,
        showPerformanceOverlay:
            widget.appConfig.showPerformanceOverlay ?? false,
        showSemanticsDebugger: widget.appConfig.showSemanticsDebugger ?? false,
        checkerboardRasterCacheImages:
            widget.appConfig.checkerboardRasterCacheImages ?? false,
        checkerboardOffscreenLayers:
            widget.appConfig.checkerboardOffscreenLayers ?? false,
      ),
    );
  }

  /// Default route generator used when an unknown route is requested.
  ///
  /// This function returns a route to the NotFoundScreen to handle missing pages or invalid routes.
  Route<dynamic> _defaultRouteGenerator(RouteSettings settings) {
    return context.routeBuilder(NotFoundScreen());
  }
}
