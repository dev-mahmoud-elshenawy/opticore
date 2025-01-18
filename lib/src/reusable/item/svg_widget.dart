part of '../reusable_import.dart';

/// A widget that allows you to render SVG images from multiple sources, including assets, network, memory, file, and strings.
/// This widget provides a convenient way to display SVGs dynamically based on the provided input type, without the need
/// to handle the complexity of different SVG loading mechanisms.
///
/// ## Key Features:
/// - Supports multiple types of SVG sources: asset, network, string, file, and memory.
/// - Provides an easy-to-use interface for rendering SVG images with just a few parameters.
/// - Supports both local and remote SVG images, as well as in-memory SVG data.
///
/// ## How to Use:
/// This widget can be used to display an SVG image from various sources such as an asset, a network URL,
/// a string containing SVG data, a file, or in-memory byte data. You only need to specify the type of SVG source
/// and the corresponding path, bytes, or file. Below is an example usage:
///
/// ```dart
/// SvgWidget(
///   type: SvgType.ASSET, // The source type (can be ASSET, NETWORK, STRING, FILE, or MEMORY)
///   path: 'assets/images/logo.svg', // Path to the SVG in the assets
/// ),
/// ```
///
/// You can also display SVG images from a network URL, a byte array, or a file, like so:
///
/// ```dart
/// SvgWidget(
///   type: SvgType.NETWORK, // For displaying SVG from a URL
///   path: 'https://example.com/image.svg',
/// ),
///
/// SvgWidget(
///   type: SvgType.MEMORY, // For displaying SVG from in-memory bytes
///   bytes: someByteArray,
/// ),
/// ```
///
/// ## Constructor Parameters:
/// - `type`: The type of SVG source. This determines how the SVG will be loaded (can be one of [SvgType.asset], [SvgType.network], [SvgType.string], [SvgType.file], or [SvgType.memory]).
/// - `path`: The path to the SVG source. This can be the asset path, network URL, or string representation of the SVG (based on the selected [type]).
/// - `bytes`: The raw byte data of the SVG image (used with [SvgType.memory]).
/// - `file`: The file containing the SVG image (used with [SvgType.file]).
class SvgWidget extends StatelessWidget {
  /// Specifies the source type of the SVG (asset, network, string, file, or memory).
  final SvgType? type;

  /// The path or URL of the SVG image (used for [SvgType.asset], [SvgType.network], and [SvgType.string]).
  final String? path;

  /// The byte data of the SVG image (used for [SvgType.memory]).
  final Uint8List? bytes;

  /// The file containing the SVG image (used for [SvgType.file]).
  final File? file;

  /// The color to tint the SVG image.
  ///
  /// If null, the original colors of the SVG are used.
  final Color? color;

  /// The placeholder widget to display while the SVG is loading (for [SvgType.network]).
  final Widget? placeholder;

  /// The widget to display if loading the SVG fails (e.g., network errors or invalid data).
  final Widget? errorWidget;

  /// The width of the SVG image.
  final double? width;

  /// The height of the SVG image.
  final double? height;

  /// Box fit for the SVG image (e.g., [BoxFit.contain], [BoxFit.cover]).
  final BoxFit fit;

  /// Creates a [SvgWidget] to display SVG images from various sources with enhanced customization.
  ///
  /// - [type] is required and specifies the SVG source type.
  /// - [path], [bytes], or [file] should be provided based on the selected [type].
  /// - Optional parameters include [color], [placeholder], [errorWidget], [width], [height], and [fit].
  const SvgWidget({
    super.key,
    required this.type,
    this.path,
    this.bytes,
    this.file,
    this.color,
    this.placeholder,
    this.errorWidget,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return _buildSvg();
  }

  /// A private method to build the appropriate SVG widget based on the provided [type].
  Widget _buildSvg() {
    ColorFilter? colorFilter = color != null
        ? ColorFilter.mode(
            color!,
            BlendMode.srcIn,
          )
        : null;
    Widget Function(BuildContext)? placeholderBuilder =
        placeholder != null ? (_) => placeholder! : null;
    try {
      switch (type) {
        case SvgType.asset:
          // Load SVG from asset path
          return SvgPicture.asset(
            path ?? '',
            colorFilter: colorFilter,
            width: width,
            height: height,
            fit: fit,
            placeholderBuilder: placeholderBuilder,
            errorBuilder: (_, __, ___) => _buildErrorWidget(),
          );

        case SvgType.network:
          // Load SVG from network URL with placeholder and error handling
          return SvgPicture.network(
            path ?? '',
            colorFilter: colorFilter,
            width: width,
            height: height,
            fit: fit,
            placeholderBuilder: placeholderBuilder,
            errorBuilder: (_, __, ___) => _buildErrorWidget(),
          );

        case SvgType.string:
          // Load SVG from a string containing SVG data
          return SvgPicture.string(
            path ?? '',
            colorFilter: colorFilter,
            width: width,
            height: height,
            fit: fit,
            placeholderBuilder: placeholderBuilder,
            errorBuilder: (_, __, ___) => _buildErrorWidget(),
          );

        case SvgType.file:
          // Load SVG from a file
          return SvgPicture.file(
            file ?? File(''),
            colorFilter: colorFilter,
            width: width,
            height: height,
            fit: fit,
            placeholderBuilder: placeholderBuilder,
            errorBuilder: (_, __, ___) => _buildErrorWidget(),
          );

        case SvgType.memory:
          // Load SVG from memory (Uint8List of byte data)
          return SvgPicture.memory(
            bytes ?? Uint8List(0),
            colorFilter: colorFilter,
            width: width,
            height: height,
            fit: fit,
            placeholderBuilder: placeholderBuilder,
            errorBuilder: (_, __, ___) => _buildErrorWidget(),
          );

        default:
          return _buildErrorWidget();
      }
    } catch (e) {
      // Handle errors gracefully by displaying the error widget
      return _buildErrorWidget();
    }
  }

  /// Returns the error widget if specified, or an empty widget by default.
  Widget _buildErrorWidget() {
    return errorWidget ?? const SizedBox.shrink();
  }
}
