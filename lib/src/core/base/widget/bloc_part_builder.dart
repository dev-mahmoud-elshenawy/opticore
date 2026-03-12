part of '../import/base_import.dart';

/// A lightweight widget that rebuilds a specific part of the UI when a BLoC emits
/// a matching state, without triggering a full screen rebuild.
///
/// Unlike [ContentBuilder] which rebuilds the entire screen on [RenderState],
/// `BlocPartBuilder` selectively rebuilds only its subtree when the BLoC emits
/// a state of type [S].
///
/// Works with any [BaseState] subclass — not limited to [ComponentState].
///
/// ## Comparison
///
/// | Widget | Listens to | Use case |
/// |--------|-----------|----------|
/// | [ContentBuilder] | All `RenderState` | Full screen rendering |
/// | [StateBuilder] | `ComponentState` only | Component-level updates with `ComponentDataState` |
/// | [BlocPartBuilder] | Any `BaseState` subclass | Flexible partial rebuilds with any state type |
/// | [ReactiveBuilder] | `ValueListenable` | Local state without BLoC |
///
/// ## Examples
///
/// ### Basic Usage — Listen for a specific state type
/// ```dart
/// BlocPartBuilder<MyBloc, ProfileLoadedState>(
///   builder: (context, state) => Text(state.profile.name),
/// )
/// ```
///
/// ### With Data Extraction (selector)
/// Extract specific data from state for efficient comparison:
///
/// ```dart
/// BlocPartBuilder<MyBloc, ProfileLoadedState>.select(
///   selector: (state) => state.profile.name,
///   builder: (context, name) => Text(name),
/// )
/// ```
///
/// ### With buildWhen
/// ```dart
/// BlocPartBuilder<MyBloc, CartUpdatedState>(
///   buildWhen: (previous, current) => previous.itemCount != current.itemCount,
///   builder: (context, state) => Badge(label: Text('${state.itemCount}')),
/// )
/// ```
///
/// ### With BLoC instance (no BlocProvider needed)
/// ```dart
/// BlocPartBuilder<MyBloc, CartUpdatedState>(
///   bloc: myBlocInstance,
///   builder: (context, state) => Text('${state.total}'),
/// )
/// ```
///
/// ### With Initial Widget
/// ```dart
/// BlocPartBuilder<MyBloc, ProfileLoadedState>(
///   initialWidget: const CircularProgressIndicator(),
///   builder: (context, state) => Text(state.profile.name),
/// )
/// ```
///
/// ### Inside BaseScreen
/// ```dart
/// class OrderScreenState extends BaseScreen<OrderBloc, OrderScreen, OrderData> {
///   @override
///   Widget buildWidget(BuildContext context, RenderDataState<OrderData> state) {
///     return Column(
///       children: [
///         // Full screen data from RenderDataState
///         Text(state.data.orderTitle),
///
///         // Only this badge rebuilds when CartItemCountState is emitted
///         BlocPartBuilder<OrderBloc, CartItemCountState>(
///           builder: (context, state) => Badge(label: Text('${state.count}')),
///         ),
///
///         // Only rebuilds when the price string changes
///         BlocPartBuilder<OrderBloc, PriceUpdatedState>.select(
///           selector: (state) => state.formattedPrice,
///           builder: (context, price) => Text(price),
///         ),
///       ],
///     );
///   }
/// }
/// ```
///
/// See also:
/// - [StateBuilder] for component-level updates using [ComponentDataState]
/// - [ReactiveBuilder] for local state without BLoC
/// - [ContentBuilder] for full screen rendering
class BlocPartBuilder<B extends BlocBase<BaseState>, S extends BaseState>
    extends StatelessWidget {
  final Widget Function(BuildContext context, S state)? _stateBuilder;
  final Widget Function(BuildContext context, dynamic selected)? _selectBuilder;
  final dynamic Function(S state)? _selector;
  final bool Function(S previous, S current)? _buildWhen;
  final Widget? _initialWidget;
  final Widget? _child;
  final B? _bloc;
  final bool _isSelect;

  /// Creates a [BlocPartBuilder] that rebuilds when the BLoC emits a state of type [S].
  ///
  /// The [buildWhen] callback receives the previous and current state of type [S]
  /// (only called when both are of type [S]). If it returns `false`, the builder
  /// is not called.
  const BlocPartBuilder({
    super.key,
    required Widget Function(BuildContext context, S state) builder,
    bool Function(S previous, S current)? buildWhen,
    Widget? initialWidget,
    Widget? child,
    B? bloc,
  })  : _stateBuilder = builder,
        _selectBuilder = null,
        _selector = null,
        _buildWhen = buildWhen,
        _initialWidget = initialWidget,
        _child = child,
        _bloc = bloc,
        _isSelect = false;

  /// Creates a [BlocPartBuilder] that extracts a value from state [S] and only
  /// rebuilds when the extracted value changes.
  ///
  /// Use this for maximum efficiency when you only need one property from a state.
  const BlocPartBuilder.select({
    super.key,
    required dynamic Function(S state) selector,
    required Widget Function(BuildContext context, dynamic selected) builder,
    Widget? initialWidget,
    Widget? child,
    B? bloc,
  })  : _stateBuilder = null,
        _selectBuilder = builder,
        _selector = selector,
        _buildWhen = null,
        _initialWidget = initialWidget,
        _child = child,
        _bloc = bloc,
        _isSelect = true;

  @override
  Widget build(BuildContext context) {
    if (_isSelect) {
      return _buildSelect(context);
    }
    return _buildState(context);
  }

  Widget _buildState(BuildContext context) {
    return BlocBuilder<B, BaseState>(
      bloc: _bloc,
      buildWhen: (previous, current) {
        // Only rebuild when the current state is of type S
        if (current is! S) return false;
        // If buildWhen is provided and previous is also S, delegate to it
        if (_buildWhen != null && previous is S) {
          return _buildWhen(previous, current);
        }
        // Rebuild when we first get a state of type S, or when it changes
        return true;
      },
      builder: (context, state) {
        if (state is S) {
          return _stateBuilder!(context, state);
        }
        return _initialWidget ?? _child ?? const SizedBox.shrink();
      },
    );
  }

  Widget _buildSelect(BuildContext context) {
    return BlocSelector<B, BaseState, _BlocPartSelectHolder>(
      bloc: _bloc,
      selector: (state) {
        if (state is S) {
          return _BlocPartSelectHolder(_selector!(state), true);
        }
        return _BlocPartSelectHolder(null, false);
      },
      builder: (context, holder) {
        if (!holder.hasState) {
          return _initialWidget ?? _child ?? const SizedBox.shrink();
        }
        return _selectBuilder!(context, holder.selected);
      },
    );
  }
}

class _BlocPartSelectHolder {
  final dynamic selected;
  final bool hasState;

  _BlocPartSelectHolder(this.selected, this.hasState);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! _BlocPartSelectHolder) return false;
    if (!hasState && !other.hasState) return true;
    if (hasState != other.hasState) return false;
    return selected == other.selected;
  }

  @override
  int get hashCode => hasState ? selected.hashCode : 0;
}
