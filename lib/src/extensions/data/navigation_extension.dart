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
/// ```
extension NavigationHelper on BuildContext {
  /// Push a new screen onto the stack.
  ///
  /// This method adds a new screen to the navigation stack, allowing users to navigate
  /// to another screen within the app.
  ///
  /// **Parameters:**
  /// - `screen`: The widget to be displayed.
  /// - `maintainState`: Whether to maintain the state of the previous screen. Default is `true`.
  ///
  /// **Returns:**
  /// - A [Future] representing the result of the navigation.
  Future<dynamic> push(Widget screen, {bool maintainState = true}) {
    return Navigator.of(this).push(
      route(screen, maintainState: maintainState),
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
  Future<dynamic> pushNamed(String screenName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(
      screenName,
      arguments: arguments,
    );
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
  Future<dynamic> pushReplacement(Widget screen, {bool maintainState = true}) {
    return Navigator.of(this).pushReplacement(
      route(screen, maintainState: maintainState),
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
  Future<dynamic> pushReplacementNamed(String screenName, {Object? arguments}) {
    return Navigator.of(this).pushReplacementNamed(
      screenName,
      arguments: arguments,
    );
  }

  /// Push a new screen and remove all previous routes until the provided path.
  ///
  /// This method pushes a new screen and removes all the previous screens in the
  /// navigation stack up to the screen at the specified path.
  ///
  /// **Parameters:**
  /// - `screen`: The widget to be displayed.
  /// - `path`: The route name to keep in the stack after pushing the new screen.
  /// - `maintainState`: Whether to maintain the state of the new screen. Default is `true`.
  ///
  /// **Returns:**
  /// - A [Future] representing the result of the navigation.
  Future<dynamic> pushAndRemoveUntil(
    Widget screen,
    String path, {
    bool maintainState = true,
  }) {
    return Navigator.of(this).pushAndRemoveUntil(
      route(screen, maintainState: maintainState),
      ModalRoute.withName(path),
    );
  }

  /// Push a named route and remove all previous routes until the provided path.
  ///
  /// This method pushes a named route and removes all previous routes in the stack,
  /// leaving only the new route and the one at the provided path.
  ///
  /// **Parameters:**
  /// - `screenName`: The name of the route to be pushed.
  /// - `arguments`: Optional arguments to pass to the destination screen.
  ///
  /// **Returns:**
  /// - A [Future] representing the result of the navigation.
  Future<dynamic> pushNamedAndRemoveUntil(
    String screenName, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
      screenName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Pop the current route off the stack, optionally returning a result.
  ///
  /// This method removes the current screen from the navigation stack, and optionally
  /// returns a result to the previous screen.
  ///
  /// **Parameters:**
  /// - `result`: The result to return to the previous screen (optional).
  void pop([Object? result]) {
    Navigator.of(this).pop(result);
  }

  /// Can-pop check for the current route.
  ///
  /// This method checks whether the current screen can be popped from the navigation stack.
  ///
  /// **Returns:**
  /// - A boolean value indicating if the current route can be popped.
  bool canPop() {
    return Navigator.of(this).canPop();
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
  PageRoute route(
    Widget screen, {
    bool maintainState = true,
  }) {
    return CupertinoPageRoute(
      builder: (_) => screen,
      maintainState: maintainState,
    );
  }

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
  M arguments<M>({
    required M defaultValue,
  }) {
    final settings = ModalRoute.of(this)?.settings;
    return settings?.arguments != null
        ? settings!.arguments as M
        : defaultValue;
  }
}
