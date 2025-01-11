# OptiCore Module Structure

This document outlines the structure of a typical OptiCore module generated for efficient development. The module follows a clear, scalable architecture that separates concerns and encourages maintainability.

## Folder Structure

Each module follows this folder structure:

```
lib/
  module/
    <ModuleName>/
      bloc/
        <module_name>_bloc.dart        # Manages the business logic for the module
      event/
        <module_name>_event.dart       # Contains events that trigger changes in the bloc
      state/
        <module_name>_state.dart       # Defines the state classes that represent the UI states
      screen/
        <module_name>_screen.dart      # UI Screen (Widgets) for the module
      import/
        <module_name>_import.dart     # Central import file for all module files
      factory/
        <module_name>_state_factory.dart  # State factory for managing state instantiation
```

### Example

Let's consider an example module named `ExampleModule`.

The structure will be:

```
lib/
  module/
    ExampleModule/
      bloc/
        example_module_bloc.dart
      event/
        example_module_event.dart
      state/
        example_module_state.dart
      screen/
        example_module_screen.dart
      import/
        example_module_import.dart
      factory/
        example_module_state_factory.dart
```

### Example Content

**`example_module_bloc.dart`**:

```dart
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
```

**`example_module_event.dart`**:

```dart
part of '../import/example_module_import.dart';

class ExampleModuleInitialEvent extends BaseEvent {}
```

**`example_module_state.dart`**:

```dart
part of '../import/example_module_import.dart';

class ExampleModuleInitialState extends RenderDataState {
  ExampleModuleInitialState() : super(null);
}
```

**`example_module_screen.dart`**:

```dart
part of '../import/example_module_import.dart';

class ExampleModuleScreen extends StatefulWidget {
  final ExampleModuleBloc bloc;

  const ExampleModuleScreen({
    super.key,
    required this.bloc,
  });

  @override
  ExampleModuleScreenState createState() => ExampleModuleScreenState(bloc);
}

class ExampleModuleScreenState
    extends BaseScreen<ExampleModuleBloc, ExampleModuleScreen, dynamic> {
  ExampleModuleScreenState(super.bloc);

  @override
  Widget buildWidget(BuildContext context, RenderDataState state) {
    return Container();
  }

  @override
  void listenToState(BuildContext context, BaseState state) {}
}
```

**`example_module_import.dart`**:

```dart
import 'package:flutter/material.dart';
import 'package:opticore/opticore.dart';

part '../bloc/example_module_bloc.dart';

part '../event/example_module_event.dart';

part '../screen/example_module_screen.dart';

part '../state/example_module_state.dart';

part '../factory/example_module_state_factory.dart';
```

**`example_module_state_factory.dart`**:

```dart
part of '../import/example_module_import.dart';

class ExampleModuleStateFactory extends BaseFactory {
  @override
  BaseState getState<M>(M data) {
    return DefaultState();
  }
}
```

## File Breakdown

1. **Bloc**: Contains the business logic of the module, managing the state transitions.
2. **Event**: Defines the events that can trigger changes in the bloc.
3. **State**: Defines different states that the UI can be in, based on the bloc's behavior.
4. **Screen**: Contains the UI code and manages interactions with the bloc.
5. **Import**: Imports all the necessary files for the module, providing a central location for module imports.
6. **State Factory**: A class used to create different states based on data or logic.

---

This structure provides a clean and scalable way to organize your Flutter modules, separating concerns and making it easy to maintain as your project grows.
