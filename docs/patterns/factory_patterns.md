# OptiCore Factory Patterns

Patterns for creating state factories in BLoCs.

---

## Pattern 1: Basic Factory

**When to use:** Every BLoC needs a factory

**Structure:**
```dart
class FeatureFactory extends BaseFactory {
  @override
  BaseState getState<M>(M data) {
    if (data is FeatureModel) {
      return FeatureLoadedState(data);
    }
    return DataState(data);
  }
}
```

**Conventions:**
- Extends `BaseFactory`
- Override `getState<M>(M data)` method
- Use `is` type checking for each model
- Return `DataState(data)` as fallback

---

## Pattern 2: Multi-Model Factory

**When to use:** BLoC handles multiple data types

**Structure:**
```dart
class HomeFactory extends BaseFactory {
  @override
  BaseState getState<M>(M data) {
    if (data is UserModel) {
      return UserLoadedState(data);
    }
    if (data is ProductListModel) {
      return ProductsLoadedState(data);
    }
    if (data is BannerListModel) {
      return BannersLoadedState(data);
    }
    return DataState(data);
  }
}
```

**Conventions:**
- Check types in order of likelihood (most common first)
- Each model maps to specific state
- Always provide fallback

---

## Pattern 3: State with Transformation

**When to use:** Need to transform data before creating state

**Structure:**
```dart
class ListFactory extends BaseFactory {
  @override
  BaseState getState<M>(M data) {
    if (data is ItemListModel) {
      // Transform data
      final items = data.items ?? [];
      final filteredItems = items.where((item) => item.isActive).toList();

      return ItemsLoadedState(filteredItems);
    }
    return DataState(data);
  }
}
```

**Conventions:**
- Extract and transform data before state creation
- Apply business logic (filtering, sorting, mapping)
- Pass transformed data to state

---

## Pattern 4: Factory with Default Factory Fallback

**When to use:** Simple BLoCs that don't need custom factory

**Structure:**
```dart
// In BLoC constructor
class SimpleBloc extends BaseBloc {
  SimpleBloc() : super(DefaultFactory());  // Use built-in factory

  // Or omit factory parameter (uses DefaultFactory automatically)
  // SimpleBloc() : super();
}

// DefaultFactory implementation (built into OptiCore):
class DefaultFactory extends BaseFactory {
  @override
  BaseState getState<M>(M data) {
    return DataState(data);
  }
}
```

**Conventions:**
- Use `DefaultFactory()` when no custom mapping needed
- Suitable for single-model BLoCs
- Returns generic `DataState<M>`

---

## Pattern 5: Factory with Error Handling

**When to use:** Need custom error state logic

**Structure:**
```dart
class DataFactory extends BaseFactory {
  @override
  BaseState getState<M>(M data) {
    if (data is DataModel) {
      // Check for empty data
      if (data.items?.isEmpty ?? true) {
        return EmptyDataState();
      }
      return DataLoadedState(data);
    }

    if (data is ErrorModel) {
      return CustomErrorState(data.message);
    }

    return DataState(data);
  }
}
```

**Conventions:**
- Check for empty/null data conditions
- Handle error models explicitly
- Emit appropriate states for edge cases

---

## Pattern 6: Factory with Message Model

**When to use:** API returns success message instead of data

**Structure:**
```dart
class ActionFactory extends BaseFactory {
  @override
  BaseState getState<M>(M data) {
    if (data is MessageModel) {
      return ActionSuccessState(data.message);
    }
    if (data is DataModel) {
      return DataLoadedState(data);
    }
    return DataState(data);
  }
}
```

**Conventions:**
- Handle `MessageModel` for action confirmations
- Extract message from model
- Map to success/fail states

---

## Pattern 7: Factory Usage in BLoC

**When to use:** Every BLoC with API calls

**Structure:**
```dart
class FeatureBloc extends BaseBloc {
  final FeatureRepo _repo;

  FeatureBloc(this._repo) : super(FeatureFactory());

  Future<void> _onFetchData(
    FetchDataEvent event,
    Emitter emit,
  ) async {
    emit(LoadingStateRender());

    final response = await _repo.getData();

    // handleApiResponse automatically uses factory for success
    emit(handleApiResponse(response));
  }
}
```

**Conventions:**
- Pass factory to `super()` in constructor
- `handleApiResponse()` calls factory automatically on success
- Factory only invoked for successful API responses

---

## Pattern 8: State Mapping Table

**When to use:** Planning factory implementation

| Response Type | Model Type | State Type |
|--------------|------------|------------|
| User profile | `UserModel` | `UserLoadedState` |
| Product list | `ProductListModel` | `ProductsLoadedState` |
| Empty list | `ListModel` (empty) | `EmptyListState` |
| Success message | `MessageModel` | `ActionSuccessState` |
| Error | N/A | Handled by `handleApiResponse` |

---

## Pattern 9: Factory with Nested Data

**When to use:** API response has nested data structure

**Structure:**
```dart
class NestedFactory extends BaseFactory {
  @override
  BaseState getState<M>(M data) {
    if (data is WrapperModel) {
      // Extract nested data
      final userData = data.user;
      final settings = data.settings;
      final notifications = data.notifications;

      return ProfileLoadedState(
        user: userData,
        settings: settings,
        notifications: notifications,
      );
    }
    return DataState(data);
  }
}
```

**Conventions:**
- Extract nested fields from wrapper model
- Pass individual fields to state
- State holds denormalized data

---

## Pattern 10: Factory with Type Parameters

**When to use:** Generic state that needs type info

**Structure:**
```dart
class GenericFactory<T> extends BaseFactory {
  @override
  BaseState getState<M>(M data) {
    if (data is List<T>) {
      return ListLoadedState<T>(data);
    }
    if (data is T) {
      return ItemLoadedState<T>(data);
    }
    return DataState(data);
  }
}

// Usage
class ItemsBloc extends BaseBloc {
  ItemsBloc() : super(GenericFactory<Item>());
}
```

**Conventions:**
- Add generic type parameter to factory class
- Check for both single items and lists
- Maintain type safety through generics

---

## Summary Table

| Pattern | Key Feature | Use Case |
|---------|------------|----------|
| Basic Factory | Single model → state | Simple BLoCs |
| Multi-Model | Multiple models | Complex BLoCs |
| With Transformation | Data processing | Business logic |
| Default Factory | No custom logic | Simple mappings |
| With Error Handling | Edge cases | Empty/error states |
| Message Model | Action responses | CRUD operations |
| In BLoC | `super(Factory())` | All BLoCs |
| State Mapping | Planning | Design phase |
| Nested Data | Data extraction | Complex responses |
| Generic Factory | Type parameters | Reusable factories |

---

## Best Practices

✅ **DO:**
- Create one factory per BLoC (or feature module)
- Always provide fallback `return DataState(data)`
- Use type checking (`is`) for model discrimination
- Transform data in factory if needed
- Keep factory logic simple and testable

❌ **DON'T:**
- Don't perform async operations in factory
- Don't make API calls from factory
- Don't emit multiple states from factory
- Don't use factory for error handling (use `handleApiResponse`)
- Don't create factories with side effects

---

## Quick Reference: Complete Factory

```dart
class FeatureFactory extends BaseFactory {
  @override
  BaseState getState<M>(M data) {
    // Single item
    if (data is ItemModel) {
      return ItemLoadedState(data);
    }

    // List
    if (data is ItemListModel) {
      final items = data.items ?? [];

      if (items.isEmpty) {
        return EmptyListState();
      }

      return ItemsLoadedState(items);
    }

    // Action result
    if (data is MessageModel) {
      return ActionSuccessState(data.message);
    }

    // Fallback
    return DataState(data);
  }
}
```

---

## Integration with BaseBloc

```dart
// 1. Define factory
class HomeFactory extends BaseFactory {
  @override
  BaseState getState<M>(M data) {
    if (data is HomeModel) {
      return HomeLoadedState(data);
    }
    return DataState(data);
  }
}

// 2. Pass to BLoC
class HomeBloc extends BaseBloc {
  HomeBloc() : super(HomeFactory());  // Inject factory
}

// 3. Factory is used automatically
Future<void> _onFetchData(event, emit) async {
  final response = await _repo.getData();

  // On success, factory.getState() is called automatically
  emit(handleApiResponse(response));
}
```

---

*OptiCore v2.2.0 | Factory Patterns*
