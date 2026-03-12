/// Stub [File] class for web/WASM platforms where `dart:io` is unavailable.
///
/// This provides the minimal API surface used by [SvgWidget] so the code
/// compiles on all platforms. On native platforms the real `dart:io` [File]
/// is used instead via conditional import.
class File {
  final String path;
  const File(this.path);
}
