part of '../import/base_import.dart';

/// A lightweight builder widget that rebuilds when a [ValueListenable] changes.
///
/// Designed for rebuilding specific parts of a screen without triggering
/// a full tree rebuild via BLoC [RenderState]. Works with any [ValueListenable],
/// including [ValueNotifier], [ReactiveNotifier], or custom implementations.
///
/// Similar to [BlocBuilder] but for [ValueListenable] — minimal code, focused on building.
///
/// ## Key Differences from [Reactive]
///
/// | Feature | ReactiveBuilder | Reactive |
/// |---------|----------------|----------|
/// | Input type | `ValueListenable<T>` | `ReactiveNotifier<T>` |
/// | Auto-dispose | `false` by default | `true` by default |
/// | Listener/side effects | No | Yes |
/// | Multi/Select/Async | No | Yes |
/// | Use case | Partial UI rebuild in screens | Full reactive state management |
///
/// ## Examples
///
/// ### Basic Usage
/// ```dart
/// final counter = ValueNotifier<int>(0);
///
/// ReactiveBuilder<int>(
///   valueListenable: counter,
///   builder: (context, value, child) => Text('Count: $value'),
/// )
/// ```
///
/// ### With ReactiveNotifier
/// ```dart
/// final toggle = ReactiveNotifier<bool>(false);
///
/// ReactiveBuilder<bool>(
///   valueListenable: toggle,
///   builder: (context, isOn, child) => Switch(
///     value: isOn,
///     onChanged: (v) => toggle.value = v,
///   ),
/// )
/// ```
///
/// ### Conditional Rebuild (buildWhen)
/// Only rebuild when specific conditions are met:
///
/// ```dart
/// ReactiveBuilder<int>(
///   valueListenable: counter,
///   buildWhen: (previous, current) => current % 2 == 0, // Only on even numbers
///   builder: (context, value, child) => Text('Even: $value'),
/// )
/// ```
///
/// ### Child Optimization
/// Pass static widgets via [child] to avoid unnecessary rebuilds:
///
/// ```dart
/// ReactiveBuilder<int>(
///   valueListenable: counter,
///   builder: (context, value, child) => Row(
///     children: [
///       child!,                    // Static icon, never rebuilds
///       Text('$value'),            // Only this rebuilds
///     ],
///   ),
///   child: const Icon(Icons.star), // Built once
/// )
/// ```
///
/// ### Inside BaseScreen
/// ```dart
/// class MyScreenState extends BaseScreen<MyBloc, MyScreen, MyData> {
///   final selectedTab = ValueNotifier<int>(0);
///
///   @override
///   Widget buildWidget(BuildContext context, RenderDataState<MyData> state) {
///     return Column(
///       children: [
///         // Full screen data from BLoC
///         Text(state.data.title),
///
///         // Only this part rebuilds on tab change
///         ReactiveBuilder<int>(
///           valueListenable: selectedTab,
///           builder: (context, index, child) => TabContent(index: index),
///         ),
///       ],
///     );
///   }
///
///   @override
///   void disposeData() {
///     selectedTab.dispose();
///   }
/// }
/// ```
///
/// See also:
/// - [Reactive] for full reactive state management with listeners, multi, select, async
/// - [StateBuilder] for selective BLoC component updates
/// - [ReactiveNotifier] for OptiCore's reactive value holder
/// - [ValueListenableBuilder] Flutter's built-in equivalent (without [buildWhen])
class ReactiveBuilder<T> extends StatefulWidget {
  /// The [ValueListenable] to listen to.
  ///
  /// Accepts [ValueNotifier], [ReactiveNotifier], or any [ValueListenable] implementation.
  final ValueListenable<T> valueListenable;

  /// Called every time the [valueListenable] changes (subject to [buildWhen]).
  ///
  /// The [child] parameter is the static widget passed to the constructor,
  /// useful for optimization.
  final Widget Function(BuildContext context, T value, Widget? child) builder;

  /// Optional condition to control when the [builder] should be called.
  ///
  /// If `null`, the builder is called on every value change.
  /// If provided, the builder is only called when this returns `true`.
  final bool Function(T previous, T current)? buildWhen;

  /// Optional static child widget that does not depend on the [valueListenable].
  ///
  /// This widget is built once and passed to the [builder] function on every rebuild,
  /// improving performance by avoiding unnecessary widget recreation.
  final Widget? child;

  /// Whether to automatically dispose the [valueListenable] when this widget is removed.
  ///
  /// Defaults to `false` since the parent typically manages the notifier lifecycle.
  /// Set to `true` for fire-and-forget notifiers created inline.
  final bool autoDispose;

  const ReactiveBuilder({
    super.key,
    required this.valueListenable,
    required this.builder,
    this.buildWhen,
    this.child,
    this.autoDispose = false,
  });

  @override
  State<ReactiveBuilder<T>> createState() => _ReactiveBuilderState<T>();
}

class _ReactiveBuilderState<T> extends State<ReactiveBuilder<T>> {
  late T _previousValue;

  @override
  void initState() {
    super.initState();
    _previousValue = widget.valueListenable.value;
    widget.valueListenable.addListener(_onChanged);
  }

  @override
  void didUpdateWidget(covariant ReactiveBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valueListenable != widget.valueListenable) {
      oldWidget.valueListenable.removeListener(_onChanged);
      _previousValue = widget.valueListenable.value;
      widget.valueListenable.addListener(_onChanged);
    }
  }

  void _onChanged() {
    final current = widget.valueListenable.value;
    final shouldBuild =
        widget.buildWhen?.call(_previousValue, current) ?? true;
    _previousValue = current;
    if (shouldBuild) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    widget.valueListenable.removeListener(_onChanged);
    if (widget.autoDispose && widget.valueListenable is ChangeNotifier) {
      (widget.valueListenable as ChangeNotifier).dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      widget.valueListenable.value,
      widget.child,
    );
  }
}
