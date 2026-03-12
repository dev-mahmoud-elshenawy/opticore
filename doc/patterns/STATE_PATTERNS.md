# OptiCore State Patterns

Based on analyzing ServiceCheckoutState, HomeState, and VerificationState.

---

## Pattern 1: Initial State

**When to use:** Every state file needs one as the starting state

**Structure:**
```dart
class FeatureInitialState extends RenderDataState {
  FeatureInitialState() : super(null);
}
```

**Conventions:**
- Named `{Feature}InitialState`
- Always extends `RenderDataState`
- Always passes `null` to super
- No parameters

---

## Pattern 2: Success/Fail State Pair

**When to use:** For API call outcomes, user actions, any operation with success/failure

**Structure:**
```dart
class FeatureSuccessState extends NonRenderState {
  final String? message;
  FeatureSuccessState({this.message});
}

class FeatureFailState extends NonRenderState {
  final String? message;
  FeatureFailState({this.message});
}
```

**Conventions:**
- Always extends `NonRenderState`
- Naming: `{Action}SuccessState` / `{Action}FailState`
- Usually has `message` parameter (nullable)
- Can have additional data (e.g., `token`, `data`)
- Used in `listenToState` for MessageSheet feedback

---

## Pattern 3: Loading/Loaded State Pair

**When to use:** When UI needs to show loading skeleton then loaded content

**Structure:**
```dart
class FeatureLoadingState extends RenderDataState {
  FeatureLoadingState() : super(null);
}

class FeatureLoadedState extends RenderDataState {
  FeatureLoadedState() : super(null);
}
```

**Conventions:**
- Always extends `RenderDataState`
- Naming: `{Data}LoadingState` / `{Data}LoadedState`
- Always passes `null` to super
- No parameters typically
- Used in `buildWidget` with `state is LoadingState`

---

## Pattern 4: Base Class Selection

**When to use:** Deciding which base class for your state

| Base Class | Purpose | Triggers |
|------------|---------|----------|
| `RenderDataState` | UI rebuilds needed | `buildWidget` |
| `NonRenderState` | Side effects only | `listenToState` |

**Structure:**
```dart
// UI state → RenderDataState
class DataLoadingState extends RenderDataState {
  DataLoadingState() : super(null);
}

// Action feedback → NonRenderState
class SubmitSuccessState extends NonRenderState {
  final String? message;
  SubmitSuccessState(this.message);
}
```

**Conventions:**
- Initial/Loading/Loaded → `RenderDataState`
- Success/Fail/Error → `NonRenderState`

---

## Summary Table

| Pattern | Base Class | Naming | Has Params |
|---------|-----------|--------|------------|
| Initial | `RenderDataState` | `{Feature}InitialState` | No |
| Loading/Loaded | `RenderDataState` | `{Data}Loading/LoadedState` | No |
| Success/Fail | `NonRenderState` | `{Action}Success/FailState` | Yes (message) |

---

## Quick Reference: Complete State File

```dart
// Initial
class MyFeatureInitialState extends RenderDataState {
  MyFeatureInitialState() : super(null);
}

// Loading/Loaded pair
class DataLoadingState extends RenderDataState {
  DataLoadingState() : super(null);
}

class DataLoadedState extends RenderDataState {
  DataLoadedState() : super(null);
}

// Success/Fail pair
class SubmitSuccessState extends NonRenderState {
  final String? message;
  SubmitSuccessState({this.message});
}

class SubmitFailState extends NonRenderState {
  final String? message;
  SubmitFailState({this.message});
}
```
