part of '../import/base_import.dart';

/// A widget that selectively rebuilds only when a specific [ComponentState] is emitted.
///
/// Unlike regular state management that rebuilds the entire UI when a [RenderState]
/// is emitted, this widget only rebuilds its wrapped content when a matching
/// [ComponentState] is received.
///
/// Type Parameters:
/// - [B]: The type of BLoC (must extend BaseBloc)
/// - [S]: The specific state type this builder listens for (must extend ComponentState)
///
/// ### Example
/// ```dart
/// StateBuilder<ProfileBloc, ComponentDataState<UserProfile>>(
///   builder: (context, state) {
///     return Text(state.data.name); // Only this Text widget rebuilds
///   },
///   buildWhen: (previous, current) => previous.data.name != current.data.name,
///   initialWidget: const Text('Loading profile...'),
/// ),
/// ```
class StateBuilder<B extends BaseBloc, S extends ComponentState>
    extends StatelessWidget {
  /// Function that builds the widget based on the current component state
  final Widget Function(BuildContext context, S state) builder;

  /// Optional function to determine whether the builder should rebuild
  final bool Function(S previous, S current)? buildWhen;

  /// Optional initial widget to show when the specific component state hasn't been emitted yet
  final Widget? initialWidget;

  const StateBuilder({
    super.key,
    required this.builder,
    this.buildWhen,
    this.initialWidget,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<B, BaseState, _StateHolder<S>>(
      selector: (state) {
        if (state is S) {
          return _StateHolder<S>(state);
        }
        return _StateHolder<S>(null);
      },
      builder: (context, holder) {
        if (holder.state != null) {
          return builder(context, holder.state!);
        }
        return initialWidget ?? const SizedBox.shrink();
      },
    );
  }
}

/// A simple holder class that helps with equality comparison
class _StateHolder<S> {
  final S? state;

  _StateHolder(this.state);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! _StateHolder<S>) return false;

    // Both null case
    if (state == null && other.state == null) return true;

    // One null case
    if (state == null || other.state == null) return false;

    // Compare actual states
    return state == other.state;
  }

  @override
  int get hashCode => state?.hashCode ?? 0;
}
