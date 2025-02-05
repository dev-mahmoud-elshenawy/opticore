part of '../util_import.dart';

/// A wrapper class representing the state of an asynchronous operation.
///
/// The `AsyncValue<T>` class helps manage loading, success, and error states
/// for any asynchronous operation. It provides a structured way to handle
/// and propagate async state in a **clean and readable** manner.
///
/// ## Usage
/// ```dart
/// Future<AsyncValue<List<User>>> fetchUsers() async {
///   return await AsyncValue.guard(() async {
///     final users = await api.getUsers();
///     return users;
///   });
/// }
/// ```
abstract class AsyncValue<T> extends Equatable {
  const AsyncValue();

  /// Executes an asynchronous function and wraps its result inside an [AsyncValue].
  ///
  /// - Returns **[AsyncData]** if the operation succeeds.
  /// - Returns **[AsyncError]** if an error occurs.
  ///
  /// ## Example
  /// ```dart
  /// final result = await AsyncValue.guard(() async => fetchUsers());
  /// if (result is AsyncData) {
  ///   print('Users loaded: ${result.data}');
  /// } else if (result is AsyncError) {
  ///   print('Error: ${result.error}');
  /// }
  /// ```
  static Future<AsyncValue<T>> guard<T>(Future<T> Function() future) async {
    try {
      return AsyncData(await future());
    } catch (error, stack) {
      return AsyncError(error, stackTrace: stack);
    }
  }

  @override
  List<Object?> get props => [];
}

/// Represents the **initial state** before any async operation starts.
///
/// This state is **usually used as the default state** when initializing a BLoC.
class AsyncInitial<T> extends AsyncValue<T> {}

/// Represents a **loading state** when an async operation is in progress.
///
/// This state is **useful for showing loading indicators** in the UI.
class AsyncLoading<T> extends AsyncValue<T> {}

/// Represents a **successful result** from an async operation.
///
/// The retrieved data is stored in the `data` property.
///
/// ## Example
/// ```dart
/// AsyncValue<List<String>> result = AsyncData(["Item 1", "Item 2"]);
/// print(result.data); // Output: ["Item 1", "Item 2"]
/// ```
class AsyncData<T> extends AsyncValue<T> {
  final T data;

  const AsyncData(this.data);

  @override
  List<Object?> get props => [data];
}

/// Represents an **error state** when an async operation fails.
///
/// The `error` contains the actual exception, while `stackTrace` helps with debugging.
///
/// ## Example
/// ```dart
/// AsyncValue<String> result = AsyncError("Failed to fetch data");
/// print(result.error); // Output: "Failed to fetch data"
/// ```
class AsyncError<T> extends AsyncValue<T> {
  final Object error;
  final StackTrace? stackTrace;

  const AsyncError(this.error, {this.stackTrace});

  @override
  List<Object?> get props => [error, stackTrace];
}

/// A **generic BLoC** for managing asynchronous operations in a structured manner.
///
/// This class provides:
/// - **Automatic state management**: No need to manually handle `try-catch`
/// - **Clean UI updates**: Emits **[AsyncLoading]**, **[AsyncData]**, or **[AsyncError]**
///
/// ## Example Usage
/// ```dart
/// class UserBloc extends AsyncBloc<List<User>> {
///   Future<void> loadUsers() async {
///     execute(() async => api.getUsers());
///   }
/// }
///
/// final userBloc = UserBloc();
/// userBloc.loadUsers();
/// ```
class AsyncBloc<T> extends Cubit<AsyncValue<T>> {
  AsyncBloc() : super(AsyncInitial<T>());

  /// Executes an asynchronous function and automatically updates the state.
  ///
  /// - **Before Execution:** Emits **[AsyncLoading]**.
  /// - **On Success:** Emits **[AsyncData]** with the retrieved data.
  /// - **On Failure:** Emits **[AsyncError]** with the error details.
  ///
  /// ## Example
  /// ```dart
  /// final userBloc = AsyncBloc<List<User>>();
  /// userBloc.execute(() async => api.fetchUsers());
  /// ```
  Future<void> execute(Future<T> Function() asyncFunction) async {
    emit(AsyncLoading<T>()); // Show loading state
    emit(await AsyncValue.guard(
      asyncFunction,
    )); // Automatically handles success/error
  }
}
