part of '../import/base_import.dart';

/// A reactive notifier for handling asynchronous operations with built-in
/// loading, error, and data states.
///
/// This class wraps async operations and automatically manages state transitions,
/// making it easy to show loading indicators, handle errors, and display data.
///
/// ## Examples
///
/// ### Basic Usage
/// ```dart
/// final users = AsyncReactiveNotifier<List<User>>();
///
/// // Execute an async operation
/// await users.execute(() => api.fetchUsers());
///
/// // Check states
/// if (users.isLoading) print('Loading...');
/// if (users.hasError) print('Error: ${users.error}');
/// if (users.hasData) print('Users: ${users.valueOrNull}');
/// ```
///
/// ### With Reactive.async Widget
/// ```dart
/// Reactive<List<User>>.async(
///   notifier: users,
///   loading: (context) => const Center(
///     child: CircularProgressIndicator(),
///   ),
///   error: (context, error, stackTrace) => Center(
///     child: Column(
///       children: [
///         Text('Error: $error'),
///         ElevatedButton(
///           onPressed: () => users.execute(() => api.fetchUsers()),
///           child: Text('Retry'),
///         ),
///       ],
///     ),
///   ),
///   data: (context, users) => ListView.builder(
///     itemCount: users.length,
///     itemBuilder: (context, index) => Text(users[index].name),
///   ),
/// )
/// ```
///
/// ### With Initial Data
/// ```dart
/// // Start with cached data
/// final users = AsyncReactiveNotifier<List<User>>.withData(cachedUsers);
///
/// // Later refresh from API
/// users.execute(() => api.fetchUsers());
/// ```
///
/// ### Update Existing Data
/// ```dart
/// final users = AsyncReactiveNotifier<List<User>>();
/// await users.execute(() => api.fetchUsers());
///
/// // Add a new user without refetching
/// users.updateData((list) => [...list, newUser]);
///
/// // Remove a user
/// users.updateData((list) => list.where((u) => u.id != deletedId).toList());
/// ```
///
/// ### Manual State Control
/// ```dart
/// final users = AsyncReactiveNotifier<List<User>>();
///
/// // Set states manually
/// users.setLoading();
/// users.setData([user1, user2]);
/// users.setError(Exception('Something went wrong'));
/// users.reset();  // Back to initial state
/// ```
///
/// See also:
/// - [ReactiveNotifier] for synchronous value changes
/// - [Reactive] for building UI that responds to changes
/// - [AsyncValue] for the underlying state representation
class AsyncReactiveNotifier<T> extends ChangeNotifier {
  /// Creates an [AsyncReactiveNotifier] with an initial state.
  ///
  /// By default, starts in [AsyncInitial] state. You can optionally
  /// provide initial data using [AsyncReactiveNotifier.withData].
  AsyncReactiveNotifier() : _state = AsyncInitial<T>();

  /// Creates an [AsyncReactiveNotifier] with initial data.
  ///
  /// ### Example
  /// ```dart
  /// final counter = AsyncReactiveNotifier<int>.withData(0);
  /// print(counter.hasData); // true
  /// print(counter.valueOrNull); // 0
  /// ```
  AsyncReactiveNotifier.withData(T data) : _state = AsyncData<T>(data);

  AsyncValue<T> _state;

  /// The current async state.
  ///
  /// Can be one of:
  /// - [AsyncInitial] - Before any operation
  /// - [AsyncLoading] - Operation in progress
  /// - [AsyncData] - Operation completed successfully
  /// - [AsyncError] - Operation failed
  AsyncValue<T> get state => _state;

  /// Returns the data if available, otherwise null.
  ///
  /// This is a convenience getter for safely accessing data without
  /// type checking.
  T? get valueOrNull =>
      _state is AsyncData<T> ? (_state as AsyncData<T>).data : null;

  /// Returns the error if in error state, otherwise null.
  Object? get error =>
      _state is AsyncError<T> ? (_state as AsyncError<T>).error : null;

  /// Returns the stack trace if in error state, otherwise null.
  StackTrace? get stackTrace =>
      _state is AsyncError<T> ? (_state as AsyncError<T>).stackTrace : null;

  /// Whether the notifier is currently in the initial state.
  bool get isInitial => _state is AsyncInitial<T>;

  /// Whether an async operation is currently in progress.
  bool get isLoading => _state is AsyncLoading<T>;

  /// Whether the last operation completed with an error.
  bool get hasError => _state is AsyncError<T>;

  /// Whether data is available.
  bool get hasData => _state is AsyncData<T>;

  /// Executes an async function and automatically manages state transitions.
  ///
  /// 1. Sets state to [AsyncLoading]
  /// 2. Awaits the async function
  /// 3. Sets state to [AsyncData] on success or [AsyncError] on failure
  ///
  /// ### Example
  /// ```dart
  /// final users = AsyncReactiveNotifier<List<User>>();
  ///
  /// // Simple execution
  /// await users.execute(() => api.fetchUsers());
  ///
  /// // With error handling
  /// await users.execute(() async {
  ///   final response = await api.fetchUsers();
  ///   if (response.isEmpty) throw Exception('No users found');
  ///   return response;
  /// });
  /// ```
  Future<void> execute(Future<T> Function() asyncFunction) async {
    _state = AsyncLoading<T>();
    notifyListeners();

    try {
      final result = await asyncFunction();
      _state = AsyncData<T>(result);
    } catch (error, stackTrace) {
      _state = AsyncError<T>(error, stackTrace: stackTrace);
    }

    notifyListeners();
  }

  /// Sets the state to loading.
  ///
  /// Use this when you want to manually control the loading state.
  void setLoading() {
    _state = AsyncLoading<T>();
    notifyListeners();
  }

  /// Sets the state to data with the given value.
  ///
  /// Use this when you want to manually set data without executing an async operation.
  ///
  /// ### Example
  /// ```dart
  /// final counter = AsyncReactiveNotifier<int>();
  /// counter.setData(42);
  /// ```
  void setData(T data) {
    _state = AsyncData<T>(data);
    notifyListeners();
  }

  /// Sets the state to error.
  ///
  /// Use this when you want to manually set an error state.
  ///
  /// ### Example
  /// ```dart
  /// final users = AsyncReactiveNotifier<List<User>>();
  /// users.setError(Exception('Network error'));
  /// ```
  void setError(Object error, {StackTrace? stackTrace}) {
    _state = AsyncError<T>(error, stackTrace: stackTrace);
    notifyListeners();
  }

  /// Resets the state to initial.
  ///
  /// Use this to clear data and start fresh.
  void reset() {
    _state = AsyncInitial<T>();
    notifyListeners();
  }

  /// Updates the data if currently in data state.
  ///
  /// Does nothing if not in data state.
  ///
  /// ### Example
  /// ```dart
  /// final users = AsyncReactiveNotifier<List<User>>();
  /// await users.execute(() => api.fetchUsers());
  ///
  /// // Add a new user to the list
  /// users.updateData((users) => [...users, newUser]);
  /// ```
  void updateData(T Function(T current) updater) {
    if (_state is AsyncData<T>) {
      final currentData = (_state as AsyncData<T>).data;
      _state = AsyncData<T>(updater(currentData));
      notifyListeners();
    }
  }

  /// Forces a notification to all listeners.
  void refresh() {
    notifyListeners();
  }

  @override
  String toString() => '${describeIdentity(this)}($_state)';
}
