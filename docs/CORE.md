# 🚀 OptiCore - Core Framework

**OptiCore** is a **lightweight BLoC-based micro-framework** that simplifies state management, UI handling, and error classification. It provides a structured foundation for building scalable and efficient Flutter applications.

---

## 🏗️ Core Components

### 🔹 BLoC Architecture

#### 🏛️ BaseBloc

A foundational **BLoC** class for managing application state transitions.

✅ **Features:**

- Centralized handling of **API responses** and automatic state transitions.
- Built-in **error classification** for consistent error handling.
- Integrated **navigation utilities** for redirecting to error screens (`NoInternetScreen`, `MaintenanceScreen`).
- **Lifecycle management** to ensure proper resource cleanup.

---

### 📱 BaseScreen

An abstract class for managing **UI scenes** with **BLoC integration**.

✅ **Features:**

- Simplifies **state management** using the **BLoC pattern**.
- Provides **utility methods** for:
  - Showing **toasts & snackbars**.
  - Handling **loading indicators**.
  - **Keyboard focus management**.
- Supports **dynamic UI rendering** based on state changes.
- Fully **customizable scaffold** and app bar.

#### 🖼 BaseView

A reusable **UI handler** that abstracts the setup of a Flutter screen.

✅ **Features:**

- Automates **BLoC provider setup**.
- Reduces boilerplate by managing common **UI states** (`Loading`, `Error`, `Success`).
- Allows defining **custom app bars, scaffolds, and layouts**.

#### 🎨 CoreAppBar

A customizable **app bar widget** for consistent UI structure.

✅ **Features:**

- Supports **dynamic titles, actions, and back navigation**.
- Configurable to match different **app themes and layouts**.
- **Integrated accessibility** for better user experience.

#### 🏗 ScaffoldConfig

A flexible configuration model for defining **app-wide scaffold behavior**.

✅ **Features:**

- Standardizes **page layouts**.
- Provides easy access to **global UI properties**.

#### 🏷 AppBarConfig

A structured configuration model for **app bars**.

✅ **Features:**

- Standardizes **app bar behavior**.
- Ensures **consistent UI patterns** across the app.

---

### 📢 Event Handling

#### ⚡ BaseEvent

A foundational class for defining **events** in the **BLoC** architecture.

✅ **Features:**

- Provides a **modular structure** for handling event-driven logic.
- Ensures a **clean separation of concerns** between **UI** and **business logic**.

---

### 🔄 State Management

#### 🏗 BaseFactory

An abstract class for generating **states** dynamically.

✅ **Features:**

- Provides a **contract** for state generation.
- Enables **flexible and dynamic** state creation.

#### 📍 DefaultState

A **fallback state** used when no specific state can be determined.

✅ **Features:**

- Serves as a **neutral state**.
- Ensures app stability when no concrete state is available.

#### 🔧 DefaultFactory

A concrete implementation of `BaseFactory` that provides a **default state** when no specific state is available.

✅ **Features:**

- Handles **null state scenarios** gracefully.
- Returns a **valid default state** for smoother transitions.

---

### 🌍 Global State Observation

#### 👀 GlobalBlocListener

A **global BLoC observer** that tracks all BLoC and Cubit lifecycle events.

✅ **Features:**

- Logs detailed **lifecycle events** of Blocs and Cubits.
- Provides **error formatting** for better debugging.
- Implements a **consistent tagging system** for easy log filtering.

---

### 📡 Repository Layer

#### 🌐 BaseRepo

A base repository class that simplifies **network operations**.

✅ **Features:**

- Manages **global headers** for API requests.
- Uses a **`NetworkHelper`** for handling API calls.
- Supports **customizable header updates**.
- Ensures **resource cleanup** when the repository is disposed.

---

## 🛠️ State System

### 🔹 General States

#### 📌 BaseState

A foundational state class for defining **various conditions** in the app.

✅ **Features:**

- Provides a **unified structure** for managing app states.
- Enables **modular state definitions**.

#### 📊 DataState

A state containing **data of type `M`**.

✅ **Features:**

- Stores and manages **fetched or processed data**.
- Debug-friendly **string representation** for logging.

#### 🚨 ErrorState

A structured **error state** with a customizable **error message**.

✅ **Features:**

- Captures and represents **network, validation, and system errors**.
- Includes a `isWarning` flag to **differentiate errors from warnings**.
- Provides **debugging support**.

---

### 🔹 Error Classification

#### 🏷 ErrorType

A centralized model for **error categorization**.

✅ **Features:**

- **Predefined error categories**:
  - `render`: **UI rendering issues**.
  - `nonRender`: **Non-UI errors**.
  - `none`: **General uncategorized errors**.
- Ensures **consistent error handling**.

---

### 🎨 Render States

#### 🎭 RenderState

A base class for UI states that **trigger UI updates**.

✅ **Features:**

- Provides **UI update management**.
- Ensures a **clean separation** between UI-related and non-UI states.

#### 📊 RenderDataState

A state that **holds data** ready for rendering.

✅ **Features:**

- Stores **processed data** for UI components.

#### ⏳ LoadAnimationState

A state representing an **ongoing animation**.

✅ **Features:**

- Indicates **when an animation is loading**.

#### 🔄 LoadingStateRender

A UI state indicating **loading progress**.

✅ **Features:**

- Provides a **visual loading indicator**.

#### 🚨 ErrorStateRender

A state that represents an **error or warning** affecting UI rendering.

✅ **Features:**

- Captures **UI-related errors**.
- Supports:
  - **Error messages**.
  - **Warning flags**.
  - **Unauthorized access detection**.

---

### 🔄 Non-Render States

#### 🏗 NonRenderState

A base class for **states that do not trigger UI updates**.

✅ **Features:**

- Manages **background logic** separately from UI.

#### ⏳ LoadingStateNonRender

Represents a **background loading process**.

✅ **Features:**

- Used for **non-UI related operations**.

#### ✅ EndLoadingStateNonRender

Represents the **end of a background process**.

✅ **Features:**

- Signals that **background tasks** are completed.

#### ❌ ErrorStateNonRender

A state representing a **background process error**.

✅ **Features:**

- Handles **network & system errors** without UI updates.
- Supports:
  - **Error messages**.
  - **API response type detection**.

---

## 📖 Conclusion

🚀 **OptiCore** provides a structured, scalable, and optimized **Flutter development** experience. With its **BLoC-driven architecture, built-in error handling, and reusable components**, it ensures efficiency and maintainability.

📌 **Further Documentation:**

- **[Readme](../README.md)** – Overview of utilities and features.
