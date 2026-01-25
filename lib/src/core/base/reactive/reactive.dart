part of '../import/base_import.dart';

/// Enum to identify the type of Reactive widget constructor used.
enum _ReactiveType { single, multi, select, async }

/// A widget that rebuilds when a [ReactiveNotifier] changes.
///
/// Similar to Flutter's [ValueListenableBuilder] but with additional features:
/// - Optional conditional rebuilds via [buildWhen]
/// - Side effects via [listener]
/// - Multiple notifier support via [Reactive.multi]
/// - Property selection via [Reactive.select]
/// - Async state handling via [Reactive.async]
/// - Auto-dispose by default via [autoDispose]
///
/// ## Examples
///
/// ### Basic Usage
/// ```dart
/// final counter = ReactiveNotifier<int>(0);
///
/// Reactive<int>(
///   notifier: counter,
///   builder: (context, value, child) => Text('Count: $value'),
/// )
///
/// // Update triggers rebuild
/// counter.value++;
/// ```
///
/// ### Conditional Rebuild (buildWhen)
/// Only rebuild when specific conditions are met:
///
/// ```dart
/// Reactive<int>(
///   notifier: counter,
///   buildWhen: (previous, current) => current > previous,  // Only on increase
///   builder: (context, value, child) => Text('$value'),
/// )
/// ```
///
/// ### Side Effects (listener)
/// Execute actions without rebuilding (e.g., show snackbar, navigate):
///
/// ```dart
/// Reactive<int>(
///   notifier: counter,
///   listener: (context, value) {
///     if (value >= 10) {
///       ScaffoldMessenger.of(context).showSnackBar(
///         SnackBar(content: Text('Reached $value!')),
///       );
///     }
///   },
///   builder: (context, value, child) => Text('$value'),
/// )
/// ```
///
/// ### Conditional Listening (listenWhen)
/// Control when the listener is called:
///
/// ```dart
/// Reactive<int>(
///   notifier: counter,
///   listenWhen: (previous, current) => current % 5 == 0,  // Every 5th value
///   listener: (context, value) {
///     print('Milestone reached: $value');
///   },
///   builder: (context, value, child) => Text('$value'),
/// )
/// ```
///
/// ### Child Optimization (Performance)
///
/// **Problem:** When the notifier changes, the entire `builder` function runs again,
/// recreating all widgets inside it - even widgets that don't depend on the value.
///
/// **Solution:** Pass static (unchanging) widgets via the [child] parameter.
/// These widgets are built once and reused on every rebuild, improving performance.
///
/// ❌ **Without child optimization** (rebuilds everything):
/// ```dart
/// Reactive<int>(
///   notifier: counter,
///   builder: (context, value, child) => Card(
///     child: Column(
///       children: [
///         const Icon(Icons.star, size: 50),      // Rebuilt every time!
///         const Text('Your Score'),              // Rebuilt every time!
///         const SizedBox(height: 10),            // Rebuilt every time!
///         Text('$value', style: TextStyle(fontSize: 24)),  // Needs rebuild
///       ],
///     ),
///   ),
/// )
/// ```
///
/// ✅ **With child optimization** (only rebuilds what's needed):
/// ```dart
/// Reactive<int>(
///   notifier: counter,
///   builder: (context, value, child) => Card(
///     child: Column(
///       children: [
///         child!,  // Reused, never rebuilt!
///         Text('$value', style: TextStyle(fontSize: 24)),  // Only this rebuilds
///       ],
///     ),
///   ),
///   child: const Column(
///     children: [
///       Icon(Icons.star, size: 50),
///       Text('Your Score'),
///       SizedBox(height: 10),
///     ],
///   ),
/// )
/// ```
///
/// **When to use [child]:**
/// - Icons, images, decorations that don't change
/// - Static text labels
/// - Complex widgets that are expensive to build
/// - Any widget that doesn't depend on the notifier's value
///
/// ### Disable Auto Dispose
/// By default, notifiers are automatically disposed when the widget is removed.
/// Set `autoDispose: false` if you manage the notifier lifecycle elsewhere:
///
/// ```dart
/// Reactive<int>(
///   notifier: counter,
///   autoDispose: false,  // Don't dispose, managed elsewhere
///   builder: (context, value, child) => Text('$value'),
/// )
/// ```
///
/// See also:
/// - [Reactive.multi] for listening to multiple notifiers
/// - [Reactive.select] for rebuilding only when specific properties change
/// - [Reactive.async] for async operations with loading/error states
/// - [ReactiveNotifier] for the reactive value holder
/// - [AsyncReactiveNotifier] for async operations
/// - [ReactiveProvider] for sharing notifiers across the widget tree
class Reactive<T> extends StatefulWidget {
  /// Creates a [Reactive] widget that rebuilds when [notifier] changes.
  ///
  /// The [builder] is called with the current value whenever the notifier
  /// changes (subject to [buildWhen] if provided).
  const Reactive({
    super.key,
    required ReactiveNotifier<T> notifier,
    required Widget Function(BuildContext context, T value, Widget? child)
        builder,
    bool Function(T previous, T current)? buildWhen,
    void Function(BuildContext context, T value)? listener,
    bool Function(T previous, T current)? listenWhen,
    Widget? child,
    bool autoDispose = true,
  })  : _notifier = notifier,
        _asyncNotifier = null,
        _notifiers = null,
        _builder = builder,
        _multiBuilder = null,
        _selector = null,
        _selectedBuilder = null,
        _asyncDataBuilder = null,
        _asyncLoadingBuilder = null,
        _asyncErrorBuilder = null,
        _asyncInitialBuilder = null,
        _buildWhen = buildWhen,
        _listener = listener,
        _listenWhen = listenWhen,
        _child = child,
        _autoDispose = autoDispose,
        _type = _ReactiveType.single;

  /// Creates a [Reactive] widget that rebuilds when any of [notifiers] change.
  ///
  /// Use this when your UI depends on multiple reactive values.
  ///
  /// ### Example
  /// ```dart
  /// final firstName = ReactiveNotifier<String>('John');
  /// final lastName = ReactiveNotifier<String>('Doe');
  ///
  /// Reactive.multi(
  ///   notifiers: [firstName, lastName],
  ///   builder: (context, child) => Text('${firstName.value} ${lastName.value}'),
  /// )
  /// ```
  const Reactive.multi({
    super.key,
    required List<ReactiveNotifier<dynamic>> notifiers,
    required Widget Function(BuildContext context, Widget? child) builder,
    Widget? child,
    bool autoDispose = true,
  })  : _notifier = null,
        _asyncNotifier = null,
        _notifiers = notifiers,
        _builder = null,
        _multiBuilder = builder,
        _selector = null,
        _selectedBuilder = null,
        _asyncDataBuilder = null,
        _asyncLoadingBuilder = null,
        _asyncErrorBuilder = null,
        _asyncInitialBuilder = null,
        _buildWhen = null,
        _listener = null,
        _listenWhen = null,
        _child = child,
        _autoDispose = autoDispose,
        _type = _ReactiveType.multi;

  /// Creates a [Reactive] widget that only rebuilds when a selected property changes.
  ///
  /// Use this for optimization when you only care about a specific property
  /// of a complex object.
  ///
  /// ### Example
  /// ```dart
  /// final user = ReactiveNotifier<User>(User(name: 'John', age: 30));
  ///
  /// // Only rebuilds when name changes, not when age changes
  /// Reactive<User>.select<String>(
  ///   notifier: user,
  ///   selector: (user) => user.name,
  ///   builder: (context, name, child) => Text(name),
  /// )
  /// ```
  const Reactive.select({
    super.key,
    required ReactiveNotifier<T> notifier,
    required Object? Function(T value) selector,
    required Widget Function(
            BuildContext context, Object? selected, Widget? child)
        builder,
    Widget? child,
    bool autoDispose = true,
  })  : _notifier = notifier,
        _asyncNotifier = null,
        _notifiers = null,
        _builder = null,
        _multiBuilder = null,
        _selector = selector,
        _selectedBuilder = builder,
        _asyncDataBuilder = null,
        _asyncLoadingBuilder = null,
        _asyncErrorBuilder = null,
        _asyncInitialBuilder = null,
        _buildWhen = null,
        _listener = null,
        _listenWhen = null,
        _child = child,
        _autoDispose = autoDispose,
        _type = _ReactiveType.select;

  /// Creates a [Reactive] widget for [AsyncReactiveNotifier] with loading/error/data states.
  ///
  /// Provides separate builders for each async state.
  ///
  /// ### Example
  /// ```dart
  /// final users = AsyncReactiveNotifier<List<User>>();
  ///
  /// Reactive<List<User>>.async(
  ///   notifier: users,
  ///   loading: (context) => const CircularProgressIndicator(),
  ///   error: (context, error, stackTrace) => Text('Error: $error'),
  ///   data: (context, users) => UserList(users: users),
  /// )
  /// ```
  const Reactive.async({
    super.key,
    required AsyncReactiveNotifier<T> notifier,
    required Widget Function(BuildContext context, T data) data,
    Widget Function(BuildContext context)? loading,
    Widget Function(BuildContext context, Object error, StackTrace? stackTrace)?
        error,
    Widget Function(BuildContext context)? initial,
    bool autoDispose = true,
  })  : _notifier = null,
        _asyncNotifier = notifier,
        _notifiers = null,
        _builder = null,
        _multiBuilder = null,
        _selector = null,
        _selectedBuilder = null,
        _asyncDataBuilder = data,
        _asyncLoadingBuilder = loading,
        _asyncErrorBuilder = error,
        _asyncInitialBuilder = initial,
        _buildWhen = null,
        _listener = null,
        _listenWhen = null,
        _child = null,
        _autoDispose = autoDispose,
        _type = _ReactiveType.async;

  final ReactiveNotifier<T>? _notifier;
  final AsyncReactiveNotifier<T>? _asyncNotifier;
  final List<ReactiveNotifier<dynamic>>? _notifiers;
  final Widget Function(BuildContext context, T value, Widget? child)? _builder;
  final Widget Function(BuildContext context, Widget? child)? _multiBuilder;
  final Object? Function(T value)? _selector;
  final Widget Function(BuildContext context, Object? selected, Widget? child)?
      _selectedBuilder;
  final Widget Function(BuildContext context, T data)? _asyncDataBuilder;
  final Widget Function(BuildContext context)? _asyncLoadingBuilder;
  final Widget Function(
          BuildContext context, Object error, StackTrace? stackTrace)?
      _asyncErrorBuilder;
  final Widget Function(BuildContext context)? _asyncInitialBuilder;
  final bool Function(T previous, T current)? _buildWhen;
  final void Function(BuildContext context, T value)? _listener;
  final bool Function(T previous, T current)? _listenWhen;
  final Widget? _child;
  final bool _autoDispose;
  final _ReactiveType _type;

  @override
  State<Reactive<T>> createState() => _ReactiveState<T>();
}

class _ReactiveState<T> extends State<Reactive<T>> {
  T? _previousValue;
  Object? _previousSelected;

  @override
  void initState() {
    super.initState();
    _subscribe();
    _initializePreviousValue();
  }

  void _initializePreviousValue() {
    switch (widget._type) {
      case _ReactiveType.single:
        _previousValue = widget._notifier!.value;
        break;
      case _ReactiveType.select:
        _previousValue = widget._notifier!.value;
        _previousSelected = widget._selector!(widget._notifier!.value);
        break;
      case _ReactiveType.multi:
      case _ReactiveType.async:
        break;
    }
  }

  void _subscribe() {
    switch (widget._type) {
      case _ReactiveType.single:
      case _ReactiveType.select:
        widget._notifier!.addListener(_onNotifierChanged);
        break;
      case _ReactiveType.multi:
        for (final notifier in widget._notifiers!) {
          notifier.addListener(_onMultiNotifierChanged);
        }
        break;
      case _ReactiveType.async:
        widget._asyncNotifier!.addListener(_onAsyncNotifierChanged);
        break;
    }
  }

  void _unsubscribe() {
    switch (widget._type) {
      case _ReactiveType.single:
      case _ReactiveType.select:
        widget._notifier?.removeListener(_onNotifierChanged);
        break;
      case _ReactiveType.multi:
        for (final notifier in widget._notifiers ?? []) {
          notifier.removeListener(_onMultiNotifierChanged);
        }
        break;
      case _ReactiveType.async:
        widget._asyncNotifier?.removeListener(_onAsyncNotifierChanged);
        break;
    }
  }

  void _onNotifierChanged() {
    final currentValue = widget._notifier!.value;

    // Handle listener
    if (widget._listener != null) {
      final shouldListen =
          widget._listenWhen?.call(_previousValue as T, currentValue) ?? true;
      if (shouldListen) {
        widget._listener!(context, currentValue);
      }
    }

    // Handle selector for select type
    if (widget._type == _ReactiveType.select) {
      final currentSelected = widget._selector!(currentValue);
      if (currentSelected != _previousSelected) {
        _previousSelected = currentSelected;
        _previousValue = currentValue;
        setState(() {});
      }
      return;
    }

    // Handle buildWhen for single type
    final shouldBuild =
        widget._buildWhen?.call(_previousValue as T, currentValue) ?? true;
    _previousValue = currentValue;

    if (shouldBuild) {
      setState(() {});
    }
  }

  void _onMultiNotifierChanged() {
    setState(() {});
  }

  void _onAsyncNotifierChanged() {
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant Reactive<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if notifiers changed
    bool notifiersChanged = false;

    switch (widget._type) {
      case _ReactiveType.single:
      case _ReactiveType.select:
        notifiersChanged = oldWidget._notifier != widget._notifier;
        break;
      case _ReactiveType.multi:
        notifiersChanged =
            !_listEquals(oldWidget._notifiers, widget._notifiers);
        break;
      case _ReactiveType.async:
        notifiersChanged = oldWidget._asyncNotifier != widget._asyncNotifier;
        break;
    }

    if (notifiersChanged) {
      // Unsubscribe from old notifiers
      switch (oldWidget._type) {
        case _ReactiveType.single:
        case _ReactiveType.select:
          oldWidget._notifier?.removeListener(_onNotifierChanged);
          break;
        case _ReactiveType.multi:
          for (final notifier in oldWidget._notifiers ?? []) {
            notifier.removeListener(_onMultiNotifierChanged);
          }
          break;
        case _ReactiveType.async:
          oldWidget._asyncNotifier?.removeListener(_onAsyncNotifierChanged);
          break;
      }

      // Subscribe to new notifiers
      _subscribe();
      _initializePreviousValue();
    }
  }

  bool _listEquals<E>(List<E>? a, List<E>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  void dispose() {
    _unsubscribe();

    // Auto dispose notifiers if enabled
    if (widget._autoDispose) {
      switch (widget._type) {
        case _ReactiveType.single:
        case _ReactiveType.select:
          widget._notifier?.dispose();
          break;
        case _ReactiveType.multi:
          for (final notifier in widget._notifiers ?? []) {
            notifier.dispose();
          }
          break;
        case _ReactiveType.async:
          widget._asyncNotifier?.dispose();
          break;
      }
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget._type) {
      case _ReactiveType.single:
        return widget._builder!(
            context, widget._notifier!.value, widget._child);

      case _ReactiveType.multi:
        return widget._multiBuilder!(context, widget._child);

      case _ReactiveType.select:
        final selected = widget._selector!(widget._notifier!.value);
        return widget._selectedBuilder!(context, selected, widget._child);

      case _ReactiveType.async:
        return _buildAsync();
    }
  }

  Widget _buildAsync() {
    final state = widget._asyncNotifier!.state;

    if (state is AsyncLoading<T>) {
      return widget._asyncLoadingBuilder?.call(context) ??
          const Center(child: CircularProgressIndicator());
    }

    if (state is AsyncError<T>) {
      return widget._asyncErrorBuilder?.call(
            context,
            state.error,
            state.stackTrace,
          ) ??
          Center(child: Text('Error: ${state.error}'));
    }

    if (state is AsyncData<T>) {
      return widget._asyncDataBuilder!(context, state.data);
    }

    // AsyncInitial
    return widget._asyncInitialBuilder?.call(context) ??
        const SizedBox.shrink();
  }
}
