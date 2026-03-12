import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/services.dart';

/// Configures the Dio HTTP client adapter for native (IO) platforms.
///
/// Sets up [IOHttpClientAdapter] with optional SSL certificate pinning.
/// When [secureContext] is non-null, only trusted certificates are accepted.
/// When null, all certificates are accepted (no pinning).
void configureDioAdapter(Dio dio, dynamic secureContext) {
  dio.httpClientAdapter = IOHttpClientAdapter(
    createHttpClient: () {
      final httpClient = HttpClient(context: secureContext as SecurityContext?);
      if (secureContext != null) {
        httpClient.badCertificateCallback = (cert, host, port) {
          return false;
        };
      } else {
        httpClient.badCertificateCallback = (cert, host, port) => true;
      }
      return httpClient;
    },
  );
}

/// Loads a PEM certificate from [data] and returns a [SecurityContext].
Future<dynamic> createSecurityContext(ByteData data) async {
  final securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  return securityContext;
}
