part of '../import/example_module_import.dart';

class ExampleModuleInitialEvent extends BaseEvent {}

/// Event for demonstrating debounce transformer
/// Useful for search inputs where you want to delay API calls
class SearchEvent extends BaseEvent {
  final String query;

  SearchEvent(this.query);
}

/// Event for demonstrating sequential transformer
/// Useful for preventing duplicate form submissions
class SubmitFormEvent extends BaseEvent {
  final String data;

  SubmitFormEvent(this.data);
}
