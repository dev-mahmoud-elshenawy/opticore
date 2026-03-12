/// Exception thrown when no internet connection is detected before making a request.
///
/// Used by [NetworkHelper] when a connectivity check fails prior to an API call,
/// and detected by [ApiResponse.exception] to classify the error as [ApiResponseType.noInternetError].
class NoInternetException implements Exception {
  const NoInternetException();

  @override
  String toString() => 'NoInternetException: No internet connection available.';
}
