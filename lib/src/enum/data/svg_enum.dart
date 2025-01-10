part of '../enum_import.dart';

/// Enum for representing different types of SVG sources.
///
/// This enum defines the possible types of SVG sources that can be used in the application.
/// It allows distinguishing between various methods of loading SVG files, such as from assets, network, or memory.
/// This is useful when deciding how to render or load SVG content in your application.
///
/// **Enum Values:**
/// - [asset]: The SVG is loaded from the app's asset bundle.
/// - [network]: The SVG is loaded from a remote network URL.
/// - [file]: The SVG is loaded from a local file on the device.
/// - [memory]: The SVG is stored in memory as a raw byte array or data.
/// - [string]: The SVG is provided as a string of XML data.
enum SvgType {
  /// The SVG is loaded from the app's asset bundle.
  asset,

  /// The SVG is loaded from a remote network URL.
  network,

  /// The SVG is loaded from a local file on the device.
  file,

  /// The SVG is stored in memory as a raw byte array or data.
  memory,

  /// The SVG is provided as a string of XML data.
  string,
}
