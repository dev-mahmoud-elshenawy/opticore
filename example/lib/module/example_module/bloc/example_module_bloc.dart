part of '../import/example_module_import.dart';

class ExampleModuleBloc extends BaseBloc {
  ExampleModuleBloc()
      : super(
          ExampleModuleStateFactory(),
          initialState: ExampleModuleInitialState(),
        ) {}

  @override
  void onDispose() {}
}
