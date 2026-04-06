part of '../import/base_import.dart';

/// [BaseBloc] serves as the foundational class for managing state transitions
/// in a reactive application architecture using the BLoC pattern.
///
/// This abstract class extends [Bloc] from the `flutter_bloc` package and
/// provides common utilities for handling API responses, managing various
/// error states, and enabling easy navigation during specific scenarios.
///
/// ### Key Features:
/// - **Centralized Handling of API Responses**:
///   The [handleApiResponse] method processes API responses and transitions
///   to appropriate states based on the type of response:
///   - Success: Managed using [stateFactory] or a default state.
///   - API Errors: Handled by [handleApiError] and [handleErrorAndException].
///   - Network Errors: Managed using [handleNetworkException].
///   - Parsing Errors: Also processed by [handleNetworkException].
///   - No Internet Connection: Redirected using [handleNoInternetException].
///   - Unauthorized Errors: Managed with [handleUnAuthorizedException].
///
/// - **Simplified State Management**:
///   Through the [BaseFactory], states are dynamically created, reducing
///   repetitive state initialization logic.
///
/// - **Error Classification**:
///   Helper methods such as [returnErrorHandler], [handleApiError], and
///   [handleErrorAndException] provide detailed classification and processing
///   for different error types, ensuring consistency across the application.
///
/// - **Navigation Utility**:
///   The [_navigate] method supports navigation to error-specific screens such as:
///   - [NoInternetScreen]: Displayed during no internet scenarios via [handleNoInternetException].
///   - [MaintenanceScreen]: Triggered during server maintenance through [handleServerErrorException].
///
/// - **Lifecycle Management**:
///   Implements [onDispose] and overrides [close] to ensure resources are properly
///   released when the BLoC is disposed.
abstract class BaseBloc extends Bloc<BaseEvent, BaseState> {
  /// Factory for creating specific states dynamically based on the API response.
  final BaseFactory? stateFactory;

  /// Constructor for initializing the [BaseBloc].
  ///
  /// If a [BaseFactory] is not provided, the [DefaultFactory] is used.
  /// The initial state is set to [InitialState] if not explicitly provided.
  BaseBloc(
    BaseFactory? stateFactory, {
    BaseState? initialState,
  })  : stateFactory = stateFactory ?? DefaultFactory(),
        super(initialState ?? InitialState());

  /// A lifecycle method to clean up resources when the [BaseBloc] is disposed.
  void onDispose() {}

  @override
  Future<void> close() {
    onDispose();
    return super.close();
  }

  /// Handles API responses and determines the next state based on the response type.
  ///
  /// ### Scenarios Handled:
  /// 1. **Success**: Retrieves and returns the appropriate state using the [stateFactory].
  /// 2. **API Error**: Processes errors like unauthorized access or server-side validation failures.
  /// 3. **Network Errors**: Handles issues such as connectivity or request failures.
  /// 4. **Parsing Errors**: Manages cases where API responses are not in the expected format.
  /// 5. **No Internet Errors**: Navigates to a no-internet screen and retries the operation when requested.
  ///
  /// #### Parameters:
  /// - [apiResponse]: The API response to handle.
  /// - [onApiErrorAction]: Callback for specific API error handling actions.
  /// - [errorType]: Optional string to categorize the error type.
  /// - [retryFunc]: Function to retry the operation on certain errors (e.g., network or server errors).
  ///
  /// #### Returns:
  /// - [BaseState]: The next state of the application.
  ///
  /// ### Example:
  /// ```dart
  /// return handleApiResponse(
  /// apiResponse,
  /// onApiErrorAction: onApiErrorAction,
  /// errorType: errorType,
  /// retryFunc: retryFunc,
  /// );
  /// ```
  BaseState handleApiResponse<M>(
    ApiResponse<M>? apiResponse, {
    BaseState? Function(int?, String?)? onApiErrorAction,
    String? errorType,
    Function? retryFunc,
  }) {
    Logger.info(
        "BaseBloc | API RESPONSE: ${apiResponse?.type} - ${stateFactory.runtimeType}");

    if (apiResponse == null) {
      return returnErrorHandler(
        errorMsg: "Invalid API response",
        errorType: errorType,
        apiErrorType: ApiResponseType.apiError,
      );
    }

    try {
      /// Success
      if (apiResponse.type == ApiResponseType.success) {
        if (stateFactory != null) {
          return stateFactory!.getState(apiResponse.data);
        } else {
          Logger.debug(
              "BaseBloc | stateFactory is null. Returning default state.");
          return DefaultState();
        }
      }

      /// API Error
      else if (apiResponse.type == ApiResponseType.apiError ||
          apiResponse.type == ApiResponseType.unauthorizedError) {
        Logger.debug(
            "BaseBloc | API Error ${apiResponse.apiError} - Type: $errorType");
        return handleErrorAndException(
          apiResponse,
          onApiErrorAction: onApiErrorAction,
          errorType: errorType,
        );
      }

      /// Network || Parsing Error
      else if (apiResponse.type == ApiResponseType.networkError ||
          apiResponse.type == ApiResponseType.parsingError) {
        Logger.debug("BaseBloc | Network Error ${apiResponse.apiError}");
        return handleNetworkException(
          apiResponse,
          errorType: errorType,
        );
      }

      /// Server Error
      else if (apiResponse.type == ApiResponseType.serverError) {
        Logger.debug("BaseBloc | Server Error ${apiResponse.apiError}");
        return handleServerErrorException(
          apiResponse,
          errorType: errorType,
          retryFunc: retryFunc,
        );
      }

      /// No Internet Error
      else if (apiResponse.type == ApiResponseType.noInternetError) {
        Logger.debug("BaseBloc | No Internet Error ${apiResponse.apiError}");
        return handleNoInternetException(
          apiResponse,
          errorType: errorType,
          retryFunc: retryFunc,
        );
      }
    } catch (exception, stackTrace) {
      Logger.error("BaseBloc | exception: $exception\n$stackTrace");

      /// Error
      return returnErrorHandler(
        isException: true,
        errorType: errorType,
        apiErrorType: ApiResponseType.apiError,
      );
    }

    // Fallback for unhandled response types
    return returnErrorHandler(
      errorMsg: "Unhandled API response type: ${apiResponse.type}",
      errorType: errorType,
      apiErrorType: ApiResponseType.apiError,
    );
  }

  /// Handles API and network-related errors, including unauthorized access.
  ///
  /// #### Parameters:
  /// - [apiResponse]: The API response containing the error details.
  /// - [onApiErrorAction]: Optional callback for specific API error handling.
  /// - [errorType]: Optional string indicating the error type.
  ///
  /// #### Returns:
  /// - [BaseState]: The appropriate error state.
  ///
  /// ### Example:
  /// ```dart
  /// return handleErrorAndException(
  /// apiResponse,
  /// onApiErrorAction: onApiErrorAction,
  /// errorType: errorType,
  /// );
  /// ```
  BaseState handleErrorAndException<M>(
    ApiResponse<M>? apiResponse, {
    BaseState? Function(int?, String?)? onApiErrorAction,
    String? errorType,
  }) {
    try {
      /// Api Error
      if (apiResponse?.type == ApiResponseType.apiError) {
        return handleApiError(
          apiResponse,
          onApiErrorAction: onApiErrorAction,
          errorType: errorType,
        );
      } else if (apiResponse?.type == ApiResponseType.unauthorizedError) {
        return handleUnAuthorizedException(
          apiResponse,
          errorType: errorType,
        );
      }

      /// Network Error
      else if (apiResponse?.type == ApiResponseType.networkError) {
        return handleNetworkException(
          apiResponse,
          errorType: errorType,
        );
      }
    } catch (exception) {
      Logger.debug("BaseBloc | Error Handler${exception.toString()}");

      /// Error
      return returnErrorHandler(
        isException: true,
        errorType: errorType,
        apiErrorType: ApiResponseType.apiError,
      );
    }

    // Fallback for unmatched error types
    return returnErrorHandler(
      errorMsg: "Unhandled error type",
      errorType: errorType,
      apiErrorType: ApiResponseType.apiError,
    );
  }

  /// Handles API errors, such as unauthorized access or server-side validation failures.
  ///
  /// #### Parameters:
  /// - [apiResponse]: The API response containing the error details.
  /// - [onApiErrorAction]: Optional callback for specific API error handling.
  /// - [errorType]: Optional string indicating the error type.
  ///
  /// #### Returns:
  /// - [BaseState]: The appropriate error state.
  ///
  /// ### Example:
  /// ```dart
  /// return handleApiError(
  /// apiResponse,
  /// onApiErrorAction: onApiErrorAction,
  /// errorType: errorType,
  /// );
  /// ```
  BaseState handleApiError<M>(
    ApiResponse<M>? apiResponse, {
    BaseState? Function(int?, String?)? onApiErrorAction,
    String? errorType,
  }) {
    if (apiResponse == null) {
      return returnErrorHandler(
        errorMsg: "Invalid API response",
        errorType: errorType,
        apiErrorType: ApiResponseType.apiError,
      );
    }

    /// Un-Authorized
    if (apiResponse.statusCode == 401) {
      /// Error (Non Render)
      // No need to handle Render Case because it always navigates to Splash Screen and remove User Cache
      return ErrorStateNonRender(
        errorMessage: "",
        type: ApiResponseType.unauthorizedError,
      );
    }

    /// Api Error Action
    if (onApiErrorAction != null) {
      return onApiErrorAction(
            apiResponse.statusCode,
            (apiResponse.apiError ?? []).firstOrNull ?? "An error occurred",
          ) ??
          returnErrorHandler(
            errorMsg: "An error occurred",
            errorType: errorType,
            apiErrorType: ApiResponseType.apiError,
          );
    }

    /// Default error handling
    return returnErrorHandler(
      errorMsg: (apiResponse.apiError ?? []).firstOrNull ?? "An error occurred",
      errorType: errorType,
      apiErrorType: ApiResponseType.apiError,
    );
  }

  /// Handles network-related errors, such as connectivity issues or request failures.
  ///
  /// #### Parameters:
  /// - [apiResponse]: The API response containing the error details.
  /// - [errorType]: Optional string indicating the error type.
  ///
  /// #### Returns:
  /// - [BaseState]: The appropriate error state.
  ///
  /// ### Example:
  /// ```dart
  /// return handleNetworkException(
  /// apiResponse,
  /// errorType: errorType,
  /// );
  /// ```
  BaseState handleNetworkException(
    ApiResponse<dynamic>? apiResponse, {
    String? errorType,
  }) {
    if (apiResponse == null) {
      return returnErrorHandler(
        errorMsg: "Network error occurred",
        errorType: errorType,
        apiErrorType: ApiResponseType.networkError,
      );
    }

    if (apiResponse.type == ApiResponseType.networkError) {
      return returnErrorHandler(
        errorMsg: apiResponse.exceptionMessage,
        errorType: errorType,
        apiErrorType: ApiResponseType.networkError,
      );
    } else if (apiResponse.type == ApiResponseType.parsingError) {
      return returnErrorHandler(
        errorMsg: kDebugMode
            ? apiResponse.exceptionMessage
            : ApiResponseConfig.errorMessage,
        errorType: errorType,
        apiErrorType: ApiResponseType.parsingError,
      );
    }

    // Fallback
    return returnErrorHandler(
      errorMsg: apiResponse.exceptionMessage ?? "An error occurred",
      errorType: errorType,
      apiErrorType: apiResponse.type ?? ApiResponseType.networkError,
    );
  }

  /// Handles no internet connection errors.
  ///
  /// #### Parameters:
  /// - [apiResponse]: The API response containing the error details.
  /// - [errorType]: Optional string indicating the error type.
  /// - [retryFunc]: Function to retry the operation on certain errors (e.g., network or server errors).
  ///
  /// #### Returns:
  /// - [BaseState]: The appropriate error state.
  ///
  /// ### Example:
  /// ```dart
  /// return handleNoInternetException(
  /// apiResponse,
  /// errorType: errorType,
  /// retryFunc: retryFunc,
  /// );
  /// ```
  BaseState handleNoInternetException(
    ApiResponse<dynamic>? apiResponse, {
    String? errorType,
    Function? retryFunc,
  }) {
    if (apiResponse?.type == ApiResponseType.noInternetError) {
      // If the NoInternetScreen is already displayed, return a silent state.
      // The screen already owns the recovery flow (retry button), so emitting
      // another ErrorStateNonRender is redundant and causes duplicate
      // bottom sheets / toasts in consumer apps.
      if (InternetConnectionHandler.isNoInternetSceneShown) {
        return NullNonRenderState();
      }

      _navigate(
        NoInternetScreen(
          refreshCallBack: () {
            retryFunc?.call();
          },
        ),
      );

      return returnErrorHandler(
        errorMsg: apiResponse?.exceptionMessage,
        errorType: ErrorType.none,
        apiErrorType: ApiResponseType.noInternetError,
      );
    }

    return returnErrorHandler(
      errorMsg: apiResponse?.exceptionMessage ?? "No internet connection",
      errorType: errorType,
      apiErrorType: ApiResponseType.noInternetError,
    );
  }

  /// Handles server errors, such as maintenance or server-side issues.
  ///
  /// #### Parameters:
  /// - [apiResponse]: The API response containing the error details.
  /// - [errorType]: Optional string indicating the error type.
  /// - [retryFunc]: Function to retry the operation on certain errors (e.g., network or server errors).
  ///
  /// #### Returns:
  /// - [BaseState]: The appropriate error state.
  ///
  /// ### Example:
  /// ```dart
  /// return handleServerErrorException(
  /// apiResponse,
  /// errorType: errorType,
  /// retryFunc: retryFunc,
  /// );
  /// ```
  BaseState handleServerErrorException(
    ApiResponse<dynamic>? apiResponse, {
    String? errorType,
    Function? retryFunc,
  }) {
    if (apiResponse?.type == ApiResponseType.serverError) {
      _navigate(
        MaintenanceScreen(
          refreshCallBack: () {
            retryFunc?.call();
          },
        ),
      );

      return returnErrorHandler(
        errorMsg: apiResponse?.exceptionMessage,
        errorType: ErrorType.none,
        apiErrorType: ApiResponseType.serverError,
      );
    }

    return returnErrorHandler(
      errorMsg: apiResponse?.exceptionMessage ?? "Server error occurred",
      errorType: errorType,
      apiErrorType: ApiResponseType.serverError,
    );
  }

  /// Handles unauthorized access errors.
  ///
  /// #### Parameters:
  /// - [apiResponse]: The API response containing the error details.
  /// - [errorType]: Optional string indicating the error type.
  /// - [retryFunc]: Function to retry the operation on certain errors (e.g., network or server errors).
  ///
  /// #### Returns:
  /// - [BaseState]: The appropriate error state.
  ///
  /// ### Example:
  /// ```dart
  /// return handleUnAuthorizedException(
  ///  apiResponse,
  ///  errorType: errorType,
  ///  retryFunc: retryFunc,
  ///  );
  ///  ```
  BaseState handleUnAuthorizedException(
    ApiResponse<dynamic>? apiResponse, {
    String? errorType,
    Function? retryFunc,
  }) {
    if (apiResponse?.type == ApiResponseType.unauthorizedError) {
      return returnErrorHandler(
        errorMsg: apiResponse?.exceptionMessage,
        errorType: ErrorType.none,
        apiErrorType: ApiResponseType.unauthorizedError,
      );
    }

    return returnErrorHandler(
      errorMsg: "Unknown authorization error",
      errorType: ErrorType.nonRender,
      apiErrorType: ApiResponseType.unauthorizedError,
    );
  }

  /// Returns an error state based on the error type and message.
  ///
  /// #### Parameters:
  /// - [errorMsg]: The error message to display.
  /// - [isException]: A boolean indicating if the error is an exception.
  /// - [errorType]: The type of error to handle.
  /// - [apiErrorType]: The type of API error to manage.
  ///
  /// #### Returns:
  /// - [BaseState]: The appropriate error state.
  ///
  /// ### Example:
  /// ```dart
  /// return returnErrorHandler(
  ///  errorMsg: 'An error occurred',
  ///  errorType: ErrorType.RENDER,
  ///  apiErrorType: ApiResponseType.API_ERROR,
  ///  );
  ///  ```
  BaseState returnErrorHandler({
    String? errorMsg,
    bool isException = false,
    String? errorType,
    ApiResponseType? apiErrorType,
  }) {
    if (errorType == ErrorType.render) {
      return isException
          ? ErrorStateRender.exception()
          : ErrorStateRender(errorMessage: errorMsg);
    } else if (errorType == ErrorType.none) {
      return ErrorStateNonRender(
        errorMessage: '',
        type: apiErrorType ?? ApiResponseType.none,
      );
    } else {
      return isException
          ? ErrorStateNonRender.exception()
          : ErrorStateNonRender(
              errorMessage: errorMsg ?? 'Sorry, an error occurred',
              type: apiErrorType ?? ApiResponseType.none,
            );
    }
  }

  /// Tracks the last navigation time **per screen type** so that different
  /// error screens (no-internet, maintenance) do not block each other.
  static final Map<Type, DateTime> _lastNavigateTime = {};

  /// Minimum interval between navigations of the **same** screen type.
  static const Duration _navigateDebounce = Duration(seconds: 10);

  /// Navigates to an error-specific screen using [RouteHelper.navigatorKey].
  ///
  /// Uses a per-screen-type debounce to prevent duplicate navigations of the
  /// same kind (e.g. multiple concurrent API failures all trying to push
  /// [NoInternetScreen]), while still allowing different screen types to
  /// navigate independently.
  void _navigate(Widget screen) {
    final screenType = screen.runtimeType;
    final now = DateTime.now();
    final lastTime = _lastNavigateTime[screenType];

    if (lastTime != null && now.difference(lastTime) < _navigateDebounce) {
      return;
    }

    _lastNavigateTime[screenType] = now;
    RouteHelper.navigatorKey.currentState?.push(
      CupertinoPageRoute(builder: (_) => screen),
    );
  }
}
