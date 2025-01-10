import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final Widget Function(BaseState state) widgetRenderer;

  /// Creates a [ContentBuilder] instance.
  ///
  /// - [stateListener]: The callback to handle non-render state changes.
  /// - [widgetRenderer]: The callback to render widgets based on the render state.
  const ContentBuilder({
    super.key,
    required this.stateListener,
    required this.widgetRenderer,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<M, BaseState>(
      // Rebuilds UI only for states that implement RenderState.
      buildWhen: (previous, current) => current is RenderState,
      // Listens only for states that implement NonRenderState.
      listenWhen: (previous, current) => current is NonRenderState,
      listener: (context, state) => stateListener(context, state),
      builder: (context, state) => widgetRenderer(state),
    );
  }
}