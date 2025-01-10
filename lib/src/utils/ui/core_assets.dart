/// A utility class for managing asset paths used in the application.
/// This class centralizes access to animation assets, improving maintainability
/// and reducing hardcoding issues.
class CoreAssets {
  /// Base path for animation assets.
  static const String _ANIM = "assets/anim/";

  /// Base path for icon assets.
  static const String _ICON = "assets/icon/";

  // Path to the  animation file.
  /// This animation is typically used to indicate a loading or progress state in the app.
  static const String LOADING_ANIM = "${_ANIM}loading_anim.json";

  ///This animation is typically used to indicate a maintenance state in the app.
  static const String MAINTENANCE_ANIM = "${_ANIM}maintenance.json";

  /// This animation is typically used to indicate a no internet state in the app.
  static const String NO_INTERNET_ANIM = "${_ANIM}no_internet.json";

  /// This animation is typically used to indicate a page not found state in the app.
  static const String PAGE_NOT_FOUND_ANIM = "${_ANIM}page_not_found.json";

  // Path to the icon file.
  /// This icon is used to indicate a back navigation action.
  static const String IC_BACK = "${_ICON}ic_back.svg";

  /// This icon is used to indicate a filter action.
  static const String IC_FILTER = "${_ICON}ic_filter.svg";

  /// This icon is used to indicate a share action.
  static const String IC_SHARE = "${_ICON}ic_share.svg";

  /// This icon is used to indicate a clear search action.
  static const String IC_SEARCH = "${_ICON}ic_search.svg";

  /// This icon is used to indicate a drag action.
  static const String IC_DRAG = "${_ICON}ic_drag.svg";
}
