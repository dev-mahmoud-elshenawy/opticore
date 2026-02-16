# OptiCore Event Patterns

Patterns for defining and handling events in BLoCs.

---

## Pattern 1: Basic Event Definition

**When to use:** Every event in your application

**Structure:**
```dart
class FetchDataEvent extends BaseEvent {
  const FetchDataEvent();

  @override
  List<Object?> get props => [];
}
```

**Conventions:**
- Extends `BaseEvent` (which extends `Equatable`)
- Class name describes the action: `{Action}{Object}Event`
- Constructor is `const` if no parameters
- Override `props` for equality comparison (empty list if no fields)

---

## Pattern 2: Event with Parameters

**When to use:** When event needs data to process

**Structure:**
```dart
class UpdateProfileEvent extends BaseEvent {
  final String name;
  final String email;
  final int? age;

  const UpdateProfileEvent({
    required this.name,
    required this.email,
    this.age,
  });

  @override
  List<Object?> get props => [name, email, age];
}
```

**Conventions:**
- Use `required` for mandatory parameters
- Make optional parameters nullable (`T?`)
- Include all fields in `props` for proper equality
- Use named parameters for clarity

---

## Pattern 3: Event with ID Parameter

**When to use:** Fetching/updating/deleting specific resource

**Structure:**
```dart
class DeleteItemEvent extends BaseEvent {
  final int itemId;

  const DeleteItemEvent(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

// Or with named parameter
class FetchUserEvent extends BaseEvent {
  final int userId;

  const FetchUserEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}
```

**Conventions:**
- Use positional parameter for single ID: `DeleteItemEvent(id)`
- Use named parameter for clarity: `FetchUserEvent(userId: id)`
- ID fields typically `int` or `String`

---

## Pattern 4: Event with Complex Model

**When to use:** Submitting forms, creating/updating resources

**Structure:**
```dart
class SubmitFormEvent extends BaseEvent {
  final FormModel formData;

  const SubmitFormEvent(this.formData);

  @override
  List<Object?> get props => [formData];
}

// Alternative: Break down fields
class CreateUserEvent extends BaseEvent {
  final UserCreateModel user;
  final FileModel? profileImage;

  const CreateUserEvent({
    required this.user,
    this.profileImage,
  });

  @override
  List<Object?> get props => [user, profileImage];
}
```

**Conventions:**
- Pass model object for grouped data
- Use separate parameters if fields come from different sources
- Model must extend `Equatable` for proper comparison

---

## Pattern 5: Event Handler Registration

**When to use:** In BLoC constructor

**Structure:**
```dart
class FeatureBloc extends BaseBloc {
  FeatureBloc() : super(FeatureFactory()) {
    // Register handlers
    on<InitialEvent>(_onInitial);
    on<FetchDataEvent>(_onFetchData);
    on<UpdateItemEvent>(_onUpdateItem);
    on<DeleteItemEvent>(_onDeleteItem);
  }

  Future<void> _onInitial(
    InitialEvent event,
    Emitter emit,
  ) async {
    // Handler logic
  }

  Future<void> _onFetchData(
    FetchDataEvent event,
    Emitter emit,
  ) async {
    // Handler logic
  }
}
```

**Conventions:**
- Register all handlers in constructor using `on<EventType>(handler)`
- Handler method naming: `_on{EventName}` or `_{eventName}`
- Handler signature: `Future<void> _handlerName(Event event, Emitter emit)`
- Handlers are private methods

---

## Pattern 6: Event Handler with Transformer

**When to use:** Need debouncing or sequential processing

**Structure:**
```dart
import 'package:opticore/opticore.dart';

class SearchBloc extends BaseBloc {
  SearchBloc() : super(SearchFactory()) {
    // Debounce search input
    on<SearchQueryEvent>(
      _onSearchQuery,
      transformer: standardDebounce(),  // 400ms
    );

    // Process updates sequentially
    on<UpdateEvent>(
      _onUpdate,
      transformer: sequential(),
    );
  }

  Future<void> _onSearchQuery(
    SearchQueryEvent event,
    Emitter emit,
  ) async {
    // Search logic - only fires after 400ms pause
  }
}
```

**Available Transformers:**
- `fastDebounce()` - 200ms
- `standardDebounce()` - 400ms (recommended for search)
- `slowDebounce()` - 800ms
- `verySlowDebounce()` - 1500ms
- `debounce(Duration)` - Custom duration
- `sequential()` - One at a time

**Conventions:**
- Use `standardDebounce()` for search/filter inputs
- Use `sequential()` for operations that must not overlap
- Use `fastDebounce()` for real-time validation
- Custom debounce for special cases

---

## Pattern 7: Auto-Fire Initial Events

**When to use:** Events that should fire immediately on BLoC creation

**Structure:**
```dart
class HomeBloc extends BaseBloc {
  HomeBloc() : super(HomeFactory()) {
    // Register handlers
    on<HomeInitialEvent>(_onInitial);
    on<GetHomeDataEvent>(_onGetHomeData);

    // Auto-fire initial events
    add(HomeInitialEvent());
    add(GetHomeDataEvent());
  }
}
```

**Conventions:**
- Call `add()` in constructor after handler registration
- Typically fire initial/fetch events
- Events fire synchronously in order

---

## Pattern 8: Event Naming Conventions

**When to use:** Naming new events

| Action Type | Naming Pattern | Example |
|-------------|---------------|---------|
| Fetch/Get data | `Get{Data}Event` or `Fetch{Data}Event` | `GetUserProfileEvent` |
| Create resource | `Create{Resource}Event` | `CreateOrderEvent` |
| Update resource | `Update{Resource}Event` | `UpdateProfileEvent` |
| Delete resource | `Delete{Resource}Event` | `DeleteItemEvent` |
| Submit form | `Submit{Form}Event` | `SubmitCheckoutEvent` |
| Refresh data | `Refresh{Data}Event` | `RefreshListEvent` |
| Filter/Search | `{Action}Event` | `SearchQueryEvent`, `FilterListEvent` |
| Navigation | `NavigateTo{Screen}Event` | `NavigateToDetailsEvent` |
| Initialization | `{Feature}InitialEvent` | `HomeInitialEvent` |

---

## Pattern 9: Event with Callback

**When to use:** Need to notify screen after operation completes

**Structure:**
```dart
class SubmitFormEvent extends BaseEvent {
  final FormModel data;
  final void Function(bool success)? onComplete;

  const SubmitFormEvent({
    required this.data,
    this.onComplete,
  });

  @override
  List<Object?> get props => [data];  // Don't include callback in props
}

// In BLoC handler
Future<void> _onSubmit(
  SubmitFormEvent event,
  Emitter emit,
) async {
  final response = await _repo.submitForm(event.data);

  if (response.type == ApiResponseType.success) {
    event.onComplete?.call(true);
    emit(SubmitSuccessState());
  } else {
    event.onComplete?.call(false);
    emit(SubmitFailState());
  }
}

// In Screen
postEvent(SubmitFormEvent(
  data: formData,
  onComplete: (success) {
    if (success) {
      context.pop();
    }
  },
));
```

**Conventions:**
- Callback parameter should be nullable
- Don't include callback in `props` (breaks equality)
- Use `?.call()` to invoke safely
- Prefer state emission over callbacks when possible

---

## Pattern 10: Event for Pagination

**When to use:** Loading more data in infinite scroll

**Structure:**
```dart
class LoadMoreEvent extends BaseEvent {
  final int page;
  final int limit;

  const LoadMoreEvent({
    required this.page,
    this.limit = 20,
  });

  @override
  List<Object?> get props => [page, limit];
}

// In BLoC
Future<void> _onLoadMore(
  LoadMoreEvent event,
  Emitter emit,
) async {
  final response = await _repo.getData(
    page: event.page,
    limit: event.limit,
  );

  if (response.type == ApiResponseType.success) {
    items.addAll(response.data?.items ?? []);
    emit(DataLoadedState());
  }
}
```

**Conventions:**
- Include `page` and `limit` parameters
- Provide default `limit` value
- Append to existing list, don't replace

---

## Summary Table

| Pattern | Key Feature | Use Case |
|---------|------------|----------|
| Basic Event | No parameters | Simple actions |
| Event with Parameters | Named parameters | Actions with data |
| Event with ID | Resource identifier | CRUD operations |
| Event with Model | Complex object | Forms, creation |
| Handler Registration | `on<Event>(handler)` | All events |
| Handler with Transformer | `transformer: debounce()` | Search, rate limiting |
| Auto-Fire | `add()` in constructor | Initial data load |
| Event Naming | `{Action}{Resource}Event` | Consistency |
| Event with Callback | Optional callback | Screen notification |
| Pagination Event | `page`, `limit` | Infinite scroll |

---

## Best Practices

✅ **DO:**
- Use descriptive event names
- Make events immutable (`const` constructor)
- Include all event fields in `props`
- Use transformers for search/filter events
- Keep events focused on single responsibility

❌ **DON'T:**
- Don't put callbacks in `props`
- Don't include logic in events
- Don't make events mutable
- Don't use overly generic names like `DataEvent`
- Don't emit states from events (let BLoC handle it)

---

## Quick Reference: Complete Event File

```dart
// Initial event
class FeatureInitialEvent extends BaseEvent {
  const FeatureInitialEvent();

  @override
  List<Object?> get props => [];
}

// Fetch event
class GetDataEvent extends BaseEvent {
  final int? limit;
  final String? filter;

  const GetDataEvent({
    this.limit,
    this.filter,
  });

  @override
  List<Object?> get props => [limit, filter];
}

// Create event
class CreateItemEvent extends BaseEvent {
  final ItemModel item;

  const CreateItemEvent(this.item);

  @override
  List<Object?> get props => [item];
}

// Update event
class UpdateItemEvent extends BaseEvent {
  final int itemId;
  final ItemModel updatedData;

  const UpdateItemEvent({
    required this.itemId,
    required this.updatedData,
  });

  @override
  List<Object?> get props => [itemId, updatedData];
}

// Delete event
class DeleteItemEvent extends BaseEvent {
  final int itemId;

  const DeleteItemEvent(this.itemId);

  @override
  List<Object?> get props => [itemId];
}
```

---

*OptiCore v2.2.0 | Event Patterns*
