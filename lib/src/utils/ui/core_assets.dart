/// A utility class for managing asset paths used in the application.
/// This class centralizes access to animation assets, improving maintainability
/// and reducing hardcoding issues.
class CoreAssets {
  /// The name of the package, required for accessing assets in a Flutter package.
  static const String _packageName = "opticore";

  /// Base path for animation assets.
  static const String _anim = "assets/anim/";

  /// Base path for icon assets.
  static const String _icon = "assets/icon/";

  /// A helper method to prepend the package name to the asset path.
  static String _packageAsset(String assetPath) =>
      "packages/$_packageName/$assetPath";

  // Animation Assets
  /// This animation is typically used to indicate a loading or progress state in the app.
  static String get loadingAnim => _packageAsset("${_anim}loading_anim.json");

  /// This animation is typically used to indicate a maintenance state in the app.
  static String get maintenanceAnim => _packageAsset("${_anim}maintenance.json");

  /// This animation is typically used to indicate a no internet state in the app.
  static String get noInternetAnim => _packageAsset("${_anim}no_internet.json");

  /// This animation is typically used to indicate a page not found state in the app.
  static String get pageNotFoundAnim =>
      _packageAsset("${_anim}page_not_found.json");

  // Icon Assets
  /// This icon is used to indicate a back navigation action.
  static String get icBack => _packageAsset("${_icon}ic_back.svg");

  /// This icon is used to indicate a filter action.
  static String get icFilter => _packageAsset("${_icon}ic_filter.svg");

  /// This icon is used to indicate a share action.
  static String get icShare => _packageAsset("${_icon}ic_share.svg");

  /// This icon is used to indicate a clear search action.
  static String get icSearch => _packageAsset("${_icon}ic_search.svg");

  /// This icon is used to indicate a drag action.
  static String get icDrag => _packageAsset("${_icon}ic_drag.svg");
}