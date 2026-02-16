# OptiCore Reactive Patterns (v2.2.0+)

Lightweight alternative to BLOC for simple state management scenarios.

---

## When to Use Reactive vs BLOC

| Scenario | Use Reactive | Use BLOC |
|----------|-------------|----------|
| Local component state (counter, toggle) | ✅ | ❌ |
| Single API call with loading/error/data | ✅ | ❌ |
| Form field state | ✅ | ❌ |
| Simple screens | ✅ | ❌ |
| Multi-step flows (checkout, onboarding) | ❌ | ✅ |
| Complex business logic | ❌ | ✅ |
| Event-driven state machines | ❌ | ✅ |
| State requiring middleware/transformers | ❌ | ✅ |

---

## Pattern 1: Simple Counter/Toggle (ReactiveNotifier)

**When to use:** Boolean flags, counters, simple value holders

**Structure:**
```dart
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final counter = ReactiveNotifier<int>(0);
  final isExpanded = ReactiveNotifier<bool>(false);

  @override
  void dispose() {
    counter.dispose();
    isExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Reactive<int>(
          notifier: counter,
          builder: (context, value, child) => Text('Count: $value'),
        ),
        ElevatedButton(
          onPressed: () => counter.update((current) => current + 1),
          child: Text('Increment'),
        ),
      ],
    );
  }
}
```

**Conventions:**
- Create notifiers as final fields in State class
- Dispose in `dispose()` method
- Use `.update()` for functional updates
- Use `.value =` for direct assignment
- Use `.silent =` when batching multiple updates

---

## Pattern 2: API Call with Loading/Error/Data (AsyncReactiveNotifier)

**When to use:** Single API calls, async operations with states

**Structure:**
```dart
class ProfileWidget extends StatefulWidget {
  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final userNotifier = AsyncReactiveNotifier<User>();
  late final UserRepo _repo;

  @override
  void initState() {
    super.initState();
    _repo = UserRepo();
    _loadUser();
  }

  Future<void> _loadUser() async {
    await userNotifier.execute(() => _repo.fetchUser());
  }

  @override
  void dispose() {
    userNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Reactive.async<User>(
      notifier: userNotifier,
      loading: (context) => CircularProgressIndicator(),
      error: (context, error, stackTrace) => ErrorWidget(error: error),
      data: (context, user) => Column(
        children: [
          Text(user.name),
          Text(user.email),
        ],
      ),
    );
  }
}
```

**Conventions:**
- Use `AsyncReactiveNotifier<T>` for async operations
- Call `.execute(() => asyncFunction())` to auto-manage states
- Use `Reactive.async()` widget to handle all states
- Repository calls go in separate method (`_loadUser()`)
- Loading/error/data builders are required

---

## Pattern 3: Property-Based Rebuilds (Reactive.select)

**When to use:** Large models where only one field matters for UI

**Structure:**
```dart
class UserNameWidget extends StatelessWidget {
  final ReactiveNotifier<User> userNotifier;

  const UserNameWidget({required this.userNotifier});

  @override
  Widget build(BuildContext context) {
    return Reactive.select<User, String>(
      notifier: userNotifier,
      selector: (user) => user.name,  // Only rebuild when name changes
      builder: (context, name, child) => Text(name),
    );
  }
}
```

**Conventions:**
- Use when model has many fields but widget only needs one
- Selector must return primitive or comparable type
- Prevents unnecessary rebuilds when other fields change

---

## Pattern 4: Multiple Notifiers (Reactive.multi)

**When to use:** Widget depends on multiple independent notifiers

**Structure:**
```dart
class FullNameWidget extends StatelessWidget {
  final ReactiveNotifier<String> firstName;
  final ReactiveNotifier<String> lastName;

  const FullNameWidget({
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return Reactive.multi(
      notifiers: [firstName, lastName],
      builder: (context, child) => Text('${firstName.value} ${lastName.value}'),
      buildWhen: () => true,  // Custom rebuild logic
    );
  }
}
```

**Conventions:**
- Pass all notifiers in list
- Access values via `.value` in builder
- Use `buildWhen` for custom rebuild conditions
- Rebuilds when ANY notifier changes

---

## Pattern 5: Shared State (ReactiveProvider)

**When to use:** State needs to be accessed by multiple widgets in tree

**Structure:**
```dart
// 1. Define at root
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ReactiveProvider<ReactiveNotifier<ThemeMode>>(
      create: () => ReactiveNotifier<ThemeMode>(ThemeMode.light),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

// 2. Access in descendants
class ThemeToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.reactive<ReactiveNotifier<ThemeMode>>();

    return Reactive<ThemeMode>(
      notifier: themeNotifier,
      builder: (context, mode, child) => Switch(
        value: mode == ThemeMode.dark,
        onChanged: (isDark) => themeNotifier.value =
          isDark ? ThemeMode.dark : ThemeMode.light,
      ),
    );
  }
}
```

**Conventions:**
- Create provider at root or feature entry point
- Use `context.reactive<T>()` to access (throws if not found)
- Use `context.maybeReactive<T>()` for optional access (returns null)
- Provider manages lifecycle automatically

---

## Pattern 6: Manual State Control (AsyncReactiveNotifier)

**When to use:** Need fine-grained control over loading/error states

**Structure:**
```dart
class ManualControlWidget extends StatefulWidget {
  @override
  State<ManualControlWidget> createState() => _ManualControlWidgetState();
}

class _ManualControlWidgetState extends State<ManualControlWidget> {
  final dataNotifier = AsyncReactiveNotifier<Data>();
  late final DataRepo _repo;

  @override
  void initState() {
    super.initState();
    _repo = DataRepo();
  }

  Future<void> _loadData() async {
    try {
      dataNotifier.setLoading();
      final result = await _repo.fetchData();
      dataNotifier.setData(result);
    } catch (error, stackTrace) {
      dataNotifier.setError(error, stackTrace);
    }
  }

  Future<void> _retry() async {
    dataNotifier.reset();  // Back to initial
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Reactive.async<Data>(
      notifier: dataNotifier,
      initial: (context) => ElevatedButton(
        onPressed: _loadData,
        child: Text('Load Data'),
      ),
      loading: (context) => CircularProgressIndicator(),
      error: (context, error, stack) => Column(
        children: [
          Text('Error: $error'),
          ElevatedButton(
            onPressed: _retry,
            child: Text('Retry'),
          ),
        ],
      ),
      data: (context, data) => DataView(data: data),
    );
  }

  @override
  void dispose() {
    dataNotifier.dispose();
    super.dispose();
  }
}
```

**Conventions:**
- Use `.setLoading()`, `.setData()`, `.setError()` for manual control
- Use `.reset()` to go back to initial state
- Wrap in try-catch for error handling
- Useful when `execute()` is too automatic

---

## Pattern 7: Conditional Rebuilds (buildWhen)

**When to use:** Want to control when widget rebuilds

**Structure:**
```dart
Reactive<int>(
  notifier: counter,
  buildWhen: (prev, next) => next % 2 == 0,  // Only rebuild on even numbers
  builder: (context, value, child) => Text('Even: $value'),
)
```

**Conventions:**
- Returns `bool` - `true` to rebuild, `false` to skip
- Receives previous and next values
- Use for performance optimization

---

## Pattern 8: Side Effects (listener)

**When to use:** Need to perform actions without rebuilding

**Structure:**
```dart
Reactive<int>(
  notifier: counter,
  listener: (context, value) {
    if (value >= 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reached 10!')),
      );
    }
  },
  builder: (context, value, child) => Text('$value'),
)
```

**Conventions:**
- Listener fires on EVERY change (unless `buildWhen` blocks it)
- Use for navigation, toasts, dialogs
- Does not cause rebuild

---

## Pattern 9: Static Child Caching

**When to use:** Part of widget tree doesn't depend on notifier value

**Structure:**
```dart
Reactive<User>(
  notifier: userNotifier,
  child: const Icon(Icons.person),  // Built once, never rebuilds
  builder: (context, user, child) => Row(
    children: [
      child!,  // Cached icon
      Text(user.name),  // Rebuilds on change
    ],
  ),
)
```

**Conventions:**
- Pass static widgets via `child` parameter
- Access in builder via `child!`
- Improves performance for complex static widgets

---

## Pattern 10: Update Data if Present

**When to use:** Modifying data in `AsyncData` state

**Structure:**
```dart
final userNotifier = AsyncReactiveNotifier<User>();

// After data is loaded...
userNotifier.updateData((user) => user.copyWith(name: 'New Name'));

// Or check first
if (userNotifier.hasData) {
  final currentUser = userNotifier.requireValue;
  userNotifier.setData(currentUser.copyWith(name: 'New Name'));
}
```

**Conventions:**
- Use `.updateData()` for functional updates
- Use `.requireValue` to get data (throws if not in data state)
- Use `.valueOrNull` for safe access
- Use `.hasData`, `.isLoading`, `.hasError` for state checks

---

## Summary Table

| Pattern | Notifier Type | Widget Type | Use Case |
|---------|--------------|-------------|----------|
| Counter/Toggle | `ReactiveNotifier<T>` | `Reactive<T>` | Simple values |
| API Call | `AsyncReactiveNotifier<T>` | `Reactive.async<T>` | Async operations |
| Property Select | `ReactiveNotifier<T>` | `Reactive.select<T, R>` | Performance optimization |
| Multiple Notifiers | Multiple `ReactiveNotifier` | `Reactive.multi` | Independent states |
| Shared State | Any notifier | `ReactiveProvider<T>` | Cross-widget state |
| Manual Control | `AsyncReactiveNotifier<T>` | Manual `.set*()` | Fine-grained control |
| Conditional Rebuild | Any notifier | `buildWhen` | Skip unnecessary rebuilds |
| Side Effects | Any notifier | `listener` | Actions without rebuild |
| Static Caching | Any notifier | `child` parameter | Performance |
| Data Updates | `AsyncReactiveNotifier<T>` | `.updateData()` | Modify loaded data |

---

## Best Practices

✅ **DO:**
- Dispose notifiers in `dispose()` method
- Use `AsyncReactiveNotifier` for API calls
- Use `Reactive.select` to avoid unnecessary rebuilds
- Use `child` parameter for static widgets
- Use `buildWhen` for complex rebuild logic

❌ **DON'T:**
- Don't use reactive for complex multi-step flows (use BLOC)
- Don't forget to dispose notifiers
- Don't use `.value` inside `builder` (use parameter instead)
- Don't use reactive when you need event transformers
- Don't create notifiers inside build method

---

*OptiCore v2.2.0 | Reactive State Management*
