part of '../extensions_import.dart';

/// Extension to add navigation functions directly to [BuildContext].
///
/// This extension provides several convenient methods to handle navigation in Flutter
/// without having to manually reference `Navigator.of(context)` every time.
/// It supports basic navigation operations like push, pop, and replacement, as well as
/// more advanced options like removing routes from the stack and passing arguments.
///
/// **Example usage:**
/// ```dart
/// context.push(MyScreen());
/// context.pushNamed('/myScreen');
/// context.pushReplacement(MyScreen());
/// context.pop();
/// context.canPop();
/// context.arguments<int>(defaultValue: 0);
/// ```
extension NavigationHelper on BuildContext {
  /// Push a new screen onto the stack.
  ///
  /// This method adds a new screen to the navigation stack, allowing users to navigate
  /// to another screen within the app.
  ///
  /// **Parameters:**
  /// - [screen]: The widget to be displayed.
  /// - [maintainState]: Whether to maintain the state of the previous screen. Default is `true`.
  ///
  /// **Returns:**
  /// - A [Future] representing the result of the navigation.
  ///
  /// **Example:**
  /// ```dart
  /// context.push(MyScreen());
  /// ```
  Future<dynamic> push(Widget screen, {bool maintainState = true}) {
    final navigator = Navigator.maybeOf(this);
    if (navigator == null) return Future.value();
    return navigator.push(
      routeBuilder(
        screen,
        maintainState: maintainState,
        settings: RouteSettings(name: screen.runtimeType.toString()),
      ),
    );
  }

  /// Push a named route onto the stack with optional arguments.
  ///
  /// This method allows navigation to a named route, passing optional arguments to
  /// the target screen.
  ///
  /// **Parameters:**
  /// - `screenName`: The name of the route to navigate to.
  /// - `arguments`: Optional arguments to pass to the destination screen.
  ///
  /// **Returns:**
  /// - A [Future] representing the result of the navigation.
  ///
  /// **Example:**
  /// ```dart
  /// context.pushNamed('/home', arguments: {'id': 1});
  /// ```
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    final navigator = Navigator.maybeOf(this);
    if (navigator == null) return Future.value();
    return navigator.pushNamed(routeName, arguments: arguments);
  }

  /// Replace the current screen with a new one.
  ///
  /// This method replaces the current screen on the navigation stack with a new screen.
  ///
  /// **Parameters:**
  /// - `screen`: The widget to replace the current screen.
  /// - `maintainState`: Whether to maintain the state of the replaced screen. Default is `true`.
  ///
  /// **Returns:**
  /// - A [Future] representing the result of the navigation.
  ///
  /// **Example:**
  /// ```dart
  /// context.pushReplacement(MyScreen());
  /// ```
  Future<dynamic> pushReplacement(Widget screen, {bool maintainState = true}) {
    final navigator = Navigator.maybeOf(this);
    if (navigator == null) return Future.value();
    return navigator.pushReplacement(
      routeBuilder(
        screen,
        maintainState: maintainState,
      ),
    );
  }

  /// Replace the current screen with a new named route.
  ///
  /// This method replaces the current screen on the navigation stack with a new
  /// named route, passing optional arguments.
  ///
  /// **Parameters:**
  /// - `screenName`: The name of the route to replace the current screen.
  /// - `arguments`: Optional arguments to pass to the destination screen.
  ///
  /// **Returns:**
  /// - A [Future] representing the result of the navigation.
  ///
  /// **Example:**
  /// ```dart
  /// context.pushReplacementNamed('/home', arguments: {'id': 1});
  /// ```
  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    final navigator = Navigator.maybeOf(this);
    if (navigator == null) return Future.value();
    return navigator.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// Push a new screen onto the stack and remove all previous routes until the provided path.
  ///
  /// This method pushes a new screen onto the navigation stack and removes all previous routes until the route with the specified name,
  /// leaving only the new screen and the one at the provided path.
  ///
  /// **Parameters:**
  /// - [screen]: The widget to be displayed.
  ///
  /// **Returns:**
  /// - A [Future] representing the result of the navigation.
  ///
  /// **Example:**
  /// ```dart
  /// context.pushAndRemoveUntil(MyScreen(), '/home');
  /// ```
  Future<dynamic> pushAndRemoveUntil(
    Widget screen,
    String path, {
    bool maintainState = true,
  }) {
    final navigator = Navigator.maybeOf(this);
    if (navigator == null) return Future.value();
    return navigator.pushAndRemoveUntil(
      routeBuilder(screen, maintainState: maintainState),
      ModalRoute.withName(path),
    );
  }

  /// Push a new screen onto the stack and remove all previous routes.
  ///
  /// This method pushes a new screen onto the navigation stack and removes all previous routes,
  /// leaving only the new screen in the stack.
  ///
  /// **Parameters:**
  /// - [screen]: The widget to be displayed.
  /// - [maintainState]: Whether to maintain the state of the previous screen. Default is `true`.
  ///
  /// **Returns:**
  /// - A [Future] representing the result of the navigation.
  ///
  /// **Example:**
  /// ```dart
  /// context.pushAndRemoveAll(MyScreen());
  /// ```
  Future<dynamic> pushAndRemoveAll(Widget screen, {bool maintainState = true}) {
    final navigator = Navigator.maybeOf(this);
    if (navigator == null) return Future.value();
    return navigator.pushAndRemoveUntil(
      routeBuilder(screen, maintainState: maintainState),
      (route) => false,
    );
  }

  /// Push a named route and remove all previous routes until the provided path.
  ///
  /// This method pushes a named route and removes all previous routes in the stack,
  /// leaving only the new route and the one at the provided path.
  ///
  /// **Parameters:**
  /// - [screenName]: The name of the route to be pushed.
  /// - [arguments]: Optional arguments to pass to the destination screen.
  ///
  /// **Returns:**
  /// - A [Future] representing the result of the navigation.
  ///
  /// **Example:**
  /// ```dart
  /// context.pushNamedAndRemoveUntil('/home', arguments: {'id': 1});
  /// ```
  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments}) {
    final navigator = Navigator.maybeOf(this);
    if (navigator == null) return Future.value();
    return navigator.pushNamedAndRemoveUntil(
      routeName,
      ModalRoute.withName(routeName),
      arguments: arguments,
    );
  }

  /// Pop all routes in the stack until the provided path.
  ///
  /// This method removes all routes in the navigation stack until the route with the
  /// specified name, leaving only the target route on the stack.
  ///
  /// **Parameters:**
  /// - [routeName]: The name of the route to keep in the stack.
  ///
  /// **Example:**
  /// ```dart
  /// context.popUntil('/home');
  /// ```
  void popUntil(String routeName) {
    final navigator = Navigator.maybeOf(this);
    if (navigator == null) return;
    navigator.popUntil(ModalRoute.withName(routeName));
  }

  /// Pop the current route off the stack, optionally returning a result.
  ///
  /// This method removes the current screen from the navigation stack, and optionally
  /// returns a result to the previous screen.
  ///
  /// **Parameters:**
  /// - [result]: The result to return to the previous screen (optional).
  ///
  /// **Example:**
  /// ```dart
  /// context.pop('result');
  /// ```
  void pop([Object? result]) {
    final navigator = Navigator.maybeOf(this);
    if (navigator == null || !navigator.canPop()) return;
    navigator.pop(result);
  }

  /// Can-pop check for the current route.
  ///
  /// This method checks whether the current screen can be popped from the navigation stack.
  ///
  /// **Returns:**
  /// - A boolean value indicating if the current route can be popped.
  ///
  /// **Example:**
  /// ```dart
  ///  if (context.canPop()) {
  ///  context.pop();
  ///  }
  /// ```
  bool canPop() {
    final navigator = Navigator.maybeOf(this);
    return navigator?.canPop() ?? false;
  }

  /// Helper method to create a PageRoute with optional state maintenance.
  ///
  /// This method generates a [CupertinoPageRoute] for a given screen widget, allowing
  /// for smoother transitions in iOS-style apps.
  ///
  /// **Parameters:**
  /// - `screen`: The widget to display.
  /// - `maintainState`: Whether to maintain the state of the page. Default is `true`.
  ///
  /// **Returns:**
  /// - A [PageRoute] to navigate to the given screen.
  ///
  /// **Example:**
  /// ```dart
  /// Navigator.of(context).push(routeBuilder(MyScreen()));
  /// ```
  PageRoute routeBuilder(
    Widget screen, {
    bool maintainState = true,
    RouteSettings? settings,
  }) =>
      CupertinoPageRoute(
        builder: (_) => screen,
        maintainState: maintainState,
        settings: settings,
      );

  /// Returns the arguments passed to the route, with a default value in case of null.
  ///
  /// This method retrieves the arguments passed to the current route, or returns a default
  /// value if no arguments were passed.
  ///
  /// **Parameters:**
  /// - `defaultValue`: The value to return if no arguments are available.
  ///
  /// **Returns:**
  /// - The arguments passed to the route, or the default value.
  ///
  /// **Example:**
  /// ```dart
  /// final id = context.arguments<int>(defaultValue: 0);
  /// ```
  M arguments<M>({required M defaultValue}) {
    final settings = ModalRoute.of(this)?.settings;
    final args = settings?.arguments;

    if (args is M) {
      return args;
    }

    if (args != null) {
      Logger.warning(
        "Type mismatch for route arguments. Expected ${M.runtimeType}, found ${args.runtimeType}",
      );
    }

    return defaultValue;
  }
}
