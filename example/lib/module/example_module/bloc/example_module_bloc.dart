part of '../import/example_module_import.dart';

class ExampleModuleBloc extends BaseBloc {
  ExampleModuleBloc()
      : super(
          ExampleModuleStateFactory(),
          initialState: ExampleModuleInitialState(),
        ) {
    // Example of using debounce transformer for search functionality
    // This will delay processing of search events by 400ms
    // If a new search event comes within 400ms, the previous one is cancelled
    on<SearchEvent>(
      _onSearchEvent,
      transformer: debounce(const Duration(milliseconds: 400)),
    );

    // Example of using sequential transformer for form submission
    // This ensures form submissions are processed one by one
    // Prevents duplicate submissions when user clicks multiple times
    on<SubmitFormEvent>(
      _onSubmitFormEvent,
      transformer: sequential(),
    );
  }

  Future<void> _onSearchEvent(
    SearchEvent event,
    Emitter<BaseState> emit,
  ) async {
    // Emit loading state
    emit(LoadingStateRender());

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    // Emit success state with search results
    emit(SearchSuccessState("Search results for: '${event.query}'"));
  }

  Future<void> _onSubmitFormEvent(
    SubmitFormEvent event,
    Emitter<BaseState> emit,
  ) async {
    // Emit loading state
    emit(LoadingStateRender());

    // Simulate form submission delay
    await Future.delayed(const Duration(seconds: 2));

    // Emit success state with submission result
    emit(SubmitSuccessState(
        "Form submitted successfully with data: '${event.data}'"));
  }

  @override
  void onDispose() {}
}
