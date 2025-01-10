/// A utility class for managing asset paths used in the application.
/// This class centralizes access to animation assets, improving maintainability
/// and reducing hardcoding issues.
class CoreAssets {
  /// Base path for animation assets.
  static const String _anim = "assets/anim/";

  /// Base path for icon assets.
  static const String _icon = "assets/icon/";

  // Path to the  animation file.
  /// This animation is typically used to indicate a loading or progress state in the app.
  static const String loadingAnim = "${_anim}loading_anim.json";

  ///This animation is typically used to indicate a maintenance state in the app.
  static const String maintenanceAnim = "${_anim}maintenance.json";

  /// This animation is typically used to indicate a no internet state in the app.
  static const String noInternetAnim = "${_anim}no_internet.json";

  /// This animation is typically used to indicate a page not found state in the app.
  static const String pageNotFoundAnim = "${_anim}page_not_found.json";

  // Path to the icon file.
  /// This icon is used to indicate a back navigation action.
  static const String icBack = "${_icon}ic_back.svg";

  /// This icon is used to indicate a filter action.
  static const String icFilter = "${_icon}ic_filter.svg";

  /// This icon is used to indicate a share action.
  static const String icShare = "${_icon}ic_share.svg";

  /// This icon is used to indicate a clear search action.
  static const String icSearch = "${_icon}ic_search.svg";

  /// This icon is used to indicate a drag action.
  static const String icDrag = "${_icon}ic_drag.svg";
}
