import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

/// No-op adapter configuration for web/WASM platforms.
///
/// SSL certificate pinning is not supported on web platforms.
/// The default Dio adapter is used instead.
void configureDioAdapter(Dio dio, dynamic secureContext) {
  // Web uses the default browser HTTP client — no custom adapter needed.
}

/// SSL certificate loading is not supported on web platforms.
/// Always returns null.
Future<dynamic> createSecurityContext(ByteData data) async {
  return null;
}
