part of '../import/base_import.dart';

/// A widget that rebuilds only when a selected property of a [ReactiveNotifier] changes.
///
/// Unlike [Reactive.select] which uses `Object?` for the selected value,
/// [ReactiveSelector] preserves full type safety with two generic parameters:
/// - [T]: The type of the notifier's value
/// - [S]: The type of the selected property
///
/// ## Example
/// ```dart
/// final user = ReactiveNotifier<User>(User(name: 'John', age: 30));
///
/// // Only rebuilds when name changes, with full type safety
/// ReactiveSelector<User, String>(
///   notifier: user,
///   selector: (user) => user.name,
///   builder: (context, name, child) => Text(name), // name is String, not Object?
/// )
/// ```
///
/// ## With buildWhen
/// ```dart
/// ReactiveSelector<User, int>(
///   notifier: user,
///   selector: (user) => user.age,
///   buildWhen: (prevAge, currAge) => currAge > prevAge, // Both are int
///   builder: (context, age, child) => Text('Age: $age'),
/// )
/// ```
///
/// See also:
/// - [Reactive] for single/multi/async notifier support
/// - [ReactiveBuilder] for lightweight [ValueListenable] rebuilds
/// - [ReactiveNotifier] for the reactive value holder
class ReactiveSelector<T, S> extends StatefulWidget {
  /// The [ReactiveNotifier] to listen to.
  final ReactiveNotifier<T> notifier;

  /// Extracts the property of type [S] from the notifier's value of type [T].
  final S Function(T value) selector;

  /// Called with the selected value whenever it changes (subject to [buildWhen]).
  final Widget Function(BuildContext context, S selected, Widget? child)
      builder;

  /// Optional condition to control when the [builder] should be called.
  ///
  /// If `null`, the builder is called whenever the selected value changes.
  /// If provided, the builder is only called when this returns `true`.
  final bool Function(S previous, S current)? buildWhen;

  /// Optional static child widget that does not depend on the selected value.
  final Widget? child;

  /// Whether to automatically dispose the [notifier] when this widget is removed.
  ///
  /// Defaults to `true`.
  final bool autoDispose;

  const ReactiveSelector({
    super.key,
    required this.notifier,
    required this.selector,
    required this.builder,
    this.buildWhen,
    this.child,
    this.autoDispose = true,
  });

  @override
  State<ReactiveSelector<T, S>> createState() =>
      _ReactiveSelectorState<T, S>();
}

class _ReactiveSelectorState<T, S> extends State<ReactiveSelector<T, S>> {
  late S _previousSelected;

  @override
  void initState() {
    super.initState();
    _previousSelected = widget.selector(widget.notifier.value);
    widget.notifier.addListener(_onChanged);
  }

  @override
  void didUpdateWidget(covariant ReactiveSelector<T, S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.notifier != widget.notifier) {
      oldWidget.notifier.removeListener(_onChanged);
      _previousSelected = widget.selector(widget.notifier.value);
      widget.notifier.addListener(_onChanged);
    }
  }

  void _onChanged() {
    final currentSelected = widget.selector(widget.notifier.value);
    if (currentSelected != _previousSelected) {
      final shouldBuild =
          widget.buildWhen?.call(_previousSelected, currentSelected) ?? true;
      _previousSelected = currentSelected;
      if (shouldBuild) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_onChanged);
    if (widget.autoDispose) {
      widget.notifier.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _previousSelected, widget.child);
  }
}
