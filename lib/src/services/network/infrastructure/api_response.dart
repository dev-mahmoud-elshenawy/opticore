part of '../../services_import.dart';

/// A class that encapsulates the response from an API call.
///
/// The `ApiResponse` class is designed to manage and represent various
/// outcomes from API requests. It provides a structured way to handle
/// successful responses, errors, and exceptions that may occur during
/// communication with the server. It is a generic class, allowing for
/// flexibility in handling responses of different data types.
///
/// ### Key Features:
/// - **Type Handling**: Differentiates between success, API errors, server errors,
///   network errors, and parsing errors using the `ApiResponseType` enum.
/// - **Status Code**: Captures the HTTP status code from the server response
///   to help in identifying the nature of the response (e.g., 200 for success, 401 for unauthorized).
/// - **Error Management**: Provides a mechanism to manage error codes, messages,
///   and exception details to handle failures more effectively.
/// - **Data Handling**: Contains the actual response data (if any), allowing for
///   easy access to the result of a successful API call.
///
/// ### Usage Example:
/// ```dart
/// ApiResponse<String> response = ApiResponse.success(dioResponse, (data) => data['message']);
/// response.handleResponse(
///   onSuccess: (data) => print('Success: $data'),
///   onFailure: (errorMessage) => print('Error: $errorMessage'),
/// );
/// ```
///
/// ### Factory Methods:
/// - `success`: Creates a successful response when the API request is successful.
/// - `error`: Creates an error response when an API error is encountered.
/// - `exception`: Creates a response for network-related exceptions (e.g., timeouts).
/// - `parsingError`: Creates a response when parsing the API response fails.
///
/// This class is particularly useful in situations where API responses
/// may vary, providing a consistent way to manage these variations
/// throughout the application.
class ApiResponse<M> {
  /// The type of the API response (success, error, etc.)
  ApiResponseType? type;

  /// The HTTP status code from the API response
  int? statusCode;

  /// The error code returned by the API, if any
  int? code;

  /// The exception message, if an exception occurred during the request
  String? exceptionMessage;

  /// A list of error messages returned by the API
  List<String>? apiError;

  /// The data returned by the API, if any
  M? data;

  /// Constructor to initialize the ApiResponse with optional values
  ///
  /// This constructor allows for the creation of an `ApiResponse` object
  /// with values passed as parameters. You can use this to initialize
  /// the class with response type, status code, exception messages, etc.
  ///
  /// Example usage:
  /// ```dart
  /// var response = ApiResponse<String>(type: ApiResponseType.SUCCESS, statusCode: 200, data: "Success");
  /// ```
  ApiResponse({
    this.type,
    this.statusCode,
    this.code,
    this.exceptionMessage,
    this.apiError,
    this.data,
  });

  /// Factory constructor that creates a successful API response.
  ///
  /// This method is used to create a successful API response. It takes
  /// the `Response` object returned by the Dio library and a `create` function
  /// that helps in parsing the API response data into the desired data type.
  /// It checks if the status code is in the range of 200 to 299 to signify success.
  ///
  /// Example usage:
  /// ```dart
  /// var response = ApiResponse.success(dioResponse, (data) => data['message']);
  /// ```
  factory ApiResponse.success(
    Response dioResponse,
    Function(Map<String, dynamic>?)? create,
  ) {
    try {
      if (dioResponse.statusCode != null &&
          dioResponse.statusCode! >= 200 &&
          dioResponse.statusCode! <= 299) {
        return ApiResponse<M>(
          type: ApiResponseType.success,
          statusCode: dioResponse.statusCode,
          data: create!(dioResponse.data),
        );
      } else {
        throw Exception('Unexpected status code: ${dioResponse.statusCode}');
      }
    } catch (e, stackTrace) {
      Logger.error('Error while parsing successful response: $e\n$stackTrace');
      return ApiResponse<M>.parsingError(e, stackTrace);
    }
  }

  /// A method to handle response logic based on the response type.
  ///
  /// This method provides an easy way to handle various types of responses
  /// by defining the logic for success, failure, network errors, and parsing
  /// errors. Based on the response type (`SUCCESS`, `API_ERROR`, etc.),
  /// corresponding callback functions are executed.
  ///
  /// Example usage:
  /// ```dart
  /// response.handleResponse(
  ///   onSuccess: (data) => print('Success: $data'),
  ///   onFailure: (errorMessage) => print('Error: $errorMessage'),
  /// );
  /// ```
  void handleResponse({
    required void Function(M data) onSuccess,
    required void Function(String errorMessage) onFailure,
    void Function(String? message)? onNetworkError,
    void Function(String? message)? onParsingError,
  }) {
    switch (type) {
      case ApiResponseType.success:
        if (data != null) {
          onSuccess(data as M);
        }
        break;

      case ApiResponseType.apiError:
      case ApiResponseType.serverError:
      case ApiResponseType.unauthorizedError:
        if (apiError != null && (apiError ?? []).isNotEmpty) {
          onFailure(apiError!.join(', '));
        } else {
          onFailure(ApiResponseConfig.errorMessage);
        }
        break;

      case ApiResponseType.networkError:
        if (onNetworkError != null) {
          onNetworkError(exceptionMessage);
        }
        break;

      case ApiResponseType.parsingError:
        if (onParsingError != null) {
          onParsingError(exceptionMessage);
        }
        break;

      default:
        onFailure(ApiResponseConfig.errorMessage);
    }
  }

  /// Factory constructor that creates an error response.
  ///
  /// This factory constructor handles error responses returned by Dio.
  /// It takes a `DioException` and extracts error messages from the response.
  /// Based on the error status code, it determines the type of error (`API_ERROR`, `SERVER_ERROR`, etc.)
  ///
  /// Example usage:
  /// ```dart
  /// var response = ApiResponse.error(dioError);
  /// ```
  factory ApiResponse.error(DioException dioError) {
    Logger.error("API ERROR: ${dioError.response?.statusCode}");
    List<String> errors = _extractApiErrors(dioError);

    ApiResponseType type = _getApiErrorType(dioError);

    final responseData = dioError.response?.data;
    final statusCode = dioError.response?.statusCode;

    return ApiResponse<M>(
      type: type,
      statusCode: statusCode,
      exceptionMessage: errors.firstOrNull ?? ApiResponseConfig.errorMessage,
      code: (responseData is Map && responseData.containsKey('code'))
          ? _parseCodeValue(responseData['code'])
          : 0,
    );
  }

  /// Factory constructor that creates a response for network-related exceptions.
  ///
  /// This factory constructor handles network-related exceptions, such as
  /// timeouts or connection issues. It returns a response indicating a
  /// network error and includes an appropriate exception message.
  ///
  /// Example usage:
  /// ```dart
  /// var response = ApiResponse.exception(exception);
  /// ```
  factory ApiResponse.exception(Exception exception) {
    Logger.error("Exception caught: $exception");
    if (exception is TimeoutException) {
      return ApiResponse<M>(
        type: ApiResponseType.networkError,
        exceptionMessage: ApiResponseConfig.requestTimeoutMessage,
      );
    } else if (exception.toString().contains("487")) {
      return ApiResponse<M>(
        type: ApiResponseType.noInternetError,
        exceptionMessage: ApiResponseConfig.networkIssuesMessage,
      );
    } else {
      return ApiResponse<M>(
        type: ApiResponseType.networkError,
        exceptionMessage: ApiResponseConfig.errorMessage,
      );
    }
  }

  /// Factory constructor that creates a response for parsing errors.
  ///
  /// This factory constructor handles parsing errors when the API response
  /// cannot be properly processed. It returns an `ApiResponse` with a
  /// parsing error type and an appropriate exception message.
  ///
  /// Example usage:
  /// ```dart
  /// var response = ApiResponse.parsingError(error, stackTrace);
  /// ```
  factory ApiResponse.parsingError(dynamic error, StackTrace? stackTrace) {
    Logger.debug("Parsing error occurred: $error\n$stackTrace");
    return ApiResponse<M>(
      type: ApiResponseType.parsingError,
      exceptionMessage: "Failed to parse the response data.",
    );
  }

  /// A helper method to extract error messages from the Dio error response.
  ///
  /// This method extracts error messages from the `DioException` response.
  /// It handles cases where the error message is nested or not available.
  ///
  /// Example usage:
  /// ```dart
  /// var errors = _extractApiErrors(dioError);
  /// ```
  static List<String> _extractApiErrors(DioException dioError) {
    List<String> errors = [];
    if (dioError.response != null) {
      try {
        errors.add(
          dioError.response?.data["message"] ?? ApiResponseConfig.errorMessage,
        );
      } catch (e) {
        Logger.error('Error extracting API error message: $e');
        errors.add(ApiResponseConfig.errorMessage);
      }
    }
    return errors;
  }

  /// A helper method to determine the type of error response.
  ///
  /// This method inspects the `DioException` to determine the type of error
  /// (API error, server error, etc.) based on the status code of the response.
  ///
  /// Example usage:
  /// ```dart
  /// var errorType = _getApiErrorType(dioError);
  /// ```
  static ApiResponseType _getApiErrorType(DioException dioError) {
    int? statusCode = dioError.response?.statusCode ?? 0;
    if (statusCode == 401) {
      if (UnAuthenticatedConfig.onUnauthenticated != null) {
        UnAuthenticatedConfig.onUnauthenticated!();
      }
      return ApiResponseType.unauthorizedError;
    } else if (statusCode >= 500) {
      return ApiResponseType.serverError;
    } else {
      return ApiResponseType.apiError;
    }
  }

  /// Helper method to safely parse code values from various types to int
  static int _parseCodeValue(dynamic codeValue) {
    if (codeValue == null) {
      return 0;
    }

    if (codeValue is int) {
      return codeValue;
    }

    if (codeValue is String) {
      try {
        return int.parse(codeValue);
      } catch (e) {
        Logger.error('Error parsing code value: $e');
        return 0;
      }
    }

    return 0;
  }
}
