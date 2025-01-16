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
  final SvgType? type;
  final String? path;
  final Uint8List? bytes;
  final File? file;

  /// Creates a [SvgWidget] to display SVG images from various sources.
  ///
  /// [type] specifies the source of the SVG (can be [SvgType.asset], [SvgType.network], [SvgType.string], [SvgType.file], or [SvgType.memory]).
  /// [path] is the path or URL of the SVG image (used for [SvgType.asset], [SvgType.network], and [SvgType.string]).
  /// [bytes] is the byte data of the SVG image (used for [SvgType.memory]).
  /// [file] is the file containing the SVG image (used for [SvgType.file]).
  const SvgWidget({
    super.key,
    required this.type,
    this.path,
    this.bytes,
    this.file,
  });

  @override
  Widget build(BuildContext context) {
    // Return the appropriate widget based on the type of SVG source
    return _buildSvg();
  }

  /// A private method to determine which type of SVG to render based on the provided [type].
  ///
  /// This method uses a switch statement to return the appropriate SVG rendering widget
  /// based on the selected [type]. It handles asset, network, string, file, and memory sources.
  Widget _buildSvg() {
    switch (type) {
      case SvgType.asset:
        // Load SVG from asset path
        return SvgPicture.asset(path ?? '');

      case SvgType.network:
        // Load SVG from network URL
        return SvgPicture.network(path ?? '');

      case SvgType.string:
        // Load SVG from a string containing SVG data
        return SvgPicture.string(path ?? '');

      case SvgType.file:
        // Load SVG from file
        return SvgPicture.file(file ?? File(''));

      case SvgType.memory:
        // Load SVG from memory (Uint8List of byte data)
        return SvgPicture.memory(bytes ?? Uint8List(0));

      default:
        // Return an empty widget if no valid type is provided
        return SizedBox.shrink();
    }
  }
}
