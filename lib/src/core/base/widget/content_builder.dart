import 'package:flutter/material.dart';
import 'package:opticore/opticore.dart';

/// A reusable widget that listens to state changes in a [Bloc] and builds UI
/// based on specific render states.
///
/// [ContentBuilder] is a wrapper around [BlocConsumer], tailored for scenarios
/// where distinct logic is needed for rendering and state handling. It simplifies
/// the process of separating UI rendering and state listening logic in
/// applications that follow the BLoC architecture.
///
/// This widget ensures that:
/// - UI updates are triggered only for states that implement [RenderState].
/// - State listeners respond only to states that implement [NonRenderState].
///
/// ### Example Usage:
/// ```dart
/// ContentBuilder<MyBloc>(
///  create: (context) => MyBloc(),
///   stateListener: (context, state) {
///     if (state is SomeNonRenderState) {
///       // Handle state changes like showing a toast or a dialog.
///     }
///   },
///   widgetRenderer: (state) {
///     if (state is SomeRenderState) {
///       return Text('Rendering state: ${state.data}');
///     }
///     return SizedBox.shrink();
///   },
/// );
/// ```
///
/// ### Type Parameters:
/// - [M]: The type of the BLoC being consumed, which must extend [BlocBase] and
/// emit states of type [BaseState].
///
/// ### Constructor Parameters:
/// - [stateListener]: A callback invoked whenever a [NonRenderState] is emitted.
///   - [context]: The [BuildContext] where the widget is built.
///   - [state]: The emitted state.
/// - [widgetRenderer]: A function that returns the widget to display based on
///   the current [RenderState].
///   - [state]: The emitted state used for rendering.
/// - [create]: A function that creates the BLoC instance to provide to the [BlocProvider].
///
///
/// ### Widget Lifecycle:
/// - **Listening:** The [stateListener] is triggered when a [NonRenderState] is
///   emitted.
/// - **Building:** The [widgetRenderer] is called to render the UI when a
///   [RenderState] is emitted.
///
/// ### Example:
/// ```dart
/// ContentBuilder<MyBloc>(
///  create: (context) => MyBloc(),
///   stateListener: (context, state) {
///     if (state is ErrorStateNonRender) {
///       showErrorDialog(context, state.errorMessage);
///     }
///   },
///   widgetRenderer: (state) {
///     if (state is LoadingStateRender) {
///       return CircularProgressIndicator();
///     } else if (state is LoadedStateRender) {
///       return Text(state.data);
///     }
///     return SizedBox.shrink();
///   },
/// );
/// ```
class ContentBuilder<M extends BlocBase<BaseState>> extends StatelessWidget {
  /// Callback for handling non-render state changes.
  ///
  /// This function is called whenever a [NonRenderState] is emitted.
  /// It receives the [BuildContext] and the emitted [BaseState].
  final void Function(BuildContext context, BaseState state) stateListener;

  /// Callback for rendering widgets based on render states.
  ///
  /// This function is called to render the widget for any emitted [RenderState].
  /// It receives the emitted [BaseState] and returns the corresponding widget.
  final Widget Function(BuildContext context, BaseState state) widgetRenderer;

  /// The BLoC instance to provide to the [BlocProvider].
  ///
  /// This BLoC instance is used to provide the BLoC to the [BlocProvider] widget.
  /// It is used to manage the state of the widget and emit new states.
  final M Function(BuildContext) create;

  /// Controls whether the BLoC should be disposed when the widget is removed.
  ///
  /// Defaults to `true`, meaning the BLoC will be automatically disposed when
  /// the widget is removed from the tree. Set to `false` to keep the BLoC alive.
  final bool disposeBloc;

  /// Creates a [ContentBuilder] instance.
  ///
  /// - [stateListener]: The callback to handle non-render state changes.
  /// - [widgetRenderer]: The callback to render widgets based on the render state.
  /// - [create]: The factory function to create the BLoC instance.
  /// - [disposeBloc]: Controls BLoC disposal (defaults to `true`).
  const ContentBuilder({
    super.key,
    required this.stateListener,
    required this.widgetRenderer,
    required this.create,
    this.disposeBloc = true,
  });

  @override
  Widget build(BuildContext context) {
    final consumer = BlocConsumer<M, BaseState>(
      // Rebuilds UI only for states that implement RenderState.
      buildWhen: (previous, current) => current is RenderState,
      // Listens only for states that implement NonRenderState.
      listenWhen: (previous, current) => current is NonRenderState,
      listener: (context, state) => stateListener(context, state),
      builder: (context, state) => widgetRenderer(context, state),
    );

    // If disposeBloc is false, use BlocProvider.value to prevent disposal
    if (!disposeBloc) {
      return BlocProvider<M>.value(
        value: create(context),
        child: consumer,
      );
    }

    // Otherwise, use regular BlocProvider which will auto-dispose
    return BlocProvider<M>(
      lazy: false,
      create: create,
      child: consumer,
    );
  }
}
