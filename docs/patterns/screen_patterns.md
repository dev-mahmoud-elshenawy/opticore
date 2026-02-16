# OptiCore Screen Patterns

Based on analyzing HomeScreen, SettingsScreen, and ServiceCheckoutScreen.

---

## Pattern 1: Screen Class Structure

**When to use:** Every new screen file

**Structure:**
```dart
class FeatureScreen extends StatefulWidget {
  final FeatureBloc bloc;

  const FeatureScreen({super.key, required this.bloc});

  @override
  _FeatureScreenState createState() => _FeatureScreenState(bloc);
}

class _FeatureScreenState
    extends BaseScreen<FeatureBloc, FeatureScreen, dynamic> {
  _FeatureScreenState(super.bloc);

  @override
  Widget buildWidget(BuildContext context, RenderDataState state) {
    return Container(); // Your UI
  }

  @override
  void listenToState(BuildContext context, BaseState state) {}
}
```

**Conventions:**
- Widget takes `bloc` as required parameter
- State class naming: `_FeatureScreenState`
- Extends `BaseScreen<BlocType, WidgetType, dynamic>`
- Pass bloc to super via `super.bloc`

---

## Pattern 2: Screen Configuration

**When to use:** Every screen to configure scaffold and status bar

**Structure:**
```dart
@override
ScaffoldConfig get scaffoldConfig => ScaffoldConfig(
  resizeToAvoidBottomInset: false,
  backgroundColor: AppColors.white,  // or AppColors.lightGray
);

@override
bool? get ignoreSafeArea => true;  // or false

@override
bool get isDarkStatusBarIcon => true;  // dark icons on light bg
```

**Conventions:**
- `scaffoldConfig` - always override for background color
- `ignoreSafeArea` - typically `true` for custom layouts
- `isDarkStatusBarIcon` - `true` for light backgrounds, `false` for dark headers

---

## Pattern 3: Lifecycle Hooks

**When to use:** When screen needs initialization or cleanup

**Structure:**
```dart
// Local state
ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);
final ScrollController scrollController = ScrollController();

@override
void init() {
  super.init();
  // Setup code, fetch initial data
}

@override
void disposeData() {
  isLoading.dispose();
  scrollController.dispose();
  super.disposeData();
}
```

**Conventions:**
- Use `init()` for setup (not `initState`)
- Use `disposeData()` for cleanup (not `dispose`)
- Always call `super.init()` / `super.disposeData()`
- Dispose all ValueNotifiers and Controllers

---

## Pattern 4: State Listener (listenToState)

**When to use:** Every screen to handle bloc state changes

**Structure:**
```dart
@override
void listenToState(BuildContext context, BaseState state) {
  if (state is FeatureSuccessState) {
    MessageSheet.display(
      type: MessageSheetType.success,
      message: state.message,
    );
    // Or navigate
    context.pushNamed(RoutePath.nextScreen);
  } else if (state is FeatureFailedState) {
    MessageSheet.display(
      type: MessageSheetType.error,
      message: state.message,
    );
  }
}
```

**Conventions:**
- Use `if/else if` chain on state types
- Success → `MessageSheetType.success` or navigate
- Failure → `MessageSheetType.error`
- Warning → `MessageSheetType.warning`
- Use `postEvent(SomeEvent())` to trigger bloc actions

---

## Summary Table

| Pattern | Key Marker | Files Using |
|---------|-----------|-------------|
| Screen Structure | `extends BaseScreen<B, W, dynamic>` | All 3 |
| Screen Config | `scaffoldConfig`, `ignoreSafeArea` | All 3 |
| Lifecycle Hooks | `init()`, `disposeData()` | All 3 |
| State Listener | `listenToState` + `MessageSheet` | All 3 |

---

## Quick Reference: Minimal Screen

```dart
class MyScreen extends StatefulWidget {
  final MyBloc bloc;
  const MyScreen({super.key, required this.bloc});
  @override
  _MyScreenState createState() => _MyScreenState(bloc);
}

class _MyScreenState extends BaseScreen<MyBloc, MyScreen, dynamic> {
  _MyScreenState(super.bloc);

  @override
  ScaffoldConfig get scaffoldConfig => ScaffoldConfig(backgroundColor: AppColors.white);

  @override
  bool? get ignoreSafeArea => true;

  @override
  Widget buildWidget(BuildContext context, RenderDataState state) => Container();

  @override
  void listenToState(BuildContext context, BaseState state) {}
}
```
