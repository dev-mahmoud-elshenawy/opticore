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

  /// Optional function to determine whether the builder should rebuild.
  ///
  /// Only called when both previous and current states are of type [S].
  /// If `null`, rebuilds on every [S] emission.
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
    return BlocBuilder<B, BaseState>(
      buildWhen: (previous, current) {
        // Only rebuild when the current state is of type S
        if (current is! S) return false;
        // If buildWhen is provided and previous is also S, delegate to it
        if (buildWhen != null && previous is S) {
          return buildWhen!(previous, current);
        }
        // Rebuild when we first get a state of type S, or when it changes
        return true;
      },
      builder: (context, state) {
        if (state is S) {
          return builder(context, state);
        }
        return initialWidget ?? const SizedBox.shrink();
      },
    );
  }
}
