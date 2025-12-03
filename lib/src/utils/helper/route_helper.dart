part of '../util_import.dart';

/// A service that encapsulates navigation logic, making it easier to manage routing
/// within the application. This class provides methods to push, replace, and pop routes
/// on the navigation stack, as well as to remove routes based on certain conditions.
///
/// The `RouteHelper` class abstracts the complexity of navigation, providing a centralized
/// interface to manage app navigation actions programmatically. It integrates with the Flutter
/// navigation system and allows navigation operations to be triggered from anywhere in the app,
/// including non-widget classes, services, or BLoCs.
///
/// **Main Features:**
/// - Push and pop routes with both widget and named route options.
/// - Replace the current screen with a new screen or named route.
/// - Remove routes from the stack, allowing for a clean navigation experience.
/// - Control route stack operations programmatically, including managing the state of the navigation stack.
///
/// This class is intended to be used with a `BuildContext` for navigation within widget trees, but it also
/// includes a static `navigatorKey` to allow navigation control outside of the widget tree (e.g., from services).
///
/// ## Included Methods:
/// - [push]: Pushes a new screen onto the navigation stack.
/// - [pushNamed]: Pushes a new screen using a named route.
/// - [pushReplacement]: Replaces the current screen with a new screen.
/// - [pushReplacementNamed]: Replaces the current screen with a new named route.
/// - [pushAndRemoveUntil]: Pushes a new screen and removes all previous routes up to the provided path.
/// - [pushNamedAndRemoveUntil]: Pushes a new named route and removes all previous routes up to the provided path.
/// - [pop]: Pops the current route off the stack, optionally returning a result to the previous screen.
/// - [canPop]: Determines whether the current route can be popped from the navigation stack.
/// - [navigatorKey]: A global key to access the navigator state of the application.
/// - [previousRoute]: Holds the name of the previous route.
/// - [builder]: Default route settings for the navigator.
///
/// Example usage:
/// ```dart
/// RouteHelper(navigatorKey.currentContext).pushNamed('/home');
/// ```
class RouteHelper {
  final BuildContext context;

  /// A global key used to access the navigator state of the application.
  ///
  /// The `navigatorKey` allows for navigation actions outside the widget tree,
  /// such as navigating from a service, bloc, or any other non-widget class
  /// that needs to trigger navigation.
  ///
  /// This key is essential for managing navigation in apps that require
  /// control over the navigation stack from outside the widget hierarchy.
  /// It can be used for pushing routes, popping routes, and performing
  /// other navigation actions programmatically.
  ///
  /// Example usage:
  /// ```dart
  /// navigatorKey.currentState?.pushNamed('/someRoute');
  /// ```
  ///
  /// This global key is typically passed to the `MaterialApp` or `CupertinoApp`
  /// widget through the `navigatorKey` property to manage navigation throughout
  /// the app.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// A global RouteObserver to track route lifecycle events.
  ///
  /// This observer allows widgets to be notified when they are pushed, popped,
  /// or when another route is pushed on top of them or popped from above them.
  ///
  /// It's used in conjunction with the RouteAware mixin to handle status bar
  /// and other UI state updates during navigation.
  ///
  /// Example usage:
  /// ```dart
  /// class MyScreen extends State<MyWidget> with RouteAware {
  ///   @override
  ///   void didChangeDependencies() {
  ///     super.didChangeDependencies();
  ///     RouteHelper.routeObserver.subscribe(this, ModalRoute.of(context)!);
  ///   }
  ///
  ///   @override
  ///   void dispose() {
  ///     RouteHelper.routeObserver.unsubscribe(this);
  ///     super.dispose();
  ///   }
  /// }
  /// ```
  static final RouteObserver<ModalRoute<dynamic>> routeObserver =
      RouteObserver<ModalRoute<dynamic>>();

  /// Holds the name of the previous route.
  static String? previousRoute;

  /// Gets the name of the current route.
  ///
  /// Returns the name of the current route from the navigation stack.
  /// If no route is active or the navigator is not available, returns null.
  ///
  /// **Example:**
  /// ```dart
  /// final currentRouteName = RouteHelper.currentRoute;
  /// print('Current route: $currentRouteName');
  /// ```
  static String? get currentRoute {
    final route = navigatorKey.currentState?.overlay?.context;
    if (route != null) {
      return ModalRoute.of(route)?.settings.name;
    }
    return null;
  }

  /// The default route settings for the navigator.
  ///
  /// This is used to provide default settings for the navigator when
  /// navigating to a new screen. It includes the name of the route,
  /// the arguments passed to the route, and any other settings that
  /// are required for the navigation operation.
  ///
  /// **Example:**
  /// ```dart
  /// final routeSettings = RouteSettings(
  ///  name: '/home',
  ///  arguments: {'user': user},
  ///  isInitialRoute: true,
  ///  );
  static PageRoute builder(
    Widget scene, {
    bool maintainState = true,
    RouteSettings? settings,
  }) =>
      navigatorKey.currentContext!.routeBuilder(
        scene,
        settings: settings,
        maintainState: maintainState,
      );

  /// Constructor to initialize the RouteHelper with a [BuildContext].
  /// The [BuildContext] is required to perform navigation operations.
  RouteHelper(this.context);

  /// Pushes a new screen onto the navigation stack.
  ///
  /// This method allows navigation to a new screen while optionally maintaining the state of the current screen.
  /// By default, the state is maintained, but this can be changed by setting [maintainState] to false.
  ///
  /// [screen] - The widget to be displayed in the new route.
  /// [maintainState] - A boolean value that specifies whether to maintain the current state.
  ///    Defaults to true.
  ///
  /// Returns a Future with the result of the navigation action.
  ///
  /// **Example:**
  /// ```dart
  /// RouteHelper(context).push(NewScreen());
  /// ```
  Future<dynamic> push(
    Widget screen, {
    bool maintainState = true,
  }) {
    return context.push(screen, maintainState: maintainState);
  }

  /// Pushes a new screen onto the navigation stack using a named route.
  ///
  /// Named routes are typically used when you need to navigate to a predefined screen,
  /// with optional arguments that can be passed to the target screen.
  ///
  /// [screenName] - The name of the route to navigate to.
  /// [arguments] - Optional arguments to pass to the target route.
  ///
  /// Returns a Future with the result of the navigation action.
  ///
  /// **Example:**
  /// ```dart
  /// RouteHelper(context).pushNamed('/home', arguments: {'user': user});
  /// ```
  Future<dynamic> pushNamed(String screenName, {Object? arguments}) {
    return context.pushNamed(screenName, arguments: arguments);
  }

  /// Replaces the current screen with a new screen.
  ///
  /// This method allows navigation to a new screen, while removing the current screen from the navigation stack.
  /// Similar to [push], but the current screen is replaced, and the previous screen is no longer accessible.
  ///
  /// [screen] - The widget to replace the current screen.
  /// [maintainState] - A boolean value to decide whether to maintain the current state.
  ///    Defaults to true.
  ///
  /// Returns a Future with the result of the navigation action.
  ///
  /// **Example:**
  /// ```dart
  /// RouteHelper(context).pushReplacement(NewScreen());
  /// ```
  Future<dynamic> pushReplacement(Widget screen, {bool maintainState = true}) {
    return context.pushReplacement(screen, maintainState: maintainState);
  }

  /// Replaces the current screen with a new named route.
  ///
  /// This method allows navigation to a new named route while replacing the current screen.
  /// It is used when you want to navigate to a predefined route and remove the current screen from the stack.
  ///
  /// [screenName] - The name of the route to navigate to.
  /// [arguments] - Optional arguments to pass to the target route.
  ///
  /// Returns a Future with the result of the navigation action.
  ///
  /// **Example:**
  /// ```dart
  /// RouteHelper(context).pushReplacementNamed('/login');
  /// ```
  Future<dynamic> pushReplacementNamed(String screenName, {Object? arguments}) {
    return context.pushReplacementNamed(screenName, arguments: arguments);
  }

  /// Pushes a new screen and removes all previous routes up to the provided path.
  ///
  /// This method allows for a "clean" navigation, where the previous routes are removed from the stack.
  /// The new screen is pushed onto the stack, and the routes before the specified [path] are removed.
  ///
  /// [screen] - The widget to be displayed as the new route.
  /// [path] - The route path to remove all previous routes until.
  /// [maintainState] - A boolean value to specify whether to maintain the state of the current screen.
  ///    Defaults to true.
  ///
  /// Returns a Future with the result of the navigation action.
  ///
  /// **Example:**
  /// ```dart
  /// RouteHelper(context).pushAndRemoveUntil(NewScreen(), '/home');
  /// ```
  Future<dynamic> pushAndRemoveUntil(
    Widget screen,
    String path, {
    bool maintainState = true,
  }) {
    return context.pushAndRemoveUntil(
      screen,
      path,
      maintainState: maintainState,
    );
  }

  /// Pushes a new named route and removes all previous routes up to the provided path.
  ///
  /// This method is similar to [pushAndRemoveUntil], but uses named routes.
  /// It removes all routes until the specified [path] and pushes a new named route onto the stack.
  ///
  /// [screenName] - The name of the route to navigate to.
  /// [arguments] - Optional arguments to pass to the target route.
  ///
  /// Returns a Future with the result of the navigation action.
  ///
  /// **Example:**
  /// ```dart
  /// RouteHelper(context).pushNamedAndRemoveUntil('/login');
  /// ```
  Future<dynamic> pushNamedAndRemoveUntil(
    String screenName, {
    Object? arguments,
  }) {
    return context.pushNamedAndRemoveUntil(
      screenName,
      arguments: arguments,
    );
  }

  /// Pops the current route off the stack, optionally returning a result to the previous screen.
  ///
  /// This method allows you to pop the current screen from the navigation stack and return a result
  /// to the previous screen. It is useful for scenarios like closing dialogs or returning data after
  /// completing a task in the current screen.
  ///
  /// [result] - The optional result to return when popping the route. If no result is provided, the default is null.
  ///
  /// **Example:**
  /// ```dart
  /// RouteHelper(context).pop('User logged out');
  /// ```
  void pop([Object? result]) {
    context.pop(result);
  }

  /// Determines whether the current route can be popped from the navigation stack.
  ///
  /// This method checks if the current screen can be popped from the stack. It is useful for checking
  /// whether there are any previous routes in the navigation stack before attempting to pop the current screen.
  /// You can use this method to control the visibility or enablement of back buttons or other navigation controls.
  ///
  /// Returns `true` if there is a route to pop; otherwise, it returns `false`.
  ///
  /// **Example:**
  /// ```dart
  /// if (RouteHelper(context).canPop()) {
  ///   RouteHelper(context).pop();
  /// }
  /// ```
  bool canPop() {
    return context.canPop();
  }
}
