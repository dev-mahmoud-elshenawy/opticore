part of '../import/example_module_import.dart';

class ExampleModuleInitialState extends RenderDataState {
  ExampleModuleInitialState() : super(null);
}

/// State for successful search results (debounce example)
class SearchSuccessState extends RenderDataState {
  SearchSuccessState(String searchResult) : super(searchResult);
}

/// State for successful form submission (sequential example)
class SubmitSuccessState extends RenderDataState {
  SubmitSuccessState(String submitResult) : super(submitResult);
}
