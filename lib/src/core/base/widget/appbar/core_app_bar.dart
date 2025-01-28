part of '../../import/base_import.dart';

/// A customizable app bar widget for the application.
///
/// The `CoreAppBar` widget provides a flexible and customizable way to create an `AppBar`
/// in the application. It takes an `AppBarConfig` configuration object to adjust the app bar's
/// properties and actions. It supports common actions such as back, share, and filter buttons,
/// along with custom action buttons passed through the `AppBarConfig`. It also includes a custom
/// leading widget that can be configured for the back button or any other leading widget.
///
/// The widget automatically adjusts based on the provided configuration and provides a highly
/// customizable approach to app bar creation.
///
/// ### Example Usage:
/// ```dart
/// CoreAppBar(
///   config: AppBarConfig(
///     title: 'Home',
///     hasBack: true,
///     hasSearch: true,
///     searchAction: () => print('Search tapped'),
///     hasFilter: true,
///     filterAction: () => print('Filter tapped'),
///   ),
///   route: routeHelper,
/// )
/// ```
///
/// In the example above:
/// - The app bar will have a title "Home".
/// - The back button will be shown due to `hasBack: true`.
/// - Search and filter buttons will be added with corresponding actions.
class CoreAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The configuration for the app bar properties.
  final AppBarConfig? config;

  /// Route helper to manage navigation within the app.
  final RouteHelper? route;

  /// Constructor for the `CoreAppBar`, takes an `AppBarConfig` and a `RouteHelper`.
  ///
  /// - [config]: An optional configuration for customizing the app bar.
  /// - [route]: An optional `RouteHelper` to manage navigation actions.
  const CoreAppBar({
    super.key,
    this.config,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    // Building the AppBar based on the provided configuration and actions.
    return AppBar(
      surfaceTintColor: config?.surfaceTintColor ?? CoreColors.hide,
      centerTitle: config?.centerTitle ?? false,
      backgroundColor: config?.backgroundColor ?? CoreColors.backgroundColor,
      automaticallyImplyLeading: config?.automaticallyImplyLeading ?? false,
      leading: (config?.hasBack ?? true)
          ? LeadingWidget(
              route: route,
              onBack: config?.onBack,
              backIcon: config?.customIconBack,
              iconBackgroundColor: config?.iconBackgroundColor,
              iconColor: config?.iconColor,
            )
          : null,
      titleSpacing: config?.hasBack ?? false ? 0 : 16,
      iconTheme: config?.iconTheme,
      actions: _buildActions(),
      title: Text(
        config?.title ?? '',
        style: config?.titleStyle,
      ),
    );
  }

  /// Builds the action buttons (search, filter, share, and custom actions).
  ///
  /// The actions are conditionally added based on the configuration. If any of the properties
  /// (`hasSearch`, `hasFilter`, `hasShare`, or `actions`) are true, the corresponding buttons
  /// are included in the app bar.
  ///
  /// - [hasSearch]: Adds a search button if true.
  /// - [hasFilter]: Adds a filter button if true.
  /// - [hasShare]: Adds a share button if true.
  /// - [actions]: Additional custom actions passed through the configuration.
  List<Widget> _buildActions() {
    List<Widget> actions = [];

    if (config?.hasSearch ?? false) {
      actions.add(
        IconButton(
          onPressed: config?.searchAction,
          icon: config?.customShare ??
              SvgWidget(
                path: CoreAssets.icSearch,
                type: SvgType.asset,
              ),
        ),
      );
    }

    if (config?.hasFilter ?? false) {
      actions.add(
        IconButton(
          icon: config?.customFilter ??
              SvgWidget(
                path: CoreAssets.icFilter,
                type: SvgType.asset,
              ),
          onPressed: config?.filterAction ?? () {},
        ),
      );
    }

    if (config?.hasShare ?? false) {
      actions.add(
        IconButton(
          onPressed: config?.shareAction,
          icon: config?.customShare ??
              SvgWidget(
                path: CoreAssets.icShare,
                type: SvgType.asset,
              ),
        ),
      );
    }

    if (config?.actions != null) {
      actions.addAll(config!.actions!);
    }

    return actions;
  }

  /// Overrides the preferredSize property to define the app bar's height.
  ///
  /// The `preferredSize` is set to the standard app bar height using [kToolbarHeight].
  ///
  /// This ensures the app bar has a consistent height across different screens.
  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight,
      ); // Standard app bar height.
}
