part of '../import/base_import.dart';

/// A typedef for creating instances of a BLoC (Business Logic Component).
///
/// This function type defines a factory method that returns an instance of a
/// [BaseBloc] or its subclass. It is commonly used for dependency injection
/// or dynamic BLoC creation in applications that follow the BLoC architecture.
///
/// The generic parameter [M] ensures that the factory function creates instances
/// of a specific type that extends [BaseBloc].
///
/// Example Usage:
/// ```dart
/// BlocCreator<MyBloc> myBlocCreator = () => MyBloc();
/// MyBloc bloc = myBlocCreator(); // Creates an instance of MyBloc
/// ```
///
/// This typedef is particularly useful in scenarios where BLoCs need to be
/// dynamically created or injected into widgets.
///
/// - [M] is a type parameter that represents the type of BLoC to be created.
/// It must extend [BaseBloc].
///
/// Example:
/// ```dart
/// class MyBloc extends BaseBloc {
///   // Bloc implementation
/// }
///
/// BlocCreator<MyBloc> creator = () => MyBloc();
/// ```
typedef BlocCreator<M extends BaseBloc> = M Function();

/// A base class for scenes that manage state and provide common functionalities
/// for a screen in a Flutter application.
///
/// [BaseScreen] is an abstract class designed to be extended by other classes
/// that handle UI logic and state management using the BLoC pattern. It simplifies
/// common tasks such as showing loading indicators, handling errors, and rendering
/// UI based on states.
///
/// The class leverages a generic [M] extending [BaseBloc] for state management,
/// a [T] extending [StatefulWidget] as the associated widget, and a type parameter [F]
/// for data representation.
///
/// ### Features:
/// - BLoC state management integration.
/// - Handles safe areas and scaffolding configuration.
/// - Provides utility methods for showing toasts, loading, and handling keyboard focus.
/// - Supports rendering widgets based on various states (e.g., loading, error, data).
///
/// ### Example:
/// ```dart
/// class MyScene extends BaseScene<MyBloc, MyWidget, MyData> {
///   MyScene(MyBloc bloc) : super(bloc);
///
///   @override
///   Widget buildWidget(BuildContext context, RenderDataState<MyData> state) {
///     return Text(state.data.toString());
///   }
/// }
/// ```
///
/// Type Parameters:
/// - [M]: The type of the BLoC used in the scene.
/// - [T]: The type of the stateful widget.
/// - [F]: The type of the data represented in the state.
///
/// To use this class, provide an instance of a BLoC and override the [buildWidget]
/// method to define the UI for the `RenderDataState`.
/// A base class for managing UI scenes with integrated BLoC state management
/// and common utility functions.
///
/// This class provides the following capabilities:
/// - A structured way to handle BLoC-based state transitions.
/// - Built-in support for handling loading, error, and data rendering states.
/// - Utility methods for showing toasts, handling safe areas, and managing scaffolds.
/// - Customizable app bar and scaffold configurations.
abstract class BaseScreen<M extends BaseBloc, T extends StatefulWidget, F>
    extends State<T> with ViewStateHandler {
  /// The BLoC instance associated with the screen.
  final M _bloc;

  /// Constructor to initialize the [BaseScreen] with a BLoC instance.
  BaseScreen(M bloc) : _bloc = bloc;

  /// The base context of the widget. This is updated during the widget's lifecycle.
  late BuildContext baseContext;

  /// Optional context for accessing the screen's context.
  BuildContext? screenContext;

  /// Helper for route management, initialized in the `build` method.
  RouteHelper? route;

  /// A cancel function used to hide loading indicators.
  CancelFunc? _cancelFunc;

  /// Builder for rendering content and handling state changes.
  ContentBuilder? _builder;

  /// The width of the screen, calculated during the `build` method.
  double screenWidth = 0.0;

  /// The height of the screen, calculated during the `build` method.
  double screenHeight = 0.0;

  /// Determines if the safe area should be ignored.
  /// Override this in subclasses if needed.
  bool? get ignoreSafeArea => false;

  /// Determines if the scaffold should be ignored.
  /// Override this in subclasses if needed.
  bool get ignoreScaffold => false;

  /// Configuration for the app bar of the scene.
  /// Override to provide custom app bar settings.
  AppBarConfig? get appBarData => null;

  /// Custom widget for the app bar. Use this to replace the default app bar.
  Widget? get customAppBar => null;

  /// Configuration for the scaffold, including the app bar and other properties.
  /// Override to customize the scaffold for the scene.
  ScaffoldConfig get scaffoldConfig => ScaffoldConfig(
        appBar: _buildAppBar(),
      );

  /// The BLoC instance exposed to subclasses for convenience.
  M get bloc {
    try {
      return BlocProvider.of<M>(baseContext);
    } catch (e) {
      Logger.error('Error while accessing BLoC: $e');
      rethrow;
    }
  }

  /// Posts a [BaseEvent] to the BLoC associated with this scene.
  void postEvent(BaseEvent event) {
    try {
      BlocProvider.of<M>(baseContext).add(event);
    } catch (e) {
      Logger.error('Failed to post event: $e');
    }
  }

  /// Determines the icon brightness for the status bar.
  bool get isDarkStatusBarIcon => true;

  // Override Points for Subclasses

  /// Called during the `initState` method. Override to initialize resources.
  void init() {}

  /// Called during the `dispose` method. Override to clean up resources.
  void disposeData() {}

  /// Called during the `didChangeDependencies` method.
  /// Override to handle dependency changes.
  void changeDependencies() {}

  /// Called during the `didUpdateWidget` method.
  /// Override to handle widget updates.
  void updateWidget(covariant T oldWidget) {}

  // UI Widgets for States

  /// Override to provide the widget rendered for a `RenderDataState`.
  Widget buildWidget(BuildContext context, RenderDataState<F> state);

  /// Provides a loading widget. Override to customize.
  Widget? loadingWidget() => LoadingWidget();

  /// Provides an animated loading widget. Override to customize.
  Widget? loadingAnimatedWidget() => LoadingAnimatedWidget();

  /// Provides an error widget with a message. Override to customize.
  Widget? errorWidget(String message) => ExceptionWidget(message: message);

  /// Provides an initial widget. Override to customize.
  Widget? initialWidget() => SizedBox.fromSize();

  /// Listener [Optional Implementation](To keep from breaking Interface Segregation Principle)
  void listenToState(BuildContext context, BaseState state) {}

  @override
  void initState() {
    super.initState();
    if (mounted) {
      init();
      _builder = ContentBuilder<M>(
        create: (context) => _bloc,
        stateListener: _handleStateListener,
        widgetRenderer: (context, state) {
          baseContext = context;
          Widget ui = _handleWidgetRendering(state) ?? SizedBox.shrink();
          return ignoreSafeArea == true ? ui : SafeArea(child: ui);
        },
      );
    }
  }

  @override
  void dispose() {
    disposeData();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    changeDependencies();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness:
            isDarkStatusBarIcon ? Brightness.dark : Brightness.light,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          screenContext = context;
          route = RouteHelper(context);
          screenWidth = constraints.maxWidth;
          screenHeight = constraints.maxHeight;
          return ignoreScaffold
              ? _handleNullBuilder()
              : BodyScaffoldConfig(
                  scaffoldConfig: scaffoldConfig.copyWith(
                    appBar: _getAppBar(),
                  ),
                  body: _handleNullBuilder(),
                ).toScaffold();
        },
      ),
    );
  }

  /// A helper method to determine the appBar value.
  PreferredSizeWidget? _getAppBar() {
    // If scaffoldConfig.appBar is not null, return it and ignore appBarData.
    if (scaffoldConfig.appBar != null) {
      return scaffoldConfig.appBar;
    }
    // If appBarData is not null, return the custom app bar.
    if (appBarData != null) {
      return _buildAppBar();
    }
    // If both appBar and appBarData are null, return null.
    return null;
  }

  /// Handle null scenario checker for [_builder]
  dynamic _handleNullBuilder() {
    if (_builder == null) {
      return SizedBox.shrink();
    } else {
      return _builder;
    }
  }

  /// Builds the app bar using the provided configurations or a custom widget.
  PreferredSizeWidget? _buildAppBar() {
    if (customAppBar != null) return customAppBar as PreferredSizeWidget;
    if (appBarData != null) {
      return CoreAppBar(
        route: route!,
        config: appBarData,
      );
    }
    return null;
  }

  /// Handles state changes that do not trigger UI rendering.
  void _handleStateListener(BuildContext context, BaseState state) {
    switch (state) {
      case LoadingStateNonRender _:
        showLoading();
        break;
      case EndLoadingStateNonRender _:
        hideLoading();
        break;
      case ErrorStateNonRender _:
        _handleErrorState(state);
        break;
    }

    listenToState(context, state);
  }

  /// Handles state rendering based on the type of state received.
  Widget? _handleWidgetRendering(BaseState state) {
    if (state is RenderState) {
      if (state is LoadAnimationState) {
        return loadingAnimatedWidget();
      } else if (state is LoadingStateRender) {
        return loadingWidget();
      } else if (state is RenderDataState) {
        try {
          // Safer casting with an explicit check
          if (state is RenderDataState<F>) {
            return buildWidget(baseContext, state);
          }
          // If generic type doesn't match
          return errorWidget('Incompatible state data format');
        } catch (e) {
          Logger.error('Error rendering data state: $e');
          return errorWidget('Error displaying content');
        }
      } else if (state is InitialState) {
        return initialWidget();
      } else if (state is ErrorStateRender) {
        return errorWidget(state.errorMessage ?? 'An error occurred');
      } else {
        return const SizedBox.shrink();
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  /// Handles error states, including unauthenticated states and warnings.
  void _handleErrorState(ErrorStateNonRender state) {
    hideLoading();
    switch (state.type) {
      case ApiResponseType.unauthorizedError:
        UnAuthenticatedConfig.onUnauthenticated?.call();
        break;

      default:
        break;
    }
  }

  // Utility Methods

  /// Shows a loading indicator using the [BotToast] library.
  @override
  void showLoading() {
    closeKeyboard();
    _cancelFunc?.call();
    _cancelFunc = BotToast.showLoading();
    Future.delayed(NetworkHelper.connectionTimeout, () {
      if (_cancelFunc != null) {
        hideLoading();
      }
    });
  }

  /// Hides the loading indicator if it's showing.
  @override
  void hideLoading() {
    _cancelFunc?.call();
  }

  /// Sets the state of the widget only if it is mounted.
  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  /// Closes the keyboard if it's open.
  @override
  void closeKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  /// Shows a success toast with a message.
  @override
  void showSuccess({String? message}) {
    if (message?.isNotEmpty ?? false) {
      ToastHelper.showToast(message!, type: ToastType.success);
    }
  }

  /// Shows an error toast with a message.
  @override
  void showError({String? message}) {
    if (message?.isNotEmpty ?? false) {
      ToastHelper.showToast(message!, type: ToastType.error);
    }
  }

  /// Shows a warning toast with a message.
  @override
  void showWarning({String? message}) {
    if (message?.isNotEmpty ?? false) {
      ToastHelper.showToast(message!, type: ToastType.warning);
    }
  }

  /// Shows an info toast with a message.
  @override
  void showInfo({String? message}) {
    if (message?.isNotEmpty ?? false) {
      ToastHelper.showToast(message!, type: ToastType.info);
    }
  }
}
