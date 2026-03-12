# 🚀 OptiCore Functionality

Enhance your Flutter development workflow with **OptiCore** – a lightweight micro-framework that provides powerful utilities, extensions, and reusable components to streamline development.

---

## 🛠 Utilities

### ⚡ Asynchronous Operations

#### 🔄 `AsyncValue`

- Manages **loading**, **success**, and **error** states for async operations.
- ✅ `guard`: Safely executes async functions and wraps results in `AsyncValue`.

#### 🔹 `AsyncBloc`

- A generic **BLoC** for handling async operations efficiently.
- 🚀 `execute`: Runs async tasks and updates state automatically.

#### 📌 Async States

- **`AsyncInitial`** – Initial state before an async task starts.
- **`AsyncLoading`** – Indicates an ongoing async operation.
- **`AsyncData`** – Represents a successful async result.
- **`AsyncError`** – Captures errors occurring in async processes.

---

## 🔒 Safe Execution

#### 🛡 `SafeCall`

- Executes async operations **without throwing exceptions**.
- 🛠 `execute`: Runs a function safely, returning a fallback value if it fails.

---

## 🔹 Helpers & Utilities

### ⏳ `AsyncHelper`

- 📌 `executeSequentially`: Ensures async functions execute **one after another**.
- 🚫 `catchAnimationCancel`: Prevents animation cancellation errors.

### 📋 `ClipboardHelper`

- 📌 `copyText`: Copies text to the clipboard.
- 📌 `pasteText`: Retrieves clipboard content.
- 📌 `copyWithResult`: Copies text with success verification.
- 📌 `getClipboardData`: Fetches raw clipboard data.

### 🌐 `InternetConnectionHandler`

- ✅ `isInternetConnected`: Checks for internet access.
- 🔄 `internetConnectionStatusStream`: Listens for real-time connection changes.
- 🚀 `startListeningToConnectivity`: Monitors internet connectivity.

### 🔄 `LifecycleEventHelper`

- 📌 Handles **app lifecycle events** (`resumed`, `suspended`).

### 🔀 `RouteHelper`

- Manages **navigation logic** with simplified route handling.
- 🚀 Supports `push`, `pushNamed`, `pop`, `canPop`, and more.

### 🎚 Scroll Helpers

#### 📜 `ScrollBehaviorHelper`

- 📌 Defines **platform-specific scroll physics**.
- 🖱 **Multi-touch drag strategy** for seamless interaction.

#### 🔄 `SnapScrollSize`

- Ensures **precise scrolling** by implementing snapping physics.

### ⌨ `TextInputHelper`

- ✍ `handleEgyptPhoneInput`: **Formats Egyptian phone numbers** by removing `0` after `+20`.

### 🔔 `ToastHelper`

- Displays **custom toast messages** using `BotToast`.
- 🚀 Supports `success`, `error`, `info`, and `warning` messages.

### 🔧 `ToolsHelper`

- 🚀 `stopRepeating`: Prevents rapid function execution.
- 🌍 `triggerWithInternet`: Runs tasks only when online.

---

## 🏗 Text Input Formatters

### ✍ `CapitalizeFirstWordFormatter`

- ✅ **Capitalizes the first letter** in input fields.

### 🔢 `ArabicToEnglishNumberFormatter`

- ✅ **Converts Arabic numerals** to English.

### 📞 `EgyptPhoneNumberInputFormatter`

- ✅ **Formats Egyptian phone numbers** (`+20` support).

### ↔ `ForceLTRInputFormatter`

- ✅ **Forces text direction** to **Left-to-Right (LTR)**.

---

🚀 **OptiCore minimizes development time, enhances app performance, and simplifies complex tasks.**  

📌 **More details available in:**  

- 📖 **[Readme](../README.md)** – Full documentation covering features & usage.

Start **building smarter** with OptiCore today! 🎯  
