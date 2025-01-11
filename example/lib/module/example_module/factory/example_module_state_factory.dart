part of '../import/example_module_import.dart';

class ExampleModuleStateFactory extends BaseFactory {
  @override
  BaseState getState<M>(M data) {
    return DefaultState();
  }
}
