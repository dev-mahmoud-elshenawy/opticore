# OptiCore

> A lightweight, BLoC-based micro-framework for accelerating Flutter application development

---

## Table of Contents

1. [Introduction](#introduction)
2. [Philosophy & Principles](#philosophy--principles)
3. [Architecture Overview](#architecture-overview)
4. [Core Concepts](#core-concepts)
5. [Module Implementation Guide](#module-implementation-guide)
6. [Configuration System](#configuration-system)
7. [Services Layer](#services-layer)
8. [Extensions & Utilities](#extensions--utilities)
9. [Reusable UI Components](#reusable-ui-components)
10. [Quick Reference](#quick-reference)

---

## Introduction

OptiCore provides a complete architectural foundation for Flutter applications, combining event-driven state management, network abstraction, reactive programming, and reusable UI components.

The framework eliminates repetitive boilerplate while enforcing clean architectural patterns, allowing developers to focus on business logic rather than infrastructure concerns.

### Design Goals

| Goal | Implementation |
|------|----------------|
| Reduce Boilerplate | Pre-built base classes with sensible defaults |
| Enforce Architecture | Abstract contracts that guide implementation |
| Handle Errors Uniformly | Centralized error classification and routing |
| Enable Rapid Development | 70+ extensions, reusable widgets, helper utilities |
| Support Scalability | Layered architecture that grows with complexity |

---

## Philosophy & Principles

### Core Principles

**Convention Over Configuration**
Sensible defaults reduce setup time. Override only when necessary.

**Separation of Concerns**
Each layer has a single responsibility. UI knows nothing about network calls. BLoCs handle state transitions. Repositories manage data access.

**Type Safety First**
Generic constraints throughout the framework catch errors at compile-time rather than runtime.

**Fail Gracefully**
Every network call, every state transition, every user interaction has a defined error path. No unhandled exceptions.

**Minimal Footprint**
Include only what is essential. The framework provides building blocks, not a monolithic solution.

### Architectural Principles

| Principle | Implementation |
|-----------|----------------|
| Separation of Concerns | BLoCs → business logic, Repos → data access, Widgets → UI |
| Inversion of Control | Dependencies injected via providers and factories |
| Unidirectional Data Flow | Event → BLoC → State → Widget |
| Async-First | Built-in AsyncValue and AsyncReactiveNotifier |
| Error Abstraction | Centralized classification without scattered try-catch |
| Configuration Over Code | Extensive config objects reduce boilerplate |

---

## Architecture Overview

### Layered Architecture

OptiCore implements a strict layered architecture where each layer has defined responsibilities and communication patterns.

```
┌─────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                   │
│   ┌─────────────┐     ┌─────────────┐     ┌─────────┐  │
│   │  BaseScreen │────▶│ StateBuilder│────▶│ Widgets │  │
│   └─────────────┘     └─────────────┘     └─────────┘  │
│          │ Events                                       │
├─────────────────────────────────────────────────────────┤
│                   STATE MANAGEMENT LAYER                │
│   ┌─────────────┐     ┌─────────────┐     ┌─────────┐  │
│   │  BaseBloc   │────▶│  BaseState  │────▶│ Factory │  │
│   └─────────────┘     └─────────────┘     └─────────┘  │
│          │ Requests                                     │
├─────────────────────────────────────────────────────────┤
│                    REPOSITORY LAYER                     │
│   ┌─────────────┐     ┌─────────────────────────────┐  │
│   │  BaseRepo   │────▶│ Domain-Specific Repositories │  │
│   └─────────────┘     └─────────────────────────────┘  │
│          │ API Calls                                    │
├─────────────────────────────────────────────────────────┤
│                     SERVICES LAYER                      │
│   ┌───────────────┐   ┌─────────────┐   ┌───────────┐  │
│   │ NetworkHelper │   │ ApiResponse │   │Interceptors│  │
│   └───────────────┘   └─────────────┘   └───────────┘  │
├─────────────────────────────────────────────────────────┤
│                  INFRASTRUCTURE LAYER                   │
│   ┌────────┐   ┌────────┐   ┌────────┐   ┌──────────┐  │
│   │  Dio   │   │ Logger │   │ Toast  │   │ Observer │  │
│   └────────┘   └────────┘   └────────┘   └──────────┘  │
└─────────────────────────────────────────────────────────┘
```

### Data Flow

**Request Flow (Top-Down)**

1. User interaction triggers an event in the presentation layer
2. BaseScreen dispatches event to the associated BLoC
3. BLoC processes event and calls repository methods
4. Repository uses NetworkHelper to make API requests
5. NetworkHelper returns typed ApiResponse

**Response Flow (Bottom-Up)**

1. ApiResponse classifies the response (success, error, timeout, etc.)
2. BLoC transforms ApiResponse into appropriate state
3. StateBuilder detects state change
4. BaseScreen renders widget corresponding to state type

### Reactive Alternative Flow

For simpler state requirements, the reactive system provides a lighter alternative:

```
┌──────────────────────────────────────────────────────┐
│                    REACTIVE FLOW                      │
│                                                       │
│   ReactiveNotifier ──▶ Reactive Widget ──▶ UI Update │
│         │                                             │
│         │ (Optional)                                  │
│         ▼                                             │
│   AsyncReactiveNotifier ──▶ Loading/Error/Data       │
│                                                       │
│   ReactiveProvider ──▶ Shared State via Context      │
└──────────────────────────────────────────────────────┘
```

### Module Organization

```
opticore/
├── config/               # Application configuration
│   ├── infrastructure/   # Core setup and initialization
│   └── settings/         # Feature-specific configurations
│
├── core/                 # Framework abstractions
│   └── base/
│       ├── bloc/         # State management
│       ├── event/        # Event definitions
│       ├── state/        # State hierarchy
│       ├── factory/      # State factories
│       ├── repo/         # Repository contracts
│       ├── screen/       # Screen management
│       ├── view/         # View abstractions
│       ├── observer/     # BLoC observation
│       ├── transformer/  # Event transformation
│       ├── reactive/     # Reactive state system
│       └── widget/       # Base UI widgets
│
├── services/             # External service integration
│   └── network/
│       ├── infrastructure/   # HTTP client and responses
│       └── interceptor/      # Request/response interceptors
│
├── reusable/             # UI component library
│   ├── structure/        # Layout components
│   ├── button/           # Button variants
│   ├── bottom_sheet/     # Sheet components
│   ├── fallback_screen/  # Error screens
│   ├── item/             # UI elements
│   ├── mixin/            # Behavior mixins
│   └── paint/            # Custom painters
│
├── utils/                # Utility layer
│   ├── general/          # Core utilities
│   ├── helper/           # Helper classes
│   ├── logger/           # Logging system
│   └── ui/               # UI utilities
│
├── enum/                 # Enumerations
│
└── extensions/           # Dart extensions (70+)
```

### Design Patterns

| Pattern | Purpose |
|---------|---------|
| BLoC | Centralized state management with event-driven architecture |
| Factory | Dynamic state creation decoupled from business logic |
| Repository | Network operations abstraction layer |
| Observer | Global lifecycle tracking for BLoCs and routes |
| Builder | Declarative UI construction with state conditions |
| Reactive/Provider | Alternative lightweight state management |
| Template Method | BaseScreen with customizable lifecycle hooks |
| Strategy | Configurable event transformers (debounce, sequential) |

---

## Core Concepts

### State Hierarchy

OptiCore introduces a two-branch state hierarchy that distinguishes between UI-triggering and background states.

```
                    BaseState
                        │
          ┌─────────────┴─────────────┐
          │                           │
     RenderState               NonRenderState
          │                           │
    ┌─────┴─────┐              ┌──────┴──────┐
    │           │              │             │
Loading   RenderData      Loading       EndLoading
 Error    Initial         Error
```

**RenderState** — States that trigger UI rebuilds. When a RenderState is emitted, the StateBuilder rebuilds the widget tree.

- `LoadingStateRender` — Display loading indicators
- `LoadAnimationState` — Animated loading with Lottie
- `RenderDataState<T>` — Success state carrying typed data
- `ErrorStateRender` — Error display with optional retry
- `InitialState` — Starting state before any action

**NonRenderState** — States for background operations that should not rebuild the UI.

- `LoadingStateNonRender` — Background loading without UI change
- `EndLoadingStateNonRender` — Background operation complete
- `ErrorStateNonRender` — Background error for silent handling

This separation enables precise control over when the UI rebuilds versus when only listeners fire.

### State Management Layer

**BaseBloc** — Abstract foundation extending flutter_bloc. Handles API response processing, error classification, navigation for error scenarios, and lifecycle management.

**BaseFactory** — Factory pattern implementation for dynamic state creation. Maps API responses to application states, allowing customizable state behavior.

**BaseEvent** — Marker interface for type-safe event dispatching. All events extend BaseEvent, providing equality, immutability, and type safety through Equatable implementation.

### Reactive State Management

For simpler state requirements, the reactive system provides a lighter alternative to BLoC.

**ReactiveNotifier** — Simple value holder with change notification. Supports silent updates and manual refresh.

**AsyncReactiveNotifier** — Manages async operation states (initial, loading, data, error) with methods for executing operations and updating state.

**Reactive Widget** — Multiple construction patterns for single notifiers, multiple notifiers, property-based selective rebuilds, and async state handling.

### Screen Lifecycle

BaseScreen manages the complete lifecycle of a screen:

```
┌──────────────────────────────────────────────────┐
│                 SCREEN LIFECYCLE                  │
├──────────────────────────────────────────────────┤
│                                                  │
│   initState() ──▶ init() ──▶ Build              │
│                                                  │
│   ┌──────────────────────────────────────────┐  │
│   │              BUILD PHASE                  │  │
│   │                                          │  │
│   │   State Check                            │  │
│   │       │                                  │  │
│   │       ├── Loading? ──▶ loadingWidget()   │  │
│   │       │                                  │  │
│   │       ├── Error? ──▶ errorWidget()       │  │
│   │       │                                  │  │
│   │       ├── Initial? ──▶ initialWidget()   │  │
│   │       │                                  │  │
│   │       └── Data? ──▶ buildWidget()        │  │
│   │                                          │  │
│   └──────────────────────────────────────────┘  │
│                                                  │
│   dispose() ──▶ disposeData()                   │
│                                                  │
└──────────────────────────────────────────────────┘
```

**Override Points:**

- `init()` — Initialization logic
- `disposeData()` — Cleanup logic
- `changeDependencies()` — Dependency change handling
- `updateWidget()` — Widget update handling

**Route Awareness:** Screens automatically track route changes through RouteObserver integration, enabling callbacks when routes become visible or hidden (didPush, didPopNext, didPushNext, didPop).

### UI Components

**ContentBuilder** — Wrapper around BlocConsumer that separates:

- `buildWhen` — Only rebuilds for RenderState types
- `listenWhen` — Only fires listeners for NonRenderState types

**StateBuilder** — Enables selective component rebuilding using BlocSelector. Only rebuilds when specific ComponentState is emitted.

### Event Transformers

Control event processing behavior:

- **Debounce** — Delays processing (fast: 200ms, standard: 400ms, slow: 800ms, very slow: 1500ms)
- **Sequential** — Processes events one at a time in order

### Error Classification

OptiCore classifies all errors into distinct categories for consistent handling:

| Error Type | Source | Default Handling |
|------------|--------|------------------|
| Success | 2xx responses | Emit RenderDataState |
| API Error | 4xx responses (except 401) | Emit ErrorStateRender with message |
| Server Error | 5xx responses | Navigate to error screen or emit error |
| Network Error | Connection failures | Navigate to NoInternetScreen |
| Parsing Error | JSON decode failures | Log and emit error state |
| Unauthorized | 401 response | Trigger authentication flow |
| No Internet | Connectivity check fails | Navigate to NoInternetScreen |

---

## Module Implementation Guide

This section explains how to implement a feature module in OptiCore using the standard folder structure.

### Module Structure

```
example_module/
├── bloc/
│   └── example_module_bloc.dart
├── event/
│   └── example_module_event.dart
├── factory/
│   └── example_module_state_factory.dart
├── import/
│   └── example_module_import.dart
├── screen/
│   └── example_module_screen.dart
└── state/
    └── example_module_state.dart
```

### Folder Responsibilities

#### `bloc/` — Business Logic Component

The BLoC is the brain of the module. It:

- **Extends `BaseBloc`** to inherit centralized API response handling, error management, and navigation utilities
- **Receives events** dispatched from the UI layer
- **Processes business logic** such as API calls, data transformations, and validations
- **Emits states** that the screen listens to for rendering updates
- **Handles all error scenarios** automatically via inherited methods (`handleApiResponse`, `handleNetworkException`, etc.)

The `BaseBloc` provides built-in handling for:
- Success responses (via `stateFactory`)
- API errors and unauthorized access
- Network and parsing errors
- No internet connection (auto-navigates to retry screen)
- Server maintenance scenarios

#### `event/` — Event Definitions

Events represent user actions or system triggers. They:

- **Extend `BaseEvent`** to integrate with the BLoC architecture
- **Carry data** needed for the BLoC to process (e.g., IDs, form data, filters)
- **Trigger state transitions** when dispatched via `bloc.add(event)`
- **Decouple UI from logic** by defining clear contracts for what actions are possible

Examples: `FetchDataEvent`, `SubmitFormEvent`, `RefreshEvent`, `DeleteItemEvent`

#### `factory/` — State Factory

The factory converts API response data into appropriate states. It:

- **Extends `BaseFactory`** and implements `getState<M>(M data)`
- **Maps response models** to specific `RenderDataState` objects
- **Centralizes state creation logic** keeping the BLoC clean
- **Returns fallback states** when data doesn't match expected types

The factory is injected into the BLoC constructor and called automatically when an API response succeeds.

#### `screen/` — UI Screen

The screen handles all UI rendering and user interaction. It:

- **Extends `BaseScreen<BlocType, WidgetType, DataType>`** for full framework integration
- **Implements `buildWidget()`** to render UI when data is available
- **Dispatches events** to the BLoC via `postEvent(event)` or `bloc.add(event)`
- **Optionally overrides** widget methods for loading, error, and initial states
- **Configures scaffold** via `scaffoldConfig` and `appBarData` getters
- **Listens to non-render states** via `listenToState()` for toasts, navigation, etc.

Built-in features: automatic safe area handling, loading indicator management, toast notifications, keyboard dismissal, route-aware lifecycle callbacks.

#### `state/` — State Definitions

States represent the current condition of the module's data. They:

- **Extend `RenderState`** for states that trigger UI rebuilds (loading, data, error screens)
- **Extend `NonRenderState`** for states that don't rebuild UI (background loading, toasts)
- **Wrap data models** in `RenderDataState<T>` for type-safe UI rendering
- **Categorize errors** as render (full-screen) or non-render (toast/snackbar)

#### `import/` — Barrel File

The import file consolidates all module dependencies. It:

- **Uses Dart's `part`/`part of` directives** to organize related files
- **Exports all public APIs** of the module in a single import
- **Reduces import clutter** in consuming code
- **Mirrors the pattern** used by the core framework (`base_import.dart`)

### Module Data Flow

```
┌─────────────────────────────────────────────────────────────┐
│                        USER INTERFACE                        │
│                    (example_module_screen)                   │
│  ┌─────────────────────────────────────────────────────┐    │
│  │  postEvent(FetchDataEvent) ──────────────────────┐  │    │
│  │                                                   │  │    │
│  │  buildWidget(context, state) ◄────────────────┐  │  │    │
│  └─────────────────────────────────────────────┼──┼──┘    │
└───────────────────────────────────────────────┼──┼────────┘
                                                │  │
                    ┌───────────────────────────┘  │
                    │                              │
                    ▼                              │
┌─────────────────────────────────────────────────┼───────────┐
│                          BLOC                    │           │
│                  (example_module_bloc)           │           │
│  ┌─────────────────────────────────────────────┼─────────┐  │
│  │  on<FetchDataEvent>((event, emit) async {   │         │  │
│  │    emit(LoadingStateRender());              │         │  │
│  │    final response = await repo.fetchData(); │         │  │
│  │    emit(handleApiResponse(response));  ─────┘         │  │
│  │  });                                                  │  │
│  └───────────────────────────────────────────────────────┘  │
│                              │                               │
│                              ▼                               │
│  ┌───────────────────────────────────────────────────────┐  │
│  │              STATE FACTORY                             │  │
│  │         (example_module_state_factory)                 │  │
│  │  getState(data) → RenderDataState<ExampleModel>(data) │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                       REPOSITORY                             │
│              (handles API calls, caching)                    │
└─────────────────────────────────────────────────────────────┘
```

### Recommended Patterns

#### State Emission Guidelines

| Scenario | Emit State |
|----------|------------|
| Start loading (full screen) | `LoadingStateRender()` |
| Start loading (overlay) | `LoadingStateNonRender()` |
| End overlay loading | `EndLoadingStateNonRender()` |
| Data loaded | `RenderDataState<T>(data)` |
| Error (show on screen) | `ErrorStateRender(errorMessage: msg)` |
| Error (show toast) | `ErrorStateNonRender(errorMessage: msg)` |

#### Event Design Best Practices

- **Single responsibility** — One event per user action
- **Carry required data** — Include all parameters needed by the BLoC
- **Descriptive naming** — `FetchUserProfileEvent`, not `GetDataEvent`
- **Immutable** — Events should be immutable data carriers

#### Screen Implementation Tips

- Override `buildWidget()` for the main UI
- Override `loadingWidget()` for custom loading indicators
- Override `errorWidget()` for custom error displays
- Use `listenToState()` for side effects (navigation, toasts)
- Set `disposeBloc => false` if sharing BLoC across screens
- Configure `appBarData` or `customAppBar` for app bar customization

#### Factory Design

- Handle different data types with type checking
- Return `DefaultState()` for unrecognized data
- Keep mapping logic simple and testable

### Usage Example: User Profile Module

A module that displays and manages a user's profile information.

**Events:**
- `LoadProfileEvent` — Triggered when the screen initializes to fetch profile data
- `UpdateProfileEvent` — Triggered when the user submits profile edits with updated fields
- `UploadAvatarEvent` — Triggered when the user selects a new profile image

**States:**
- `ProfileLoadedState` — Contains the user profile model for display
- `ProfileUpdatingState` — Non-render state showing an overlay while saving
- `AvatarUploadProgressState` — Contains upload percentage for progress indicator

**Flow:**
1. Screen initializes and dispatches `LoadProfileEvent`
2. BLoC emits `LoadingStateRender`, calls profile repository
3. On success, factory converts response to `ProfileLoadedState`
4. Screen's `buildWidget()` renders profile form with user data
5. User edits fields and taps save
6. Screen dispatches `UpdateProfileEvent` with form data
7. BLoC emits `LoadingStateNonRender` (overlay), calls update API
8. On success, emits `EndLoadingStateNonRender` and new `ProfileLoadedState`
9. Screen shows success toast via `listenToState()`

**Error Handling** (automatic via BaseBloc):
- Network error → Toast notification
- Unauthorized → Redirects to login (via `UnAuthenticatedConfig`)
- Server error → Navigates to maintenance screen with retry
- No internet → Navigates to no-internet screen with retry

---

## Configuration System

The configuration system follows a **two-tier architecture** that separates structural app settings from behavioral/dynamic settings.

### Configuration Hierarchy

```
┌─────────────────────────────────────────────────────┐
│                     CoreSetup                       │
│              (Lifecycle Entry Point)                │
├─────────────────────────────────────────────────────┤
│                                                     │
│  ┌─────────────────────────────────────────────┐   │
│  │         AppConfig (Immutable)               │   │
│  │  - theme, locale, routes                    │   │
│  │  - navigatorObservers                       │   │
│  │  - performance overlays                     │   │
│  └─────────────────────────────────────────────┘   │
│                        │                            │
│  ┌─────────────────────▼─────────────────────┐     │
│  │  prepConfig() Callback (Optional)         │     │
│  │  - Firebase initialization                │     │
│  │  - Environment-specific setup             │     │
│  │  - Global config instantiation            │     │
│  └───────────────────────────────────────────┘     │
│                        │                            │
│  ┌─────────────────────▼─────────────────────┐     │
│  │  Settings Configs (Dynamic)               │     │
│  │                                           │     │
│  │  - ApiResponseConfig                      │     │
│  │  - NetworkConfig                          │     │
│  │  - MaintenanceConfig                      │     │
│  │  - NoInternetConfig                       │     │
│  │  - NotFoundConfig                         │     │
│  │  - UnAuthenticatedConfig                  │     │
│  └───────────────────────────────────────────┘     │
│                        │                            │
│  ┌─────────────────────▼─────────────────────┐     │
│  │  Runtime Consumers                        │     │
│  │                                           │     │
│  │  NetworkHelper ─── NetworkConfig          │     │
│  │  ApiResponse ───── ApiResponseConfig      │     │
│  │  BaseBloc ──────── Error screen configs   │     │
│  │  UI Screens ────── Fallback configs       │     │
│  └───────────────────────────────────────────┘     │
│                                                     │
└─────────────────────────────────────────────────────┘
```

### Tier 1 — AppConfig (Structural, Immutable)

Global application settings set once at app startup:

- Application title and theme
- Localization and locale
- Initial route and route generation
- Navigator observers
- Scroll behavior and performance overlays

### Tier 2 — Settings Configs (Behavioral, Dynamic)

Runtime-configurable settings:

| Class | Purpose |
|-------|---------|
| `ApiResponseConfig` | API error messages and timeout messages |
| `NetworkConfig` | HTTP header management |
| `MaintenanceConfig` | Maintenance screen customization |
| `NoInternetConfig` | Offline screen customization |
| `NotFoundConfig` | 404 screen customization |
| `UnAuthenticatedConfig` | 401 error handling callback |

### Environment Handling

OptiCore does not use explicit environment detection (dev/staging/prod files). Instead, it relies on:

1. **Flutter Build Modes** — Uses Dart's `kDebugMode` constant for debug-specific behavior
2. **Pre-Configuration Callback** — A `prepConfig()` hook runs before the app fully initializes
3. **Runtime Configuration** — Settings can be dynamically updated based on environment needs

### Configuration Access Patterns

- **AppConfig** — Passed explicitly through widget tree (dependency injection style)
- **Settings Configs** — Use static singleton pattern for global access without injection

### Caching & Optimization

- All configuration values are cached in static fields for fast access
- Headers are exposed as unmodifiable maps to prevent accidental mutation
- Updates are rare and atomic — configs are read-heavy by design
- All configs support `resetToDefaults()` for testing scenarios

---

## Services Layer

### Network Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    NETWORK LAYER                         │
├─────────────────────────────────────────────────────────┤
│   ┌─────────────────────────────────────────────────┐  │
│   │                 NetworkHelper                    │  │
│   │                                                  │  │
│   │   Methods: GET, POST, PUT, PATCH, DELETE        │  │
│   │   Features:                                      │  │
│   │     • Connectivity pre-check                    │  │
│   │     • Automatic retry (3 attempts)              │  │
│   │     • SSL certificate pinning                   │  │
│   │     • Progress callbacks                        │  │
│   │     • FormData support                          │  │
│   │     • Configurable timeouts (300s default)      │  │
│   └─────────────────────────────────────────────────┘  │
│                          │                              │
│                          ▼                              │
│   ┌─────────────────────────────────────────────────┐  │
│   │                  Interceptors                    │  │
│   │                                                  │  │
│   │   TalkerDioLogger                               │  │
│   │     • Request/response logging in debug mode    │  │
│   │                                                  │  │
│   │   RetryInterceptor                              │  │
│   │     • Automatic retry with exponential backoff  │  │
│   │                                                  │  │
│   │   DioConnectivityRequest                        │  │
│   │     • Pre-request connectivity check            │  │
│   │     • Request blocking without internet         │  │
│   │                                                  │  │
│   └─────────────────────────────────────────────────┘  │
│                          │                              │
│                          ▼                              │
│   ┌─────────────────────────────────────────────────┐  │
│   │                 ApiResponse<T>                   │  │
│   │                                                  │  │
│   │   Types:                                         │  │
│   │     • success         • serverError             │  │
│   │     • apiError        • networkError            │  │
│   │     • parsingError    • unauthorizedError       │  │
│   │     • noInternetError                           │  │
│   │                                                  │  │
│   └─────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

### Retry Mechanism

The framework implements exponential backoff for transient failures:

| Attempt | Delay |
|---------|-------|
| 1 | 1 second |
| 2 | 3 seconds |
| 3 | 5 seconds |

After three failures, the error propagates to the calling layer.

### Response Handling Flow

```
HTTP Response Received
        │
        ▼
  Status Code Check
        │
        ├── 2xx ──▶ ApiResponse.success(data)
        │
        ├── 401 ──▶ ApiResponse.unauthorizedError()
        │
        ├── 4xx ──▶ ApiResponse.apiError(message)
        │
        ├── 5xx ──▶ ApiResponse.serverError()
        │
        └── Exception ──▶ ApiResponse.networkError()
                              │
                              ▼
                    BaseBloc.handleApiResponse()
                              │
                              ▼
                      Appropriate State Emitted
```

### Repository Pattern

Repositories abstract data sources from business logic:

```
┌──────────────────────────────────────────────────────┐
│                   REPOSITORY LAYER                    │
├──────────────────────────────────────────────────────┤
│                                                      │
│   BaseRepo (Abstract)                                │
│       │                                              │
│       ├── Provides NetworkHelper instance            │
│       ├── Header management utilities                │
│       └── Common data access patterns                │
│                                                      │
│   Domain Repositories (Concrete)                     │
│       │                                              │
│       ├── UserRepository                             │
│       ├── ProductRepository                          │
│       └── OrderRepository                            │
│           │                                          │
│           └── Returns ApiResponse<Model>             │
│                                                      │
└──────────────────────────────────────────────────────┘
```

### Routing System

**RouteHelper** — Centralized navigation service providing:

- Global navigator key access
- Push, replace, pop operations
- Named route navigation
- Previous and current route tracking

**LoggerRouterObserver** — Monitors all navigation events, logs transitions, and maintains route history.

### Global Observers

**GlobalBlocListener** — Monitors all BLoC/Cubit lifecycle events: creation, closure, events, transitions, changes, and errors.

### Extension Points

**BLoC Extensions:**

- Override `onDispose()` for custom cleanup
- Customize API response handling via state factories
- Inject custom error handlers through callbacks

**Repository Extensions:**

- Access NetworkHelper for custom operations
- Dynamic header modification
- Custom request/response transformation

**Screen Customization:**

- Override app bar configuration
- Customize scaffold settings
- Provide custom widgets for loading, error, and data states
- Hook into lifecycle methods

---

## Extensions & Utilities

OptiCore separates reusable functionality into two distinct categories:

- **Extensions** — Enhance existing types by adding methods directly to them
- **Utilities** — Provide standalone services accessed through static calls

### Extension Philosophy

Extensions follow the principle of **type enrichment** — they add behaviors to existing Dart/Flutter types without wrapping or subclassing.

| Characteristic | Description |
|----------------|-------------|
| Pure and stateless | Extensions never hold state or produce side effects |
| Chain-friendly | Methods return values that allow fluent composition |
| Fail-safe | All operations handle null/invalid input gracefully |
| Type-preserving | Generic implementations maintain type safety |

### Extension Categories

**Data Type Extensions:**

- **String** — Format, parse, validate, transform
- **Parse** — Convert strings to typed values (int, double, bool, Map, List)
- **Map** — Safe access with null-coalescing and type conversion
- **List** — Filtering, deduplication, sorting, safe access
- **JSON** — Parse and validate with safety guarantees
- **DateTime** — Date/time parsing and conversion
- **Context** — Access MediaQuery/Theme without boilerplate
- **Navigation** — Route management fluent API
- **Let** — Kotlin-style scope functions (let, letOrElse, also, takeIf)

**UI/Widget Extensions:**

- **Padding** — Shorthand padding helpers
- **Flex** — Fluent expanded and flexible wrappers
- **SizedBox** — Spacer helpers
- **Align** — Alignment convenience methods
- **Visibility** — Conditional visibility
- **Directionality** — Text direction control

### Utility Philosophy

Utilities handle responsibilities that don't belong to any single type — navigation management, toast notifications, network connectivity, logging.

| Characteristic | Description |
|----------------|-------------|
| May hold state | Singletons for caching, rate-limiting, lifecycle management |
| Platform integration | Interface with system APIs and external packages |
| Side-effect producers | Can trigger UI changes, network calls, or logging |
| Centralized access | Static APIs allow dependency-free usage anywhere |

### Utility Categories

**Helper Classes:**

- **RouteHelper** — Navigation with global navigator key, route tracking
- **ToastHelper** — Toast messages with type-based styling
- **ToolsHelper** — Rate-limiting, internet-dependent execution
- **AsyncHelper** — Sequential async execution, animation cancellation
- **ConnectionHelper** — Connectivity checking with caching
- **ClipboardHelper** — Clipboard operations
- **LifecycleEventHelper** — App lifecycle event handling

**General Utilities:**

- **SafeCall** — Safe async execution with error handling and defaults
- **AsyncValue** — State container for async operations (loading, error, data)

**Logger System:**

- **Logger** — Centralized logging with multiple severity levels
- **Log Types** — Critical, Error, Warning, Info, Debug, Good, Verbose, Route

### Extensions vs Utilities

| Aspect | Extensions | Utilities |
|--------|-----------|-----------|
| Purpose | Enhance existing types | Provide domain services |
| Access Pattern | Instance methods (`.method()`) | Static calls (`Class.method()`) |
| State | None (pure functions) | May manage state |
| Side Effects | Never | Common |
| Testing | Pure, easily testable | May require mocking |

### Design Principles

| Principle | Description |
|-----------|-------------|
| Reduce boilerplate | Common patterns should take one line |
| Never crash | Invalid input produces defaults, not exceptions |
| Discoverability | Method names clearly describe what they do |
| Consolidation | Single import files reduce dependency management |
| Type safety | Maintain compile-time checking through generics |

---

## Reusable UI Components

### Component Philosophy

The UI system follows a **layered architecture**:

**Foundation Layer** — Base building blocks handling state observation, content rendering, loading indicators, and error display.

**Reusable Layer** — Purpose-built widgets organized by function: structural components, small utilities, buttons, bottom sheets, and decorative elements.

**Screen Layer** — Full-screen compositions integrating BLoC with lifecycle management, safe areas, and scaffold configuration.

### Composition Strategies

**Configuration-Based Composition** — Screens use config objects that encapsulate all properties, supporting immutable updates via copyWith patterns.

**Declarative Widget Composition** — Builder widgets like StateBuilder and ContentBuilder separate "what to render" from "when to render."

**Structural Composition** — Higher-order widgets like FlexibleListView and LazyIndexedStack accept builder functions for items.

**Behavioral Composition via Mixins** — Cross-cutting concerns like showing loading states or errors are provided through mixins.

### Component Categories

**Layout Structures:**

- `FlexibleGridView` / `FlexibleListView` — Dynamic item sizing
- `LazyIndexedStack` — Memory-efficient tab navigation
- `RefreshView` — Pull-to-refresh wrapper
- `HideOnScroll` — Disappearing headers/footers
- `IndexScroller` / `TopScroller` — Programmatic scrolling

**Interactive Elements:**

- `CoreButton` — Configurable buttons with gradient support
- `CoreSheet` — Platform-appropriate bottom sheets
- `FlexibleCheckBox` — Customizable checkboxes
- `ExpandableText` — Read more/less text

**Display Elements:**

- `SvgWidget` — Multi-source SVG rendering (asset, network, file, string)
- `TruncatedText` — Ellipsis with line limits
- `AdvancedLine` — Solid and dashed lines

**Fallback Screens:**

- `MaintenanceScreen` — System maintenance display
- `NoInternetScreen` — Connectivity loss display
- `NotFoundScreen` — 404 handling
- `RestartWidget` — Application restart trigger

### Widget Composition Example

```
BaseScreen
    │
    └── RefreshView
            │
            └── FlexibleListView
                    │
                    ├── Item 1 ─── CoreButton
                    ├── Item 2 ─── ExpandableText
                    └── Item N ─── SvgWidget
```

### Design Principles

| Principle | How It's Applied |
|-----------|------------------|
| Configuration over Inheritance | Config objects replace deep class hierarchies |
| Composition over Inheritance | Mixins provide shared behavior without coupling |
| Single Responsibility | Each component has one focused purpose |
| Type Safety | Generics ensure compile-time correctness |
| Immutability | Config objects use copyWith for safe updates |
| Lazy Loading | Components like LazyIndexedStack defer work |

---

## Quick Reference

### Request Lifecycle

1. **User Action** → Screen dispatches event via `postEvent()`
2. **Event Processing** → BaseBloc receives and processes event
3. **Network Request** → Repository calls NetworkHelper
4. **Connectivity Check** → Verifies internet connection
5. **HTTP Request** → Dio executes with configured interceptors
6. **Response Handling** → ApiResponse wraps result with type classification
7. **State Emission** → BaseBloc emits appropriate state
8. **UI Update** → ContentBuilder rebuilds based on state type

### State Summary

| State Type | UI Rebuild | Use Case |
|------------|------------|----------|
| RenderDataState | Yes | Display data |
| LoadingStateRender | Yes | Show loading UI |
| ErrorStateRender | Yes | Show error UI |
| InitialState | Yes | Initial screen state |
| LoadingStateNonRender | No | Background loading |
| EndLoadingStateNonRender | No | Background complete |
| ErrorStateNonRender | No | Silent error handling |

### Configuration Summary

| Config | Type | Purpose |
|--------|------|---------|
| AppConfig | Immutable | Theme, routes, locale |
| NetworkConfig | Static | HTTP headers |
| ApiResponseConfig | Singleton | Error messages |
| MaintenanceConfig | Singleton | Maintenance screen |
| NoInternetConfig | Singleton | Offline screen |
| NotFoundConfig | Singleton | 404 screen |
| UnAuthenticatedConfig | Singleton | 401 handling |

### Module Summary

| Module | Purpose |
|--------|---------|
| Config | Application configuration |
| Core | Framework abstractions and base classes |
| Services | Network and external service integration |
| Reusable | Production-ready UI components |
| Utils | Helpers, loggers, formatters |
| Extensions | 70+ type enhancements |

---

*OptiCore v2.2.0 | MIT License | Created by Mahmoud El Shenawy*
