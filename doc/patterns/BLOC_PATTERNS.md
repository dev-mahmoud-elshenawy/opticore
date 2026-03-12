# OptiCore BLoC Patterns

Based on analyzing HomeBloc, ServicesBloc, and ExploreBloc.

---

## Pattern 1: BLoC Initialization

**When to use:** Every new BLoC file

**Structure:**
```dart
class FeatureBloc extends BaseBloc {
  final SomeRepo _repo;

  // State fields here...

  FeatureBloc(this._repo)
      : super(
          FeatureFactory(),
          // Optional: initialState: FeatureInitialState(),
        ) {
    // 1. Register handlers
    on<FeatureInitialEvent>(_onInitial);
    on<GetDataEvent>(_onGetData);

    // 2. Auto-fire initial events
    add(FeatureInitialEvent());
    add(GetDataEvent());
  }

  @override
  void onDispose() {
    // Dispose ValueNotifiers
    super.onDispose();
  }
}
```

**Conventions:**
- Repos are private (`_repo`)
- Factory passed to `super()` (e.g., `HomeFactory()`)
- Events fired immediately in constructor via `add()`

---

## Pattern 2: Skeleton Data (Shimmer Loading)

**When to use:** When UI needs placeholder data while loading

**Structure:**
```dart
List<ItemData> items = List.generate(
  3,
  (index) => ItemData(name: 'xxxxxxxxxx'),
);

// Or inline:
List<ServiceData> services = [
  ServiceData(name: 'xxxxxxxxxx'),
  ServiceData(name: 'xxxxxxxxxx'),
  ServiceData(name: 'xxxxxxxxxx'),
];
```

**Conventions:**
- Use `'xxxxxxxxxx'` as placeholder text
- Pre-populate with 3 items typically
- Data is replaced entirely on success (not mutated)

---

## Pattern 3: Loading State Flags

**When to use:** To control loading indicators per data section

**Structure (ValueNotifier approach - preferred):**
```dart
// Declaration
ValueNotifier<bool> showLoadingItems = ValueNotifier(true);

// In handler
showLoadingItems.value = true;
// ... fetch ...
if (response.type == ApiResponseType.success) {
  showLoadingItems.value = false;
}

// In onDispose
showLoadingItems.dispose();
```

**Structure (Simple bool - simpler cases):**
```dart
bool showLoadingItems = true;

// In handler - must emit state after changing
showLoadingItems = false;
emit(ItemsLoadedState());
```

**Conventions:**
- Named `showLoading{DataName}`
- Start as `true`
- Only set `false` on success (stays true on failure)

---

## Pattern 4: Data Fetch Handler

**When to use:** Every API call event handler

**Structure:**
```dart
Future<void> _onGetData(
  GetDataEvent event,
  Emitter emit,
) async {
  // 1. Set loading
  showLoadingData.value = true;

  // 2. Call repo
  final ApiResponse<DataModel?> response = await _repo.getData();

  // 3. Handle success
  if (response.type == ApiResponseType.success) {
    data = response.data?.items ?? [];
    showLoadingData.value = false;
  }

  // 4. Emit state (optional - varies by need)
  emit(DataLoadedState());
}
```

**Conventions:**
- Handler named `_onEventName` or `_eventName`
- Always check `ApiResponseType.success`
- Use `??` for null fallback (empty list or default model)
- Loading flag only set false inside success block

---

## Summary Table

| Pattern | Key Marker | Files Using |
|---------|-----------|-------------|
| BLoC Init | `on<>` + `add()` in constructor | All 3 |
| Skeleton Data | `'xxxxxxxxxx'` placeholders | Home, Services |
| Loading Flags | `showLoading{X}` | All 3 |
| Fetch Handler | `ApiResponseType.success` check | All 3 |
