# OptiCore Module Structure 🚀

This document outlines the **OptiCore** module structure, designed for **scalability, maintainability, and efficiency**. The architecture ensures a **clean separation of concerns**, making development seamless.

## 📂 Folder Structure

Each module follows this structured hierarchy:

```
lib/
  module/
    <ModuleName>/
      📦 bloc/              # Business logic layer (BLoC)
        ├── <module_name>_bloc.dart
      ⚡ event/              # Events triggering BLoC updates
        ├── <module_name>_event.dart
      📊 state/              # UI state definitions
        ├── <module_name>_state.dart
      🖥️ screen/             # UI components (Widgets)
        ├── <module_name>_screen.dart
      🔗 import/             # Centralized module imports
        ├── <module_name>_import.dart
      🏭 factory/            # State factory management
        ├── <module_name>_state_factory.dart
```

### ✨ Example: `ExampleModule`

```
lib/
  module/
    ExampleModule/
      📦 bloc/
        ├── example_module_bloc.dart
      ⚡ event/
        ├── example_module_event.dart
      📊 state/
        ├── example_module_state.dart
      🖥️ screen/
        ├── example_module_screen.dart
      🔗 import/
        ├── example_module_import.dart
      🏭 factory/
        ├── example_module_state_factory.dart
```

## 🔍 File Overview

### 🏗️ **BLoC (`example_module_bloc.dart`)**
Handles the business logic and state transitions.

```dart
part of '../import/example_module_import.dart';

class ExampleModuleBloc extends BaseBloc {
  ExampleModuleBloc()
      : super(
          ExampleModuleStateFactory(),
          initialState: ExampleModuleInitialState(),
        );

  @override
  void onDispose() {}
}
```

### ⚡ **Event (`example_module_event.dart`)**
Defines events that trigger state changes.

```dart
part of '../import/example_module_import.dart';

class ExampleModuleInitialEvent extends BaseEvent {}
```

### 📊 **State (`example_module_state.dart`)**
Defines the UI state.

```dart
part of '../import/example_module_import.dart';

class ExampleModuleInitialState extends RenderDataState {
  ExampleModuleInitialState() : super(null);
}
```

### 🖥️ **Screen (`example_module_screen.dart`)**
Handles the UI and interacts with the BLoC.

```dart
part of '../import/example_module_import.dart';

class ExampleModuleScreen extends StatefulWidget {
  final ExampleModuleBloc bloc;

  const ExampleModuleScreen({super.key, required this.bloc});

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

### 🔗 **Import (`example_module_import.dart`)**
Manages centralized imports.

```dart
import 'package:flutter/material.dart';
import 'package:opticore/opticore.dart';

part '../bloc/example_module_bloc.dart';
part '../event/example_module_event.dart';
part '../screen/example_module_screen.dart';
part '../state/example_module_state.dart';
part '../factory/example_module_state_factory.dart';
```

### 🏭 **State Factory (`example_module_state_factory.dart`)**
Creates and manages different states dynamically.

```dart
part of '../import/example_module_import.dart';

class ExampleModuleStateFactory extends BaseFactory {
  @override
  BaseState getState<M>(M data) {
    return DefaultState();
  }
}
```

---

## 🎯 Key Benefits

✅ **Modular & Scalable** – Ensures long-term maintainability  
✅ **Separation of Concerns** – Organized into logical units  
✅ **Optimized for BLoC** – Structured for predictable state management  

Start building robust **OptiCore** modules with this **scalable structure** today! 🚀
