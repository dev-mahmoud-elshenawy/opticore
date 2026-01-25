part of '../import/base_import.dart';

/// A widget that provides a [ReactiveNotifier] or [ChangeNotifier] to its descendants.
///
/// Uses [InheritedNotifier] under the hood for efficient rebuilds.
/// Descendants can access the notifier using [ReactiveProvider.of] or
/// the [BuildContext] extension [context.reactive].
///
/// ### Basic Usage
/// ```dart
/// // Provide at the top of your widget tree
/// ReactiveProvider<ReactiveNotifier<int>>(
///   notifier: counter,
///   child: const MyApp(),
/// )
///
/// // Access anywhere in the subtree
/// final counter = ReactiveProvider.of<ReactiveNotifier<int>>(context);
/// // or
/// final counter = context.reactive<ReactiveNotifier<int>>();
/// ```
///
/// ### Disable Auto Dispose
/// By default, notifiers are automatically disposed when the provider is removed.
/// Set `autoDispose: false` if you manage the notifier lifecycle elsewhere:
///
/// ```dart
/// ReactiveProvider<ReactiveNotifier<int>>(
///   notifier: counter,
///   autoDispose: false,  // Don't dispose, managed elsewhere
///   child: const MyApp(),
/// )
/// ```
///
/// ### Multiple Providers
/// ```dart
/// ReactiveProvider<ReactiveNotifier<User>>(
///   notifier: userNotifier,
///   child: ReactiveProvider<ReactiveNotifier<Settings>>(
///     notifier: settingsNotifier,
///     child: const MyApp(),
///   ),
/// )
/// ```
///
/// See also:
/// - [ReactiveNotifier] for the reactive value holder
/// - [AsyncReactiveNotifier] for async operations
/// - [Reactive] for building UI that responds to changes
class ReactiveProvider<T extends ChangeNotifier> extends StatefulWidget {
  /// Creates a [ReactiveProvider] that provides [notifier] to descendants.
  const ReactiveProvider({
    super.key,
    required this.notifier,
    required this.child,
    this.autoDispose = true,
  });

  /// The notifier to provide to descendants.
  final T notifier;

  /// The widget below this provider in the tree.
  final Widget child;

  /// Whether to automatically dispose the notifier when this provider
  /// is removed from the tree.
  ///
  /// Defaults to `true`. Set to `false` if you manage the notifier
  /// lifecycle elsewhere.
  final bool autoDispose;

  /// Obtains the nearest [ReactiveProvider] of the given type [T] and returns
  /// its notifier.
  ///
  /// Throws a [FlutterError] if no provider is found.
  ///
  /// ### Example
  /// ```dart
  /// final counter = ReactiveProvider.of<ReactiveNotifier<int>>(context);
  /// print(counter.value);
  /// ```
  static T of<T extends ChangeNotifier>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<_ReactiveInherited<T>>();
    if (provider == null) {
      throw FlutterError(
        'ReactiveProvider.of<$T>() called with a context that does not contain a ReactiveProvider<$T>.\n'
        'No ancestor could be found starting from the context that was passed to ReactiveProvider.of<$T>().\n'
        'This can happen if the context you used comes from a widget above the ReactiveProvider.\n'
        'The context used was: $context',
      );
    }
    return provider.notifier!;
  }

  /// Obtains the nearest [ReactiveProvider] of the given type [T] and returns
  /// its notifier, or null if not found.
  ///
  /// Unlike [of], this method does not throw if no provider is found.
  ///
  /// ### Example
  /// ```dart
  /// final counter = ReactiveProvider.maybeOf<ReactiveNotifier<int>>(context);
  /// if (counter != null) {
  ///   print(counter.value);
  /// }
  /// ```
  static T? maybeOf<T extends ChangeNotifier>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<_ReactiveInherited<T>>();
    return provider?.notifier;
  }

  @override
  State<ReactiveProvider<T>> createState() => _ReactiveProviderState<T>();
}

class _ReactiveProviderState<T extends ChangeNotifier>
    extends State<ReactiveProvider<T>> {
  @override
  void dispose() {
    if (widget.autoDispose) {
      widget.notifier.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ReactiveInherited<T>(
      notifier: widget.notifier,
      child: widget.child,
    );
  }
}

/// Internal inherited widget used by [ReactiveProvider].
class _ReactiveInherited<T extends ChangeNotifier>
    extends InheritedNotifier<T> {
  const _ReactiveInherited({
    required T notifier,
    required super.child,
  }) : super(notifier: notifier);
}

/// Extension on [BuildContext] for convenient access to [ReactiveProvider].
extension ReactiveProviderExtension on BuildContext {
  /// Obtains the nearest [ReactiveProvider] of type [T] and returns its notifier.
  ///
  /// Throws if no provider is found.
  ///
  /// ### Example
  /// ```dart
  /// final counter = context.reactive<ReactiveNotifier<int>>();
  /// print(counter.value);
  /// ```
  T reactive<T extends ChangeNotifier>() => ReactiveProvider.of<T>(this);

  /// Obtains the nearest [ReactiveProvider] of type [T] and returns its notifier,
  /// or null if not found.
  ///
  /// ### Example
  /// ```dart
  /// final counter = context.maybeReactive<ReactiveNotifier<int>>();
  /// if (counter != null) {
  ///   print(counter.value);
  /// }
  /// ```
  T? maybeReactive<T extends ChangeNotifier>() =>
      ReactiveProvider.maybeOf<T>(this);
}
