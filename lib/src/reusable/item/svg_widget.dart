part of '../reusable_import.dart';

/// A smart widget for rendering SVG images from various sources.
///
/// This widget intelligently handles SVGs from assets, network, memory, files, and strings
/// with automatic type detection and minimal configuration.
class SvgWidget extends StatelessWidget {
  /// The path or URL of the SVG image
  final String? path;

  /// The SVG type (auto-detected if not provided)
  final SvgType? type;

  /// The byte data of the SVG image
  final Uint8List? bytes;

  /// The file containing the SVG image
  final File? file;

  /// Color to tint the SVG
  final Color? color;

  /// Blend mode for the color filter
  final BlendMode? blendMode;

  /// Widget to display while loading
  final Widget? placeholder;

  /// Widget to display if loading fails
  final Widget? errorWidget;

  /// Width of the SVG
  final double? width;

  /// Height of the SVG
  final double? height;

  /// Box fit for the SVG
  final BoxFit fit;

  /// Creates a smart SVG widget that auto-detects source type.
  ///
  /// Provide one of: [path], [bytes], or [file].
  const SvgWidget({
    super.key,
    this.path,
    this.type,
    this.bytes,
    this.file,
    this.color,
    this.blendMode,
    this.placeholder,
    this.errorWidget,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  }) : assert(
          path != null || bytes != null || file != null,
          'At least one source (path, bytes, or file) must be provided',
        );

  @override
  Widget build(BuildContext context) {
    final SvgType sourceType = _detectType();
    return _buildSvg(sourceType);
  }

  /// Auto-detects SVG source type based on provided parameters
  SvgType _detectType() {
    if (type != null) return type!;

    if (bytes != null) return SvgType.memory;
    if (file != null) return SvgType.file;

    final source = path;
    if (source == null) return SvgType.asset; // Default fallback

    if (source.startsWith('http://') || source.startsWith('https://')) {
      return SvgType.network;
    }

    if (source.contains('<svg') && source.contains('</svg>')) {
      return SvgType.string;
    }

    return SvgType.asset;
  }

  /// Builds appropriate SVG widget based on detected type
  Widget _buildSvg(SvgType sourceType) {
    final colorFilter = color != null
        ? ColorFilter.mode(
            color!,
            blendMode ?? BlendMode.srcIn,
          )
        : null;

    final placeholderBuilder = placeholder != null ? (_) => placeholder! : null;

    Widget errorWidget = this.errorWidget ??
        const SizedBox.shrink(); // Default to empty widget if not provided

    try {
      switch (sourceType) {
        case SvgType.asset:
          return SvgPicture.asset(
            path ?? '',
            colorFilter: colorFilter,
            width: width,
            height: height,
            fit: fit,
            placeholderBuilder: placeholderBuilder,
            errorBuilder: (_, __, ___) => errorWidget,
          );

        case SvgType.network:
          return SvgPicture.network(
            path ?? '',
            colorFilter: colorFilter,
            width: width,
            height: height,
            fit: fit,
            placeholderBuilder: placeholderBuilder,
            errorBuilder: (_, __, ___) => errorWidget,
          );

        case SvgType.string:
          return SvgPicture.string(
            path ?? '',
            colorFilter: colorFilter,
            width: width,
            height: height,
            fit: fit,
            placeholderBuilder: placeholderBuilder,
            errorBuilder: (_, __, ___) => errorWidget,
          );

        case SvgType.file:
          return SvgPicture.file(
            file ?? File(''),
            colorFilter: colorFilter,
            width: width,
            height: height,
            fit: fit,
            placeholderBuilder: placeholderBuilder,
            errorBuilder: (_, __, ___) => errorWidget,
          );

        case SvgType.memory:
          return SvgPicture.memory(
            bytes ?? Uint8List(0),
            colorFilter: colorFilter,
            width: width,
            height: height,
            fit: fit,
            placeholderBuilder: placeholderBuilder,
            errorBuilder: (_, __, ___) => errorWidget,
          );
      }
    } catch (e) {
      return errorWidget;
    }
  }
}
