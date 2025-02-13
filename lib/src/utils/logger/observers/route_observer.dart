part of '../logger_import.dart';

class LoggerRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // Save previous route name or fallback to an empty string.
    RouteHelper.previousRoute = previousRoute?.settings.name ?? '';
    super.didPush(route, previousRoute);
    if (route.settings.name == null) {
      return;
    }
    // Use the route's name if provided, otherwise use the route's runtimeType.
    Logger.route(route: route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // Save previous route name or fallback to an empty string.
    RouteHelper.previousRoute = previousRoute?.settings.name ?? '';
    super.didPop(route, previousRoute);
    if (route.settings.name == null) {
      return;
    }
    // Use the route's name if provided, otherwise use the route's runtimeType.
    Logger.route(route: route);
  }
}
