part of '../extensions_import.dart';

/// Extension on [String] to provide methods for precaching assets, network images, and SVGs.
///
/// This extension adds methods to the `String` type to facilitate the precaching of images from
/// assets, network sources, and SVG files. By using these methods, you can preload images and SVGs
/// into memory for smoother user experiences, particularly for assets that will be displayed frequently.
///
/// **Example usage:**
/// ```dart
/// "assets/images/logo.png".precacheAsset();    // Precache asset image
/// "https://example.com/image.jpg".precacheNetwork();  // Precache network image
/// "assets/svgs/logo.svg".precacheSvgAsset();  // Precache SVG asset
/// ```

extension PrecacheExtension on String {
  /// Pre-caches an image from the app's asset bundle.
  ///
  /// This method uses the `AssetImage` to load and cache the image from the assets directory.
  /// It allows the image to be available in memory when needed, preventing delays during UI rendering.
  ///
  /// **Example:**
  /// ```dart
  /// "assets/images/logo.png".precacheAsset;
  /// ```
  Future<void> get precacheAsset async {
    try {
      await precacheImage(
        AssetImage(this),
        RouteHelper.navigatorKey.currentContext!,
      );
    } catch (e) {
      Logger.error('PrecacheAsset Error: $e');
    }
  }

  /// Pre-caches an image from a network source.
  ///
  /// This method uses `CachedNetworkImageProvider` to load and cache the image from a URL.
  /// The image will be available for quicker access later, reducing network load and improving performance.
  ///
  /// **Example:**
  /// ```dart
  /// "https://example.com/image.jpg".precacheNetwork;
  /// ```
  Future<void> get precacheNetwork async {
    try {
      await precacheImage(
        CachedNetworkImageProvider(this),
        RouteHelper.navigatorKey.currentContext!,
      );
    } catch (e) {
      Logger.error('PrecacheNetwork Error: $e');
    }
  }

  /// Pre-caches an SVG asset.
  ///
  /// This method uses an `SvgAssetLoader` to load and cache the SVG file.
  /// This is particularly useful for preloading vector graphics before they are rendered in the app.
  ///
  /// **Example:**
  /// ```dart
  /// "assets/svgs/logo.svg".precacheSvgAsset();
  /// ```
  Future<void> get precacheSvgAsset async {
    try {
      final SvgAssetLoader loader = SvgAssetLoader(this);
      svg.cache
          .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    } catch (e) {
      Logger.error('PrecacheSVGAsset Error: $e');
    }
  }
}
