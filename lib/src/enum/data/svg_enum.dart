part of '../enum_import.dart';

/// Enum for representing different types of SVG sources.
///
/// This enum defines the possible types of SVG sources that can be used in the application.
/// It allows distinguishing between various methods of loading SVG files, such as from assets, network, or memory.
/// This is useful when deciding how to render or load SVG content in your application.
///
/// **Enum Values:**
/// - [ASSET]: The SVG is loaded from the app's asset bundle.
/// - [NETWORK]: The SVG is loaded from a remote network URL.
/// - [FILE]: The SVG is loaded from a local file on the device.
/// - [MEMORY]: The SVG is stored in memory as a raw byte array or data.
/// - [STRING]: The SVG is provided as a string of XML data.
enum SvgType {
  /// The SVG is loaded from the app's asset bundle.
  ASSET,

  /// The SVG is loaded from a remote network URL.
  NETWORK,

  /// The SVG is loaded from a local file on the device.
  FILE,

  /// The SVG is stored in memory as a raw byte array or data.
  MEMORY,

  /// The SVG is provided as a string of XML data.
  STRING,
}
